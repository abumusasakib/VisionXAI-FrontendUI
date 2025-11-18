import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:vision_xai/core/di/service_locator.dart';
import 'package:vision_xai/core/services/notification_service.dart';

import 'package:vision_xai/features/image_caption/core/di/image_caption_injection.dart';
import 'package:vision_xai/features/image_caption/presentation/cubit/image_caption/image_caption_cubit.dart';
import 'package:vision_xai/features/image_caption/presentation/cubit/home/home_cubit.dart';
import 'package:vision_xai/features/settings/about/core/di/about_injection.dart';
import 'package:vision_xai/features/settings/about/presentation/cubit/about_cubit.dart';
import 'package:vision_xai/features/settings/about/domain/use_case/about_uc.dart';
import 'package:vision_xai/features/settings/core/di/settings_injection.dart';
import 'package:vision_xai/features/settings/presentation/cubit/settings_feature_cubit.dart';
import 'package:vision_xai/features/settings/color_palette/presentation/cubit/palette/palette_cubit.dart';

/// Application-level dependency builder.
/// Call `AppDi.create()` from main() after Hive boxes are opened.
class AppDi {
  Dio dio;
  final ImageCaptionCubit imageCaptionCubit;
  final HomeCubit homeCubit;
  final NotificationService notificationService;
  final SettingsFeatureCubit settingsFeatureCubit;
  final AboutUC aboutUC;
  final AboutCubit aboutCubit;
  final PaletteCubit paletteCubit;

  AppDi._({
    required this.dio,
    required this.imageCaptionCubit,
    required this.homeCubit,
    required this.notificationService,
    required this.settingsFeatureCubit,
    required this.aboutUC,
    required this.aboutCubit,
    required this.paletteCubit,
  });

  static AppDi create() {
    // settings are observed via SettingsFeatureCubit

    // Resolve Dio from the service locator so there's a single shared
    // instance. setupServiceLocator() must have been called earlier in
    // `main()` so this returns promptly.
    final resolvedDio = getIt<Dio>();
    // Log the effective base URL at startup
    try {
      log('AppDi initial baseUrl: ${resolvedDio.options.baseUrl}',
          name: 'AppDi');
    } catch (_) {}

    final imageCaptionUC = createImageCaptionUseCase(resolvedDio,
        baseUrl: resolvedDio.options.baseUrl);

    final imageCaptionCubit = ImageCaptionCubit(imageCaptionUC);
    // Resolve NotificationService from GetIt service locator.
    final notificationService = getIt<NotificationService>();
    final homeCubit =
        HomeCubit(imageCaptionCubit, notificationService: notificationService);

    // Settings feature wiring
    final settingsUC = createSettingsFeatureUseCase();
    final settingsFeatureCubit = SettingsFeatureCubit(settingsUC);

    // About feature wiring
    final aboutDeps = createAboutDependencies();

    // Resolve palette cubit from the central service locator (GetIt)
    final paletteCubit = getIt<PaletteCubit>();

    final appDi = AppDi._(
      dio: resolvedDio,
      imageCaptionCubit: imageCaptionCubit,
      homeCubit: homeCubit,
      notificationService: notificationService,
      settingsFeatureCubit: settingsFeatureCubit,
      aboutUC: aboutDeps.aboutUC,
      aboutCubit: aboutDeps.aboutCubit,
      paletteCubit: paletteCubit,
    );

    // Listen for settings changes and recreate Dio + image-caption use-case.
    settingsFeatureCubit.stream.listen((s) {
      if (s != null) {
        // Trim values to avoid accidental whitespace in base URL
        final ip = s.ip.trim();
        final port = s.port.trim();
        final newBase = 'http://$ip:$port';
        try {
          // Update existing Dio's baseUrl so there is one shared instance.
          resolvedDio.options.baseUrl = newBase;
          log('AppDi updated baseUrl: ${resolvedDio.options.baseUrl}',
              name: 'AppDi');
        } catch (_) {}

        // Create a new ImageCaption use-case wired to the updated Dio
        final newImageCaptionUC =
            createImageCaptionUseCase(resolvedDio, baseUrl: newBase);
        // Swap use-case into the existing cubit so presentation continues
        // using the same cubit instance.
        imageCaptionCubit.updateUseCase(newImageCaptionUC);
        // Update the stored Dio reference on the AppDi instance
        appDi.dio = resolvedDio;
      }
    });

    return appDi;
  }

  /// Dispose long-lived resources created by the DI container.
  /// Call this during app teardown if needed.
  Future<void> dispose() async {
    await imageCaptionCubit.close();
    await homeCubit.close();
    await settingsFeatureCubit.close();
    await aboutCubit.close();
    await paletteCubit.close();
    dio.close();
  }
}
