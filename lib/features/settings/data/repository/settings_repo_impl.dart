import '../../domain/entity/settings_entity.dart';
import '../../domain/repository/settings_repo.dart';
import '../datasource/local/settings_local_data_source.dart';
import '../mapper/settings_mapper.dart';
import '../model/settings_model.dart';

class SettingsFeatureRepoImpl implements SettingsFeatureRepo {
  final SettingsLocalDataSource local;
  final SettingsMapper mapper;

  SettingsFeatureRepoImpl({required this.local, required this.mapper});

  @override
  Future<SettingsEntity> load() async {
    final SettingsModel model = await local.load();
    return mapper.toEntity(model);
  }

  @override
  Future<void> save(SettingsEntity entity) async {
    final model = mapper.fromEntity(entity);
    await local.save(model);
  }
}
