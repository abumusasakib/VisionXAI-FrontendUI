import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:vision_xai/features/settings/color_palette/presentation/screen/palette_settings_screen.dart';
import 'package:vision_xai/features/settings/color_palette/presentation/cubit/palette_settings/palette_settings_state.dart';
import 'package:vision_xai/features/settings/color_palette/presentation/cubit/palette_settings/palette_settings_cubit.dart';
import 'package:vision_xai/features/settings/color_palette/presentation/cubit/palette/palette_cubit.dart';
import 'package:vision_xai/features/settings/color_palette/domain/use_case/palette_uc.dart';
import 'package:vision_xai/features/settings/color_palette/domain/repository/palette_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vision_xai/l10n/app_localizations.dart';

class _FakeRepo implements PaletteRepo {
  @override
  Future<Map<String, Color>> generatePalette(ImageProvider image) async {
    return {
      'primary': Colors.red,
      'secondary': Colors.green,
      'background': Colors.blue,
    };
  }
}

class _FakeUC extends PaletteUC {
  _FakeUC() : super(_FakeRepo());
}

class _FakePaletteCubit extends PaletteCubit {
  _FakePaletteCubit() : super(_FakeUC());
  int updateCalled = 0;
  @override
  Future<void> updateColors() async {
    updateCalled++;
  }
}

class TestSettingsCubit extends PaletteSettingsCubit {
  Map<String, String>? lastSaved;
  bool cleared = false;

  TestSettingsCubit() : super(_FakePaletteCubit());

  @override
  Future<void> saveOverrides(Map<String, String> overrides) async {
    lastSaved = overrides;
    emit(state.copyWith(
        status: PaletteSettingsStatus.success, overrides: overrides));
  }

  @override
  Future<void> clearOverrides() async {
    cleared = true;
    emit(
        state.copyWith(status: PaletteSettingsStatus.success, overrides: null));
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('PaletteSettingsScreen widget', () {
    late Directory tmpDir;

    setUp(() async {
      tmpDir = Directory.systemTemp.createTempSync('hive_widget_test_');
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

    testWidgets('color picker dialog opens', (tester) async {
      final paletteCubit = PaletteCubit(_FakeUC());
      final settingsCubit = TestSettingsCubit();

      await tester.pumpWidget(MaterialApp(
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        locale: const Locale('en'),
        home: MultiBlocProvider(providers: [
          BlocProvider<PaletteCubit>(create: (_) => paletteCubit),
          BlocProvider<PaletteSettingsCubit>(create: (_) => settingsCubit),
        ], child: const PaletteSettingsScreen()),
      ));

      await tester.pumpAndSettle();

      final pickerButton = find.byIcon(Icons.colorize).first;
      await tester.tap(pickerButton);
      await tester.pumpAndSettle();

      expect(find.text('Pick a color'), findsOneWidget);
    });
  });
}
