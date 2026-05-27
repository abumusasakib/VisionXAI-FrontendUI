import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:vision_xai/core/common/cubit/locale_cubit.dart';

void main() {
  group('getLocaleFromTag', () {
    test('parses single language tag', () {
      final locale = getLocaleFromTag('es');
      expect(locale.languageCode, 'es');
      expect(locale.countryCode, isNull);
    });

    test('parses single language tag uppercase', () {
      final locale = getLocaleFromTag('ES');
      expect(locale.languageCode, 'es');
      expect(locale.countryCode, isNull);
    });

    test('parses language and country tag separated by underscore', () {
      final locale = getLocaleFromTag('es_AR');
      expect(locale.languageCode, 'es');
      expect(locale.countryCode, 'AR');
    });

    test('parses language and country tag separated by hyphen', () {
      final locale = getLocaleFromTag('es-AR');
      expect(locale.languageCode, 'es');
      expect(locale.countryCode, 'AR');
    });

    test('parses language and country tag with different casing', () {
      final locale = getLocaleFromTag('Es-aR');
      expect(locale.languageCode, 'es');
      expect(locale.countryCode, 'aR');
    });

    test('throws StateError for empty string', () {
      expect(() => getLocaleFromTag(''), throwsStateError);
    });

    test('throws StateError for non-letter strings', () {
      expect(() => getLocaleFromTag('123'), throwsStateError);
      expect(() => getLocaleFromTag('!@#'), throwsStateError);
      expect(() => getLocaleFromTag('_-'), throwsStateError);
    });
  });
}
