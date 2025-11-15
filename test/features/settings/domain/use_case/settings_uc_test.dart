import 'package:flutter_test/flutter_test.dart';
import 'package:vision_xai/features/settings/domain/entity/settings_entity.dart';
import 'package:vision_xai/features/settings/domain/use_case/settings_uc.dart';
import 'package:vision_xai/features/settings/domain/repository/settings_repo.dart';

class _FakeRepo implements SettingsFeatureRepo {
  SettingsEntity? lastSaved;
  SettingsEntity toReturn;

  _FakeRepo({SettingsEntity? initial})
      : toReturn = initial ??
            const SettingsEntity(ip: '127.0.0.1', port: '8000', locale: 'en');

  @override
  Future<SettingsEntity> load() async => toReturn;

  @override
  Future<void> save(SettingsEntity entity) async {
    lastSaved = entity;
    toReturn = entity;
  }
}

void main() {
  test('SettingsFeatureUC delegates to repo', () async {
    final fake = _FakeRepo();
    final uc = SettingsFeatureUC(fake);

    final loaded = await uc.load();
    expect(loaded.ip, '127.0.0.1');

    const newEntity = SettingsEntity(ip: '1.2.3.4', port: '1234', locale: 'bn');
    await uc.save(newEntity);
    final after = await uc.load();
    expect(after.ip, '1.2.3.4');
    expect(fake.lastSaved, equals(newEntity));
  });
}
