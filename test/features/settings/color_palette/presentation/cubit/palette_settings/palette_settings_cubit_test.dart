import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:vision_xai/features/settings/color_palette/presentation/cubit/palette_settings/palette_settings_cubit.dart';
import 'package:vision_xai/features/settings/color_palette/domain/use_case/palette_uc.dart';
import 'package:vision_xai/features/settings/color_palette/domain/repository/palette_repo.dart';
import 'package:vision_xai/features/settings/color_palette/presentation/cubit/palette/palette_cubit.dart';

class _FakeRepo implements PaletteRepo {
  @override
  Future<Map<String, Color>> generatePalette(ImageProvider image) async {
    return {
      'primary': Colors.white,
      'secondary': Colors.white,
      'background': Colors.white,
    };
  }
}

class _FakeUC extends PaletteUC {
  _FakeUC() : super(_FakeRepo());
}

class _FakePaletteCubit extends PaletteCubit {
  int updateCalled = 0;
  _FakePaletteCubit() : super(_FakeUC());
  @override
  Future<void> updateColors() async {
    updateCalled++;
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('PaletteSettingsCubit persistence', () {
    late Directory tmpDir;

    setUp(() async {
      tmpDir = Directory.systemTemp.createTempSync('hive_test_');
      Hive.init(tmpDir.path);
      await Hive.openBox('palette');
    });

    tearDown(() async {
      final box = Hive.box('palette');
      await box.clear();
      await box.close();
      try {
        tmpDir.deleteSync(recursive: true);
      } catch (_) {}
    });

    test('loadOverrides reads stored overrides', () async {
      final box = Hive.box('palette');
      await box.putAll({'primary': '#112233'});

      final cubit = PaletteSettingsCubit(_FakePaletteCubit());
      await cubit.loadOverrides();
      expect(cubit.state.overrides, isNotNull);
      expect(cubit.state.overrides!['primary'], equals('#112233'));
    });

    test('saveOverrides persists overrides and triggers updateColors',
        () async {
      final fakePalette = _FakePaletteCubit();
      final cubit = PaletteSettingsCubit(fakePalette);
      final overrides = {'primary': '#AABBCC', 'secondary': '#DDEEFF'};

      await cubit.saveOverrides(overrides);

      final box = Hive.box('palette');
      expect(box.get('primary'), equals('#AABBCC'));
      expect(box.get('secondary'), equals('#DDEEFF'));
      expect(fakePalette.updateCalled, greaterThanOrEqualTo(1));
    });

    test('clearOverrides clears box and triggers updateColors', () async {
      final box = Hive.box('palette');
      await box.putAll({'primary': '#010101'});
      final fakePalette = _FakePaletteCubit();
      final cubit = PaletteSettingsCubit(fakePalette);

      await cubit.clearOverrides();

      expect(box.get('primary'), isNull);
      expect(fakePalette.updateCalled, greaterThanOrEqualTo(1));
    });
  });
}
