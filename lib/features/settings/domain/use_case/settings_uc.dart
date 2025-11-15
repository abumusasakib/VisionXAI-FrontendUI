import '../entity/settings_entity.dart';
import '../repository/settings_repo.dart';

class SettingsFeatureUC {
  final SettingsFeatureRepo _repo;

  SettingsFeatureUC(this._repo);

  Future<SettingsEntity> load() => _repo.load();

  Future<void> save(SettingsEntity entity) => _repo.save(entity);
}
