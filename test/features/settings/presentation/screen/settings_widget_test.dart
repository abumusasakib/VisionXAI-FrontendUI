import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:vision_xai/features/settings/presentation/screen/settings_screen.dart';
import 'package:vision_xai/features/settings/presentation/cubit/settings_feature_cubit.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:vision_xai/features/settings/domain/entity/settings_entity.dart';
import 'package:vision_xai/features/settings/domain/use_case/settings_uc.dart';
import 'package:vision_xai/l10n/app_localizations.dart';

class _FakeUC implements SettingsFeatureUC {
  SettingsEntity stored;
  _FakeUC(this.stored);
  @override
  Future<SettingsEntity> load() async => stored;
  @override
  Future<void> save(SettingsEntity entity) async {
    stored = entity;
  }
}

class TestSettingsCubit extends SettingsFeatureCubit {
  final SettingsEntity initial;
  TestSettingsCubit(this.initial) : super(_FakeUC(initial));

  @override
  Future<void> load() async {
    emit(initial);
  }

  @override
  Future<void> save(SettingsEntity entity) async {
    emit(entity);
  }
}

void main() {
  testWidgets('Settings screen loads and shows values', (tester) async {
    const initial = SettingsEntity(ip: '1.1.1.1', port: '1234', locale: 'en');
    final cubit = TestSettingsCubit(initial);

    await tester.pumpWidget(MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: BlocProvider<SettingsFeatureCubit>.value(
        value: cubit,
        child: const SettingsFeatureScreen(),
      ),
    ));

    // Initially, no settings loaded text should be present
    expect(find.text('No settings loaded'), findsOneWidget);

    // Trigger load on the cubit and allow it to emit
    await cubit.load();
    await tester.pumpAndSettle();

    // Should show the loaded values (check actual values appear)
    expect(find.textContaining('1.1.1.1'), findsOneWidget);
    expect(find.textContaining('1234'), findsOneWidget);
  });
}
