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

String? hexValidator(String? v) {
  if (v == null) return 'Invalid hex';
  final normalized = v.trim();
  return hexRegex.hasMatch(normalized) ? null : 'Enter hex like #RRGGBB';
}
