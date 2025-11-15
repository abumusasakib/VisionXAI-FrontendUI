import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locale_names/locale_names.dart';

import 'package:vision_xai/features/settings/about/presentation/cubit/about_cubit.dart';
import 'package:vision_xai/features/settings/about/presentation/cubit/about_state.dart';
import 'package:vision_xai/features/settings/presentation/cubit/settings_feature_cubit.dart';
import 'package:vision_xai/features/settings/domain/entity/settings_entity.dart';
import 'package:vision_xai/l10n/localization_extension.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // AboutCubit is provided by the app-level DI/router.
    // The AboutCubit should already be initialized and can be used here.
    return const AboutView();
  }
}

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    // The teal color that matches the logo background
    const Color bgColor = Color(0xFF1A7A85);

    return Scaffold(
      appBar: AppBar(
        title: Text(context.tr.about),
        backgroundColor: bgColor,
        foregroundColor: Colors.white,
      ),
      backgroundColor: bgColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/about.png', width: 200, height: 200),
            const SizedBox(height: 20),
            BlocBuilder<SettingsFeatureCubit, SettingsEntity?>(
              builder: (context, state) {
                final language = state == null
                    ? 'Unknown'
                    : Locale(state.locale).nativeDisplayLanguage;
                return Text(
                  '${context.tr.currentLanguage}: $language',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                );
              },
            ),
            const SizedBox(height: 10),
            BlocBuilder<AboutCubit, AboutState>(
              builder: (context, state) {
                final appVersion = state.appVersion;
                final platform = state.platform;
                return Column(
                  children: [
                    if (appVersion != 'Loading...')
                      Text(
                        '${context.tr.version}: $appVersion',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    const SizedBox(height: 5),
                    if (platform != 'Unknown' &&
                        platform != 'Unsupported Platform')
                      Text(
                        '${context.tr.platform}: $platform',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
