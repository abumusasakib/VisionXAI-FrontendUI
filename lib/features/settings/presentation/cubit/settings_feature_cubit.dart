import 'package:bloc/bloc.dart';

import '../../domain/entity/settings_entity.dart';
import '../../domain/use_case/settings_uc.dart';

class SettingsFeatureCubit extends Cubit<SettingsEntity?> {
  final SettingsFeatureUC _useCase;

  SettingsFeatureCubit(this._useCase) : super(null);

  Future<void> load() async {
    final s = await _useCase.load();
    emit(s);
  }

  Future<void> save(SettingsEntity entity) async {
    await _useCase.save(entity);
    emit(entity);
  }
}
