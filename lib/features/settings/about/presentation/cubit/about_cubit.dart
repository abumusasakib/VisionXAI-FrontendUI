import 'package:bloc/bloc.dart';

import '../../domain/use_case/about_uc.dart';
import 'about_state.dart';

class AboutCubit extends Cubit<AboutState> {
  final AboutUC _useCase;

  AboutCubit(this._useCase) : super(AboutState.loading());

  Future<void> loadAppInfo() async {
    final info = await _useCase.load();
    emit(AboutState(appVersion: info.appVersion, platform: info.platform));
  }
}
