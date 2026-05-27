import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vision_xai/features/image_caption/core/utils/attention_utils.dart';

void main() {
  group('parseHexColor', () {
    test('returns null for null input', () {
      expect(parseHexColor(null), null);
    });

    test('parses 6-character hex strings correctly', () {
      expect(parseHexColor('#FF0000'), const Color(0xFFFF0000));
      expect(parseHexColor('00FF00'), const Color(0xFF00FF00));
      expect(parseHexColor('#0000FF'), const Color(0xFF0000FF));
      expect(parseHexColor('FFFFFF'), const Color(0xFFFFFFFF));
      expect(parseHexColor('000000'), const Color(0xFF000000));
    });

    test('parses 8-character hex strings correctly', () {
      expect(parseHexColor('#80FF0000'), const Color(0x80FF0000));
      expect(parseHexColor('8000FF00'), const Color(0x8000FF00));
      expect(parseHexColor('#000000FF'), const Color(0x000000FF));
      expect(parseHexColor('FFFFFFFF'), const Color(0xFFFFFFFF));
    });

    test('returns null for invalid inputs', () {
      expect(parseHexColor(''), null); // empty string
      expect(parseHexColor('#12345'), null); // wrong length (5 chars after '#')
      expect(parseHexColor('1234567'), null); // wrong length (7 chars)
      expect(parseHexColor('#GG0000'), null); // invalid characters
      expect(parseHexColor('not a color'), null); // completely invalid
    });
  });
}
