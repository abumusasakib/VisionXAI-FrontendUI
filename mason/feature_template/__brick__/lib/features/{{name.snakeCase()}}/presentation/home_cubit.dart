import 'dart:async';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

import '../cubit/{{name.snakeCase()}}_cubit.dart';
import 'home_state.dart';

/// Feature-scoped Home cubit that delegates network work to the feature's
/// generated cubit and manages a `CancelToken` for cancellation from the UI.
class HomeCubit extends Cubit<HomeState> {
  final {{name.pascalCase()}}Cubit imageCubit;
  CancelToken? _cancelToken;

  HomeCubit(this.imageCubit) : super(HomeState.initial());

  void selectImage(dynamic pickedFile) {
    emit(state.copyWith(imageFile: pickedFile));
  }

  Future<void> uploadAndGenerateCaption(dynamic context) async {
    if (state.imageFile == null) return;

    _cancelToken = CancelToken();
    emit(state.copyWith(status: HomeStatus.loading));

    final bytes = state.imageFile.bytes as Uint8List;
    final filename = state.imageFile.name as String;

    // Delegate to the feature cubit which performs the network/upload work.
    await imageCubit.call(bytes, filename, cancelToken: _cancelToken);

    // Listen for the terminal result and update UI state accordingly.
    final sub = imageCubit.stream.listen((event) {
      if (event is {{name.pascalCase()}}Success) {
        sub.cancel();
        emit(state.copyWith(status: HomeStatus.success, testOutput: event.caption));
      } else if (event is {{name.pascalCase()}}Error) {
        sub.cancel();
        emit(state.copyWith(status: HomeStatus.failure, testOutput: event.message));
      }
    });
  }

  void stopCaptionGeneration() {
    if (_cancelToken?.isCancelled == false) _cancelToken?.cancel();
    _cancelToken = null;
    emit(state.copyWith(status: HomeStatus.canceled));
  }
}
