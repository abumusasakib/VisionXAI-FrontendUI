import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:locale_names/locale_names.dart';
import 'package:vision_xai/core/routes/app_routes.dart';
import 'package:vision_xai/features/settings/domain/entity/settings_entity.dart';
import 'package:vision_xai/features/settings/presentation/cubit/settings_feature_cubit.dart';
import 'package:vision_xai/l10n/localization_extension.dart';

class SettingsFeatureScreen extends StatefulWidget {
  const SettingsFeatureScreen({super.key});

  @override
  State<SettingsFeatureScreen> createState() => _SettingsFeatureScreenState();
}

class _SettingsFeatureScreenState extends State<SettingsFeatureScreen> {
  /// Get the display name of a language from a Locale instance
  String getLanguageNameFromLocale(Locale locale) =>
      locale.nativeDisplayLanguage;

  @override
  Widget build(BuildContext context) {
    // The SettingsFeatureCubit is accessed by sub-screens when needed.

    return Scaffold(
      appBar: AppBar(title: Text(context.tr.settingsScreenTitle)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: const Icon(Icons.settings),
              title: Text(context.tr.ipConfiguration),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () => context.push(AppRoutes.ipSettings),
            ),
            ListTile(
              leading: const Icon(Icons.language),
              title: Text(context.tr.languageSettings),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () => context.push(AppRoutes.languageSettings),
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: Text(context.tr.about),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () => context.push(AppRoutes.about),
            ),
            const SizedBox(height: 20),
            BlocBuilder<SettingsFeatureCubit, SettingsEntity?>(
              builder: (context, state) {
                if (state == null) return const Text('No settings loaded');
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${context.tr.ip}: ${state.ip}'),
                    Text('${context.tr.port}: ${state.port}'),
                    Text('${context.tr.language}: ${state.locale}'),
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
