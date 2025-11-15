import '../entity/settings_entity.dart';

abstract class SettingsFeatureRepo {
  Future<SettingsEntity> load();
  Future<void> save(SettingsEntity entity);
}
