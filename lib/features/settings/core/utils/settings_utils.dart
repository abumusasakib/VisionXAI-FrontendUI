import 'dart:ui';

import 'package:locale_names/locale_names.dart';

/// Get the display name of a language from a language tag or locale id.
///
/// Uses the `locale_names` extension on `Locale` to provide a localized
/// native display name when available. Falls back to a small built-in
/// map and finally to the raw language code.
String getLanguageNameFromLocaleId(String localeId) {
  if (localeId.isEmpty) return localeId;

  // Normalize separator and split into components (language, country, ...)
  final parts = localeId.replaceAll('-', '_').split('_');
  Locale loc;
  if (parts.length == 1) {
    loc = Locale(parts[0]);
  } else {
    loc = Locale(parts[0], parts[1]);
  }

  try {
    final native = loc.nativeDisplayLanguage;
    if (native.isNotEmpty) return native;
  } catch (_) {}

  // Small built-in fallback map for commonly supported languages.
  final code = parts[0].toLowerCase();
  switch (code) {
    case 'en':
      return 'English';
    case 'bn':
      return 'বাংলা';
    default:
      return code;
  }
}
