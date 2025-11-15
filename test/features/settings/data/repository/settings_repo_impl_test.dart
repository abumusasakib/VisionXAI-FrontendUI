import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';

import 'package:vision_xai/features/settings/data/repository/settings_repo_impl.dart';
import 'package:vision_xai/features/settings/domain/entity/settings_entity.dart';
import 'package:vision_xai/features/settings/data/datasource/local/settings_local_data_source.dart';
import 'package:vision_xai/features/settings/data/mapper/settings_mapper.dart';

void main() {
  group('SettingsFeatureRepoImpl', () {
    late Directory tmpDir;

    setUp(() async {
      tmpDir = await Directory.systemTemp.createTemp('hive_test_');
      Hive.init(tmpDir.path);
      await Hive.openBox('settings');
    });

    tearDown(() async {
      final box = Hive.box('settings');
      await box.clear();
      await box.close();
      await Hive.close();
      await tmpDir.delete(recursive: true);
    });

    test('save and load roundtrip', () async {
      final box = Hive.box('settings');
      final local = SettingsLocalDataSource(box: box);
      const mapper = SettingsMapper();
      final repo = SettingsFeatureRepoImpl(local: local, mapper: mapper);

      const entity = SettingsEntity(ip: '10.0.0.5', port: '9000', locale: 'en');

      await repo.save(entity);

      final loaded = await repo.load();

      expect(loaded.ip, equals('10.0.0.5'));
      expect(loaded.port, equals('9000'));
      expect(loaded.locale, equals('en'));
    });
  });
}
