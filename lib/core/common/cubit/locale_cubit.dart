import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Transforms a [String] like 'es_AR' or 'es-AR' or 'es' to a [Locale]
/// with language code 'es' and optional country code 'AR'.
Locale getLocaleFromTag(String localeTag) {
  var languageParts =
      RegExp(r'([a-zA-Z]*)[_-]?([a-zA-Z]*)').firstMatch(localeTag);
  var languageCode = languageParts?.group(1);
  var countryCode = languageParts?.group(2);
  if (languageCode == null || languageCode.isEmpty) {
    throw StateError("Can't parse locale tag '$localeTag'");
  }
  return Locale(languageCode.toLowerCase(),
      countryCode?.isEmpty == true ? null : countryCode);
}

/// Cubit that holds the current [Locale?] for the app and persists changes
/// into `SharedPreferences` under the key `locale` as a simple tag like
/// `en` or `es_AR`.
class LocaleCubit extends Cubit<Locale?> {
  LocaleCubit({Locale? defaultLocale}) : super(defaultLocale) {
    // Load stored locale (if any) and emit it.
    SharedPreferences.getInstance().then((preferences) {
      final storedLocale = preferences.getString('locale');
      if (storedLocale != null && storedLocale.isNotEmpty) {
        try {
          emit(getLocaleFromTag(storedLocale));
        } catch (_) {
          // ignore parse errors and keep default
        }
      }
    });
  }

  /// Set and persist locale. Pass `null` to clear stored locale.
  Future<void> setLocale(Locale? locale) async {
    final preferences = await SharedPreferences.getInstance();
    if (locale == null) {
      await preferences.remove('locale');
      emit(null);
      return;
    }

    final tag = locale.countryCode == null || locale.countryCode!.isEmpty
        ? locale.languageCode
        : '${locale.languageCode}_${locale.countryCode}';
    await preferences.setString('locale', tag);
    emit(locale);
  }
}
