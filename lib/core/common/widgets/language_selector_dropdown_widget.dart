import 'package:flutter/material.dart';
import 'package:locale_names/locale_names.dart';
import 'package:vision_xai/core/common/cubit/locale_cubit.dart';
import 'package:vision_xai/l10n/app_localizations.dart';

typedef LanguageChangeHandler = Function(Locale chosenLocale);

class LanguageSelectorDropdownWidget extends StatelessWidget {
  const LanguageSelectorDropdownWidget({
    super.key,

    /// Provide the [AppLocalizations.supportedLocales]
    required this.supportedLocales,

    /// A callback to be called when the user selects a language.
    this.languageChangeHandler,

    /// Optionally, a custom icon
    this.icon,

    /// Optionally pass a provider to manage localization
    this.provider,
  });

  final LocaleCubit? provider;
  final List<Locale> supportedLocales;
  final Icon? icon;
  final LanguageChangeHandler? languageChangeHandler;

  /// Get the display name of a language from a Locale instance
  String getLanguageNameFromLocale(Locale locale) {
    return locale.nativeDisplayLanguage;
  }

  /// Handler for language change
  void languageChangedHandler(String? localeId) {
    if (localeId == null) return;

    // Create a Locale instance from the language tag
    var locale = Locale(localeId);

    // Trigger callback if provided
    if (languageChangeHandler != null) {
      languageChangeHandler!(locale);
    }

    // Update the LocaleCubit instance if available
    provider?.setLocale(locale);
  }

  /// Build a dropdown menu item for each locale
  DropdownMenuItem<String> _buildMenuItem(Locale locale) {
    return DropdownMenuItem<String>(
      value: locale.toLanguageTag(),
      child: Text(
        getLanguageNameFromLocale(locale),
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: FlexFit.loose, // Constrain the width of DropdownButton
      child: DropdownButton<String>(
        icon: icon ?? const Icon(Icons.language), // Default icon or custom one
        value: AppLocalizations.of(context)?.localeName,
        items: supportedLocales.map(_buildMenuItem).toList(),
        onChanged: languageChangedHandler,
        isExpanded: true, // Adjust width
        elevation: 16,
        style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
        dropdownColor: Theme.of(context).colorScheme.surface,
      ),
    );
  }
}
