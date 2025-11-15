import 'package:flutter_test/flutter_test.dart';
import 'package:vision_xai/features/settings/about/domain/use_case/about_uc.dart';
import 'package:vision_xai/features/settings/about/domain/entity/about_entity.dart';
import 'package:vision_xai/features/settings/about/domain/repository/about_repo.dart';

class _FakeAboutRepo implements AboutRepo {
  final AboutEntity _entity;

  _FakeAboutRepo(this._entity);

  @override
  Future<AboutEntity> loadAppInfo() async => _entity;
}

void main() {
  test('AboutUC returns entity provided by repository', () async {
    const expected = AboutEntity(appVersion: '1.0.0 (1)', platform: 'TestOS');
    final uc = AboutUC(_FakeAboutRepo(expected));

    final result = await uc.load();

    expect(result.appVersion, expected.appVersion);
    expect(result.platform, expected.platform);
  });
}
