import 'dart:developer';

import 'package:get_it/get_it.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:vision_xai/core/constants/ip_details.dart';
import 'package:vision_xai/core/services/notification_service.dart';
import 'package:vision_xai/core/network/truncating_log_interceptor.dart';
import 'package:dio/dio.dart';

// Color palette feature deps
import 'package:vision_xai/features/settings/color_palette/data/repository/palette_repo_impl.dart';
import 'package:vision_xai/features/settings/color_palette/data/datasource/local/palette_local_data_source.dart';
import 'package:vision_xai/features/settings/color_palette/domain/use_case/palette_uc.dart';
import 'package:vision_xai/features/settings/color_palette/presentation/cubit/palette/palette_cubit.dart';

final GetIt getIt = GetIt.instance;

/// Set up service locator with lazy singletons. This reads the persisted
/// settings (Hive box) lazily when a dependent instance is requested.
void setupServiceLocator() {
  // NotificationService: immediate singleton
  if (!getIt.isRegistered<NotificationService>()) {
    getIt.registerSingleton<NotificationService>(NotificationServiceImpl());
  }

  // Dio: lazily created using current settings from Hive
  if (!getIt.isRegistered<Dio>()) {
    getIt.registerLazySingleton<Dio>(() {
      final settingsBox = Hive.box('settings');
      final ip =
          settingsBox.get('ip', defaultValue: IPDetails.defaultIP) as String;
      final port = settingsBox.get('port', defaultValue: IPDetails.defaultPort)
          as String;
      final baseUrl = 'http://$ip:$port';
      final d = Dio(BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 90),
        sendTimeout: const Duration(seconds: 90),
        receiveTimeout: const Duration(seconds: 90),
      ));
      d.interceptors.add(TruncatingLogInterceptor(
        maxBodyChars: 1024,
        logPrint: (obj) => log(obj.toString(), name: 'Dio'),
      ));
      return d;
    });
  }

  // Palette feature: local data source, repo, use-case, cubit.
  if (!getIt.isRegistered<PaletteLocalDataSource>()) {
    getIt.registerLazySingleton<PaletteLocalDataSource>(
        () => PaletteLocalDataSource());
  }

  if (!getIt.isRegistered<PaletteRepoImpl>()) {
    getIt.registerLazySingleton<PaletteRepoImpl>(
        () => PaletteRepoImpl(getIt<PaletteLocalDataSource>()));
  }

  if (!getIt.isRegistered<PaletteUC>()) {
    getIt.registerLazySingleton<PaletteUC>(
        () => PaletteUC(getIt<PaletteRepoImpl>()));
  }

  if (!getIt.isRegistered<PaletteCubit>()) {
    // PaletteCubit is a long-lived app-level cubit; create it lazily and
    // initialize colors immediately after construction.
    getIt.registerLazySingleton<PaletteCubit>(() {
      final cubit = PaletteCubit(getIt<PaletteUC>());
      // Start initial load
      cubit.updateColors();
      return cubit;
    });
  }
}

/// Reset the service locator for tests: close singletons that require cleanup
/// and unregister everything. Safe to call multiple times.
Future<void> resetForTests() async {
  // Close Dio if present.
  try {
    if (getIt.isRegistered<Dio>()) {
      final d = getIt<Dio>();
      try {
        d.close();
      } catch (_) {}
    }
  } catch (_) {}

  // Close PaletteCubit if present
  try {
    if (getIt.isRegistered<PaletteCubit>()) {
      final p = getIt<PaletteCubit>();
      try {
        p.close();
      } catch (_) {}
    }
  } catch (_) {}

  // Finally reset GetIt registrations.
  try {
    await getIt.reset();
  } catch (_) {}
}
