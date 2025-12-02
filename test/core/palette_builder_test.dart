import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:vision_xai/features/settings/color_palette/core/utils/palette_utils.dart';

double _hueDiff(double a, double b) {
  final diff = (a - b).abs();
  return diff > 180 ? 360 - diff : diff;
}

void main() {
  test('palette builder produces colors close to expected for #FFA500', () {
    final palette = buildPaletteFromHex('#FFA500');
    final primary = palette['primary']!;
    final secondary = palette['secondary']!;
    final background = palette['background']!;

    // Expected values
    const expectedPrimary = Color(0xFF00B2A9);
    const expectedSecondary = Color(0xFFB28E4C);
    const expectedBackground = Color(0xFFFFA500);

    final pHsl = HSLColor.fromColor(primary);
    final sHsl = HSLColor.fromColor(secondary);
    final ePHsl = HSLColor.fromColor(expectedPrimary);
    final eSHsl = HSLColor.fromColor(expectedSecondary);

    // Tolerances: hue in degrees, saturation/lightness in fraction
    const hueTol = 4.0; // degrees
    const satTol = 0.12; // 12% absolute
    const lightTol = 0.16; // 16% absolute

    expect(_hueDiff(pHsl.hue, ePHsl.hue) <= hueTol, isTrue,
        reason:
            'Primary hue differs by more than $hueTol degrees: ${_hueDiff(pHsl.hue, ePHsl.hue)}');
    expect((pHsl.saturation - ePHsl.saturation).abs() <= satTol, isTrue,
        reason:
            'Primary saturation differs by more than $satTol: ${(pHsl.saturation - ePHsl.saturation).abs()}');
    expect((pHsl.lightness - ePHsl.lightness).abs() <= lightTol, isTrue,
        reason:
            'Primary lightness differs by more than $lightTol: ${(pHsl.lightness - ePHsl.lightness).abs()}');

    expect(_hueDiff(sHsl.hue, eSHsl.hue) <= hueTol, isTrue,
        reason:
            'Secondary hue differs by more than $hueTol degrees: ${_hueDiff(sHsl.hue, eSHsl.hue)}');
    expect((sHsl.saturation - eSHsl.saturation).abs() <= satTol, isTrue,
        reason:
            'Secondary saturation differs by more than $satTol: ${(sHsl.saturation - eSHsl.saturation).abs()}');
    expect((sHsl.lightness - eSHsl.lightness).abs() <= lightTol, isTrue,
        reason:
            'Secondary lightness differs by more than $lightTol: ${(sHsl.lightness - eSHsl.lightness).abs()}');

    // Background should be exact (we pass hex through)
    expect(background, expectedBackground);
  });
}
