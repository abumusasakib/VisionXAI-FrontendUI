import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:arb_utils/state_managers/l10n_provider.dart';
import 'package:vision_xai/core/common/widgets/custom_language_selector_dropdown.dart';
import 'package:vision_xai/core/constants/ip_details.dart';
import 'package:vision_xai/l10n/localization_extension.dart';

import '../../cubit/settings_feature_cubit.dart';
import '../../../domain/entity/settings_entity.dart';

class LanguageSettingsScreen extends StatefulWidget {
  const LanguageSettingsScreen({super.key});

  @override
  State<LanguageSettingsScreen> createState() => _LanguageSettingsScreenState();
}

class _LanguageSettingsScreenState extends State<LanguageSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SettingsFeatureCubit>();
    final provider = context.read<ProviderL10n>();
    return Scaffold(
      appBar: AppBar(title: Text(context.tr.languageSettings)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(context.tr.selectLanguage,
                style: const TextStyle(fontSize: 18)),
            const SizedBox(width: 25),
            // Centralized custom dropdown which updates ProviderL10n
            CustomLanguageSelectorDropdown(
              supportedLocales: AppLocalizations.supportedLocales,
              provider: provider,
              languageChangeHandler: (locale) {
                // When user picks a language, update the Settings entity immediately
                final entity = SettingsEntity(
                  ip: cubit.state?.ip ?? IPDetails.defaultIP,
                  port: cubit.state?.port ?? IPDetails.defaultPort,
                  locale: locale.languageCode,
                );
                cubit.save(entity);
              },
            ),
          ],
        ),
      ),
    );
  }
}
