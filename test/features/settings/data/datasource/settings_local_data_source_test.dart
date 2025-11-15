import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:vision_xai/features/settings/data/datasource/local/settings_local_data_source.dart';
import 'package:vision_xai/features/settings/data/model/settings_model.dart';

void main() {
  late Directory tmpDir;
  setUpAll(() async {
    tmpDir = await Directory.systemTemp.createTemp('hive_test');
    Hive.init(tmpDir.path);
  });

  test('SettingsLocalDataSource save/load round-trip uses exact keys',
      () async {
    // open a temp test box
    final box = await Hive.openBox('test_settings_box');
    // ensure empty
    await box.clear();

    final ds = SettingsLocalDataSource(box: box);

    final model = const SettingsModel(ip: '10.0.0.5', port: '4242', locale: 'fr');
    await ds.save(model);

    // read raw via box.get to ensure keys are stored
    final ipRaw = box.get('ip');
    final portRaw = box.get('port');
    final localeRaw = box.get('locale');

    expect(ipRaw, '10.0.0.5');
    expect(portRaw, '4242');
    expect(localeRaw, 'fr');

    // Now load via datasource and verify values
    final loaded = await ds.load();
    expect(loaded.ip, '10.0.0.5');
    expect(loaded.port, '4242');
    expect(loaded.locale, 'fr');

    await box.clear();
    await box.close();
    await tmpDir.delete(recursive: true);
  });
}
