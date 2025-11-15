import '../../domain/entity/about_entity.dart';
import '../model/about_model.dart';

class AboutMapper {
  const AboutMapper();

  AboutEntity modelToEntity(AboutModel m) =>
      AboutEntity(appVersion: m.appVersion, platform: m.platform);

  AboutModel entityToModel(AboutEntity e) =>
      AboutModel(appVersion: e.appVersion, platform: e.platform);
}
