import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:vision_xai/core/services/notification_service.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:vision_xai/features/image_caption/presentation/screen/home_screen.dart';
import 'package:vision_xai/features/image_caption/presentation/cubit/home/home_cubit.dart';
import 'package:vision_xai/features/image_caption/presentation/cubit/image_caption/image_caption_cubit.dart';
import 'package:vision_xai/features/image_caption/domain/use_case/image_caption_uc.dart';
import 'package:vision_xai/features/image_caption/domain/repository/image_caption_repo.dart';
import 'package:vision_xai/features/image_caption/domain/entity/image_caption_entity.dart';
import 'package:vision_xai/features/image_caption/domain/entity/image_caption_entity_group.dart';
import 'package:vision_xai/features/settings/presentation/cubit/settings_feature_cubit.dart';
import 'package:vision_xai/features/settings/domain/use_case/settings_uc.dart';
import 'package:vision_xai/features/settings/domain/repository/settings_repo.dart';
import 'package:vision_xai/features/settings/domain/entity/settings_entity.dart';
import 'package:vision_xai/features/settings/color_palette/presentation/cubit/palette/palette_cubit.dart';
import 'package:vision_xai/features/settings/color_palette/core/di/color_palette_injection.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:vision_xai/l10n/app_localizations.dart';

class _DummyRepo implements ImageCaptionRepo {
  @override
  Future<Either<Exception, ImageCaptionEntityGroup>> call(
      Uint8List imageBytes, String filename,
      {CancelToken? cancelToken}) async {
    // Return a successful entity with a simple caption attribute
    const e = ImageCaptionEntity(attributes: {'caption': 'ok'});
    return right(const ImageCaptionEntityGroup.success(e));
  }
}

class _DummySettingsRepo implements SettingsFeatureRepo {
  @override
  Future<SettingsEntity> load() async {
    // Provide a default settings entity
    return const SettingsEntity(ip: '127.0.0.1', port: '8000', locale: 'en');
  }

  @override
  Future<void> save(SettingsEntity entity) async {}
}

void main() {
  testWidgets('Home can show SnackBar via NotificationService from AppDi',
      (tester) async {
    // Build minimal objects that resemble AppDi's notification service
    final notificationService = NotificationServiceImpl();

    // Minimal ImageCaption use-case/cubit wiring
    final repo = _DummyRepo();
    final uc = ImageCaptionUC(repo);
    final imageCaptionCubit = ImageCaptionCubit(uc);

    // Create HomeCubit with injected notification service
    final homeCubit =
        HomeCubit(imageCaptionCubit, notificationService: notificationService);

    // Simple local appDi-like holder
    final appDi = {'notificationService': notificationService};

    // Settings + palette cubits to satisfy Home widget listeners
    final settingsRepo = _DummySettingsRepo();
    final settingsUC = SettingsFeatureUC(settingsRepo);
    final settingsCubit = SettingsFeatureCubit(settingsUC);
    final paletteUC = createPaletteUseCase();
    final paletteCubit = PaletteCubit(paletteUC)..updateColors();

    await tester.pumpWidget(MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: MultiProvider(
        providers: [Provider.value(value: appDi['notificationService'])],
        child: MultiBlocProvider(
          providers: [
            BlocProvider.value(value: imageCaptionCubit),
            BlocProvider.value(value: homeCubit),
            BlocProvider.value(value: settingsCubit),
            BlocProvider.value(value: paletteCubit),
          ],
          child: Builder(builder: (ctx) {
            // Capture a BuildContext inside the widget tree that includes
            // providers so we can call the NotificationService from test.
            return const HomeScreen();
          }),
        ),
      ),
    ));

    // Ensure widget tree built
    await tester.pumpAndSettle();

    // Use the Scaffold's BuildContext to show a SnackBar via the provided
    // NotificationService (simulates Home reading the service from AppDi).
    final scaffoldFinder = find.byType(Scaffold);
    expect(scaffoldFinder, findsOneWidget);
    final scaffoldContext = tester.element(scaffoldFinder);

    notificationService.showSnackBar(scaffoldContext, 'hello-from-home');

    // Allow the SnackBar animation to appear
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text('hello-from-home'), findsOneWidget);
    expect(find.byType(SnackBar), findsOneWidget);
  });
}
