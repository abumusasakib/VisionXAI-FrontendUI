import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:vision_xai/features/settings/color_palette/presentation/screen/palette_settings_screen.dart';
import 'package:vision_xai/core/services/dialog_service.dart';
import 'package:vision_xai/core/services/global_ui_service.dart';
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
        status: PaletteSettingsStatus.success,
        overrides: overrides,
        message: 'Overrides saved'));
  }

  @override
  Future<void> clearOverrides() async {
    cleared = true;
    emit(state.copyWith(
        status: PaletteSettingsStatus.success,
        overrides: null,
        message: 'Overrides cleared'));
  }

  @override
  Future<void> saveNamedPreset(String name, Map<String, String> colors) async {
    lastSaved = colors;
    emit(state.copyWith(
        status: PaletteSettingsStatus.success, message: 'Preset saved'));
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
        navigatorKey: GlobalUiService.navigatorKey,
        scaffoldMessengerKey: GlobalUiService.scaffoldMessengerKey,
        home: MultiBlocProvider(providers: [
          BlocProvider<PaletteCubit>(create: (_) => paletteCubit),
          BlocProvider<PaletteSettingsCubit>(create: (_) => settingsCubit),
        ], child: const PaletteSettingsScreen()),
      ));

      await tester.pumpAndSettle();

      // Open the color picker dialog using the dialog service so the test
      // doesn't rely on the IconButton finder. Use the global navigator
      // key we provided to MaterialApp.
      DialogService.showColorPicker(null,
          initialColor: Colors.red, title: 'Pick a color');
      await tester.pumpAndSettle();

      expect(find.text('Pick a color'), findsOneWidget);
    });

    testWidgets('saving a preset shows snackbar', (tester) async {
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
        navigatorKey: GlobalUiService.navigatorKey,
        scaffoldMessengerKey: GlobalUiService.scaffoldMessengerKey,
        home: MultiBlocProvider(providers: [
          BlocProvider<PaletteCubit>(create: (_) => paletteCubit),
          BlocProvider<PaletteSettingsCubit>(create: (_) => settingsCubit),
        ], child: const PaletteSettingsScreen()),
      ));

      await tester.pumpAndSettle();

      // Simulate saving a named preset via the cubit. The widget listens
      // for `state.message` and shows a snackbar when set.
      final colors = {
        'primary': '#FF0000',
        'secondary': '#00FF00',
        'background': '#0000FF',
      };
      await settingsCubit.saveNamedPreset('test', colors);
      await tester.pumpAndSettle();

      expect(find.text('Preset saved'), findsOneWidget);
    });

    testWidgets('saving overrides shows snackbar', (tester) async {
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
        navigatorKey: GlobalUiService.navigatorKey,
        scaffoldMessengerKey: GlobalUiService.scaffoldMessengerKey,
        home: MultiBlocProvider(providers: [
          BlocProvider<PaletteCubit>(create: (_) => paletteCubit),
          BlocProvider<PaletteSettingsCubit>(create: (_) => settingsCubit),
        ], child: const PaletteSettingsScreen()),
      ));

      await tester.pumpAndSettle();

      final overrides = {
        'primary': '#111111',
        'secondary': '#222222',
        'background': '#333333',
      };
      await settingsCubit.saveOverrides(overrides);
      await tester.pumpAndSettle();

      expect(find.text('Overrides saved'), findsOneWidget);
    });

    testWidgets('clearing overrides shows snackbar', (tester) async {
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
        navigatorKey: GlobalUiService.navigatorKey,
        scaffoldMessengerKey: GlobalUiService.scaffoldMessengerKey,
        home: MultiBlocProvider(providers: [
          BlocProvider<PaletteCubit>(create: (_) => paletteCubit),
          BlocProvider<PaletteSettingsCubit>(create: (_) => settingsCubit),
        ], child: const PaletteSettingsScreen()),
      ));

      await tester.pumpAndSettle();

      await settingsCubit.clearOverrides();
      await tester.pumpAndSettle();

      expect(find.text('Overrides cleared'), findsOneWidget);
    });
  });
}
