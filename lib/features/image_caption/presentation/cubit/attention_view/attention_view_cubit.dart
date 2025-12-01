import 'package:bloc/bloc.dart';

/// Cubit that holds the selected token index for the AttentionView.
class AttentionViewCubit extends Cubit<int?> {
  AttentionViewCubit() : super(null);

  /// Toggle selection: if [index] is already selected, clear selection.
  void toggle(int index) {
    if (state == index) {
      emit(null);
    } else {
      emit(index);
    }
  }

  void clear() => emit(null);
}
