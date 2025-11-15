import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:vision_xai/features/image_caption/core/di/image_caption_injection.dart';
import 'package:vision_xai/features/image_caption/presentation/cubit/image_caption/image_caption_cubit.dart';
import 'package:vision_xai/features/image_caption/presentation/cubit/home/home_cubit.dart';
import 'package:vision_xai/features/settings/about/core/di/about_injection.dart';
import 'package:vision_xai/features/settings/about/presentation/cubit/about_cubit.dart';
import 'package:vision_xai/features/settings/about/domain/use_case/about_uc.dart';
import 'package:vision_xai/features/settings/core/di/settings_injection.dart';
import 'package:vision_xai/features/settings/presentation/cubit/settings_feature_cubit.dart';

/// Application-level dependency builder.
/// Call `AppDi.create()` from main() after Hive boxes are opened.
class AppDi {
  Dio dio;
  final ImageCaptionCubit imageCaptionCubit;
  final HomeCubit homeCubit;
  final SettingsFeatureCubit settingsFeatureCubit;
  final AboutUC aboutUC;
  final AboutCubit aboutCubit;

  AppDi._({
    required this.dio,
    required this.imageCaptionCubit,
    required this.homeCubit,
    required this.settingsFeatureCubit,
    required this.aboutUC,
    required this.aboutCubit,
  });

  static AppDi create() {
    final settingsBox = Hive.box('settings');
    final ip = settingsBox.get('ip', defaultValue: '127.0.0.1') as String;
    final port = settingsBox.get('port', defaultValue: '8000') as String;
    final baseUrl = 'http://$ip:$port';

    final initialDio = Dio(BaseOptions(baseUrl: baseUrl));
    final imageCaptionUC =
        createImageCaptionUseCase(initialDio, baseUrl: baseUrl);

    final imageCaptionCubit = ImageCaptionCubit(imageCaptionUC);
    final homeCubit = HomeCubit(imageCaptionCubit);

    // Settings feature wiring
    final settingsUC = createSettingsFeatureUseCase();
    final settingsFeatureCubit = SettingsFeatureCubit(settingsUC);

    // About feature wiring
    final aboutDeps = createAboutDependencies();

    final appDi = AppDi._(
        dio: initialDio,
        imageCaptionCubit: imageCaptionCubit,
        homeCubit: homeCubit,
        settingsFeatureCubit: settingsFeatureCubit,
        aboutUC: aboutDeps.aboutUC,
        aboutCubit: aboutDeps.aboutCubit);

    // Listen for settings changes and recreate Dio + image-caption use-case.
    settingsFeatureCubit.stream.listen((s) {
      if (s != null) {
        final newBase = 'http://${s.ip}:${s.port}';
        // Create a new Dio instance with updated baseUrl
        final newDio = Dio(BaseOptions(baseUrl: newBase));
        // Create a new ImageCaption use-case wired to the new Dio
        final newImageCaptionUC =
            createImageCaptionUseCase(newDio, baseUrl: newBase);
        // Swap use-case into the existing cubit so presentation continues using same cubit
        imageCaptionCubit.updateUseCase(newImageCaptionUC);
        // Update the stored Dio reference on the AppDi instance
        appDi.dio = newDio;
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
    dio.close();
  }
}
