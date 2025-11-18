import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
import 'package:vision_xai/features/settings/color_palette/core/palette_manager.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('generatePalette returns fallback on image load error', () async {
    // Use a MemoryImage with empty bytes which should fail to decode and
    // trigger the fallback path in PaletteManager.
    final provider = MemoryImage(Uint8List(0));
    final result = await PaletteManager.generatePalette(provider);

    expect(result, isA<Map<String, Color>>());
    expect(result['primary'], PaletteManager.fallbackPrimary);
    expect(result['secondary'], PaletteManager.fallbackSecondary);
    expect(result['background'], PaletteManager.fallbackBackground);
  });

  test('getWebSafeColorFromHex returns expected color or web-safe mapping', () {
    final c = PaletteManager.getWebSafeColorFromHex('#123456');
    expect(c, isA<Color>());
    final inputVal = int.parse('#123456'.replaceFirst('#', '0xFF'));
    final inputColor = Color(inputVal);
    if (kIsWeb) {
      // On web the mapping should yield channels that are multiples of 51
      expect(c.red % 51, equals(0));
      expect(c.green % 51, equals(0));
      expect(c.blue % 51, equals(0));
    } else {
      // On non-web platforms the function returns the original color
      expect(c, equals(inputColor));
    }
  });

  test('web-safe rounding edge cases', () {
    // Hex values chosen to exercise rounding up and down near the 51 boundaries.
    final cases = ['#2A2A2A', '#323232', '#1F1F1F', '#4B4B4B'];

    for (final hex in cases) {
      final mapped = PaletteManager.getWebSafeColorFromHex(hex);
      final inputVal = int.parse(hex.replaceFirst('#', '0xFF'));
      final inputColor = Color(inputVal);

      if (kIsWeb) {
        // Each channel should be a multiple of 51 and within 0..255
        expect(mapped.red % 51, equals(0));
        expect(mapped.green % 51, equals(0));
        expect(mapped.blue % 51, equals(0));

        // Check that rounding is consistent with the same algorithm
        int expectedChannel(int ch) => ((ch / 51).round() * 51).clamp(0, 255);
        expect(mapped.red, equals(expectedChannel(inputColor.red)));
        expect(mapped.green, equals(expectedChannel(inputColor.green)));
        expect(mapped.blue, equals(expectedChannel(inputColor.blue)));
      } else {
        expect(mapped, equals(inputColor));
      }
    }
  });
}
