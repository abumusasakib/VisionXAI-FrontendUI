import 'dart:typed_data';
import 'package:material_color_utilities/material_color_utilities.dart';

// Top-level compute worker for palette extraction using
// `material_color_utilities` scoring algorithm.
// Receives a Map with keys: 'pixels' (Uint8List RGBA), 'width' (int), 'height' (int)
// Returns a Map<String,int> with 'baseColor' ARGB int (the scored base color).

Map<String, int> quantizeAndFindDominant(Map<String, dynamic> payload) {
  final Uint8List pixels = payload['pixels'] as Uint8List;

  // Build a color -> count map in ARGB (0xAARRGGBB) format.
  final Map<int, int> colorToCount = <int, int>{};

  for (int i = 0; i + 3 < pixels.length; i += 4) {
    final int r = pixels[i];
    final int g = pixels[i + 1];
    final int b = pixels[i + 2];
    final int a = pixels[i + 3];

    // Ignore very transparent pixels.
    if (a < 40) continue;

    final int argb = (a << 24) | (r << 16) | (g << 8) | b;
    colorToCount[argb] = (colorToCount[argb] ?? 0) + 1;
  }

  if (colorToCount.isEmpty) {
    return {'baseColor': 0xFF888888};
  }

  // Use material_color_utilities' scoring to pick the most suitable base color.
  final List<int> scored = Score.score(colorToCount, desired: 1);
  final int baseArgb =
      scored.isNotEmpty ? scored.first : colorToCount.keys.first;

  // Build a CorePalette from the base color and return a set of tonal
  // values for primary/secondary/tertiary/neutral/neutralVariant so the
  // main isolate can map them to ColorScheme roles deterministically.
  final CorePalette core = CorePalette.of(baseArgb);

  // Helper to collect a range of tones for a tonal palette
  Map<String, int> collectTones(String prefix, TonalPalette p) {
    return {
      '${prefix}_100': p.get(100),
      '${prefix}_99': p.get(99),
      '${prefix}_90': p.get(90),
      '${prefix}_80': p.get(80),
      '${prefix}_60': p.get(60),
      '${prefix}_50': p.get(50),
      '${prefix}_40': p.get(40),
      '${prefix}_30': p.get(30),
      '${prefix}_20': p.get(20),
      '${prefix}_10': p.get(10),
    };
  }

  final Map<String, int> primaryTones = collectTones('primary', core.primary);
  final Map<String, int> secondaryTones =
      collectTones('secondary', core.secondary);
  final Map<String, int> tertiaryTones =
      collectTones('tertiary', core.tertiary);
  final Map<String, int> neutralTones = collectTones('neutral', core.neutral);
  final Map<String, int> neutralVariantTones =
      collectTones('neutralVariant', core.neutralVariant);

  // Surface is typically neutral tone 99
  final int surface = core.neutral.get(99);

  // Merge maps into return value
  final Map<String, int> out = <String, int>{
    'base': baseArgb,
    'surface': surface
  };
  out.addAll(primaryTones);
  out.addAll(secondaryTones);
  out.addAll(tertiaryTones);
  out.addAll(neutralTones);
  out.addAll(neutralVariantTones);

  return out;
}
