import 'package:go_router/go_router.dart';
import 'package:vision_xai/core/services/global_ui_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vision_xai/features/image_caption/presentation/screen/home_screen.dart';
import 'package:vision_xai/core/routes/app_routes.dart';
import 'package:vision_xai/features/settings/presentation/screen/settings_screen.dart';
import 'package:vision_xai/features/settings/presentation/screen/ip_settings/ip_settings_screen.dart';
import 'package:vision_xai/features/settings/presentation/screen/language_settings/language_settings_screen.dart';
import 'package:vision_xai/features/settings/presentation/screen/about/about_screen.dart';
import 'package:vision_xai/features/settings/color_palette/presentation/screen/palette_settings_screen.dart';
import 'package:vision_xai/features/settings/color_palette/presentation/cubit/palette_settings/palette_settings_cubit.dart';
import 'package:vision_xai/core/di/app_di.dart';

GoRouter createRouter(AppDi appDi) => GoRouter(
      navigatorKey: GlobalUiService.navigatorKey,
      initialLocation: AppRoutes.home,
      routes: [
        GoRoute(
          path: AppRoutes.home,
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: AppRoutes.settings,
          builder: (context, state) => BlocProvider.value(
            value: appDi.settingsFeatureCubit,
            child: const SettingsFeatureScreen(),
          ),
        ),
        GoRoute(
          path: AppRoutes.ipSettings,
          builder: (context, state) => BlocProvider.value(
            value: appDi.settingsFeatureCubit,
            child: const IpSettingsScreen(),
          ),
        ),
        GoRoute(
          path: AppRoutes.languageSettings,
          builder: (context, state) => BlocProvider.value(
            value: appDi.settingsFeatureCubit,
            child: const LanguageSettingsScreen(),
          ),
        ),
        GoRoute(
          path: AppRoutes.about,
          builder: (context, state) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: appDi.settingsFeatureCubit),
              BlocProvider.value(value: appDi.aboutCubit),
            ],
            child: const AboutScreen(),
          ),
        ),
        GoRoute(
          path: AppRoutes.paletteSettings,
          builder: (context, state) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: appDi.paletteCubit),
              BlocProvider(create: (ctx) {
                // Create the settings cubit here. The settings screen will
                // drive loading of persisted overrides so the UI can decide
                // when to perform that action and avoid duplicate loads.
                return PaletteSettingsCubit(appDi.paletteCubit);
              }),
            ],
            child: const PaletteSettingsScreen(),
          ),
        ),
      ],
    );
