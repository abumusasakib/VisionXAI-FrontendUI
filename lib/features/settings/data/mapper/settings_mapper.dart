import '../../domain/entity/settings_entity.dart';
import '../model/settings_model.dart';

class SettingsMapper {
  const SettingsMapper();

  SettingsEntity toEntity(SettingsModel model) => SettingsEntity(
        ip: model.ip,
        port: model.port,
        locale: model.locale,
      );

  SettingsModel fromEntity(SettingsEntity entity) => SettingsModel(
        ip: entity.ip,
        port: entity.port,
        locale: entity.locale,
      );
}
