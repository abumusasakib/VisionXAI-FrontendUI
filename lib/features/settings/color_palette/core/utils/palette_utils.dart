import 'package:flutter/material.dart';
import 'package:vision_xai/features/settings/color_palette/core/palette_manager.dart';

String toHex(Color c) {
  // Use component accessors (.a/.r/.g/.b) to construct an ARGB integer
  // and then format as `#RRGGBB` for compatibility with existing UI.
  final int a = (c.a * 255.0).round() & 0xFF;
  final int r = (c.r * 255.0).round() & 0xFF;
  final int g = (c.g * 255.0).round() & 0xFF;
  final int b = (c.b * 255.0).round() & 0xFF;
  final int argb = (a << 24) | (r << 16) | (g << 8) | b;
  return '#${argb.toRadixString(16).padLeft(8, '0').substring(2).toUpperCase()}';
}

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
