import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/foundation.dart';
import 'dart:ui' as ui;
import 'package:vision_xai/features/settings/color_palette/core/palette_manager.dart';
import 'package:vision_xai/features/settings/color_palette/core/utils/palette_utils.dart';

// Simple in-memory ImageProvider for tests that produces a 1x1 image with a
// solid color.
class TestImageProvider extends ImageProvider<TestImageProvider> {
  final Color color;
  const TestImageProvider(this.color);

  @override
  Future<TestImageProvider> obtainKey(ImageConfiguration configuration) {
    return SynchronousFuture<TestImageProvider>(this);
  }

  ImageStreamCompleter load(TestImageProvider key, dynamic _) {
    final Future<ImageInfo> future = (() async {
      final ui.PictureRecorder recorder = ui.PictureRecorder();
      final Canvas canvas = Canvas(recorder);
      final Paint paint = Paint()..color = color;
      canvas.drawRect(const Rect.fromLTWH(0, 0, 1, 1), paint);
      final ui.Image image = await recorder.endRecording().toImage(1, 1);
      return ImageInfo(image: image, scale: 1.0);
    })();

    return OneFrameImageStreamCompleter(future);
  }
}

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

  double hueDiff(double a, double b) {
    final diff = (a - b).abs();
    return diff > 180 ? 360 - diff : diff;
  }

  test('palette builder produces colors close to expected for #FFA500', () {
    final palette = buildPaletteFromHex('#FFA500');
    final primary = palette['primary']!;
    final secondary = palette['secondary']!;
    final background = palette['background']!;

    // Expected values computed from the algorithm to avoid hard-coded
    // constants that depend on the implementation details. This test
    // verifies the builder follows the documented algorithm.
    const expectedBackground = Color(0xFFFFA500);
    final bgHsl = HSLColor.fromColor(expectedBackground);
    final expectedPrimaryHsl =
        bgHsl.withSaturation((bgHsl.saturation * (1.0 - 0.6)).clamp(0.0, 1.0));
    final expectedSecondaryHsl = bgHsl.withHue((bgHsl.hue + 137.5) % 360.0);
    final expectedPrimary = expectedPrimaryHsl.toColor();
    final expectedSecondary = expectedSecondaryHsl.toColor();

    final pHsl = HSLColor.fromColor(primary);
    final sHsl = HSLColor.fromColor(secondary);
    final ePHsl = HSLColor.fromColor(expectedPrimary);
    final eSHsl = HSLColor.fromColor(expectedSecondary);

    // Tolerances: hue in degrees, saturation/lightness in fraction
    const hueTol = 4.0; // degrees
    const satTol = 0.12; // 12% absolute
    const lightTol = 0.16; // 16% absolute

    expect(hueDiff(pHsl.hue, ePHsl.hue) <= hueTol, isTrue,
        reason:
            'Primary hue differs by more than $hueTol degrees: ${hueDiff(pHsl.hue, ePHsl.hue)}');
    expect((pHsl.saturation - ePHsl.saturation).abs() <= satTol, isTrue,
        reason:
            'Primary saturation differs by more than $satTol: ${(pHsl.saturation - ePHsl.saturation).abs()}');
    expect((pHsl.lightness - ePHsl.lightness).abs() <= lightTol, isTrue,
        reason:
            'Primary lightness differs by more than $lightTol: ${(pHsl.lightness - ePHsl.lightness).abs()}');

    // Secondary: hue should match the rotated hue within tolerance and
    // saturation should be similar; lightness may be adjusted to improve
    // contrast so we avoid a strict lightness assertion here.
    expect(hueDiff(sHsl.hue, eSHsl.hue) <= hueTol, isTrue,
        reason:
            'Secondary hue differs by more than $hueTol degrees: ${hueDiff(sHsl.hue, eSHsl.hue)}');
    expect((sHsl.saturation - eSHsl.saturation).abs() <= satTol, isTrue,
        reason:
            'Secondary saturation differs by more than $satTol: ${(sHsl.saturation - eSHsl.saturation).abs()}');

    // Background should be exact (we pass hex through)
    expect(background, expectedBackground);
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
