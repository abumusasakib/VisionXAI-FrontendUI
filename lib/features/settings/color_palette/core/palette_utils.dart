import 'package:flutter/material.dart';
import 'package:vision_xai/features/settings/color_palette/core/palette_manager.dart';

String toHex(Color c) =>
    '#${c.value.toRadixString(16).padLeft(8, '0').substring(2).toUpperCase()}';

final hexRegex = RegExp(r'^#([A-Fa-f0-9]{6})$');

Color colorFromHex(String hex) {
  try {
    return PaletteManager.getWebSafeColorFromHex(hex);
  } catch (_) {
    return Colors.white;
  }
}

/// Build a palette map from a hex color string `#RRGGBB`.
/// Returns a map with keys: `primary`, `secondary`, `background` (Colors).
Map<String, Color> buildPaletteFromHex(String hex,
    {double rotationDegrees = 137.5, double desaturateFraction = 0.6}) {
  return PaletteManager.buildPaletteFromHex(hex,
      rotationDegrees: rotationDegrees, desaturateFraction: desaturateFraction);
}

/// Build a palette map from a `Color` instance.
Map<String, Color> buildPaletteFromColor(Color color,
    {double rotationDegrees = 137.5, double desaturateFraction = 0.6}) {
  return PaletteManager.buildPaletteFromBackgroundColor(color,
      rotationDegrees: rotationDegrees, desaturateFraction: desaturateFraction);
}

String? hexValidator(String? v) {
  if (v == null) return 'Invalid hex';
  final normalized = v.trim();
  return hexRegex.hasMatch(normalized) ? null : 'Enter hex like #RRGGBB';
}
