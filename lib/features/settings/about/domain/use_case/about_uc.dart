import '../entity/about_entity.dart';
import '../repository/about_repo.dart';

class AboutUC {
  final AboutRepo _repo;

  AboutUC(this._repo);

  Future<AboutEntity> load() => _repo.loadAppInfo();
}
