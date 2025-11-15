import '../entity/about_entity.dart';

abstract class AboutRepo {
  Future<AboutEntity> loadAppInfo();
}
