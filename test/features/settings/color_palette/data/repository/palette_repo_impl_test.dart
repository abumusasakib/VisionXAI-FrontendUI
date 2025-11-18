import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/painting.dart';
import 'package:hive/hive.dart';
import 'package:vision_xai/features/settings/color_palette/data/repository/palette_repo_impl.dart';
import 'package:vision_xai/features/settings/color_palette/core/palette_manager.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('PaletteRepoImpl persistence', () {
    setUp(() async {
      final tmp = Directory.systemTemp.createTempSync('hive_test_');
      Hive.init(tmp.path);
      await Hive.openBox('palette');
    });

    tearDown(() async {
      final box = Hive.box('palette');
      await box.clear();
      await box.close();
    });

    test('returns overrides when present', () async {
      final box = Hive.box('palette');
      final overrides = {
        'primary': '#112233',
        'secondary': '#445566',
        'background': '#778899',
      };
      await box.putAll(overrides);

      final repo = PaletteRepoImpl();
      final result = await repo.generatePalette(MemoryImage(Uint8List(0)));

      expect(result['primary'],
          equals(PaletteManager.getWebSafeColorFromHex('#112233')));
      expect(result['secondary'],
          equals(PaletteManager.getWebSafeColorFromHex('#445566')));
      expect(result['background'],
          equals(PaletteManager.getWebSafeColorFromHex('#778899')));
    });
  });
}
