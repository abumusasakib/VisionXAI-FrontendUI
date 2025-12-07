import 'dart:typed_data';
import 'package:material_color_utilities/material_color_utilities.dart';

/// Top-level compute worker used by the main isolate to perform
/// color quantization and tonal extraction in a background isolate.
///
/// Contract (payload): the function expects a `Map<String, dynamic>` with
/// the following keys:
/// - `'pixels'` : `Uint8List` containing raw pixel bytes in RGBA order
///   (repeated bytes: r, g, b, a). This is typically obtained from
///   `ui.Image.toByteData(format: ui.ImageByteFormat.rawRgba)` on the
///   main isolate before sending to `compute(...)`.
/// - `'width'`  : `int` image width in pixels (optional for current
///   implementation but provided for future use).
/// - `'height'` : `int` image height in pixels (optional for current
///   implementation but provided for future use).
///
/// Behavior:
/// - The worker iterates `pixels` 4 bytes at a time (r,g,b,a).
/// - It ignores very-transparent pixels (alpha < 40) to avoid counting
///   edges/antialiasing artifacts.
/// - Each remaining pixel is packed into an ARGB integer using the
///   expression `(a << 24) | (r << 16) | (g << 8) | b` (i.e. 0xAARRGGBB)
///   and a frequency map (`color -> count`) is accumulated.
/// - The `material_color_utilities.Score.score(...)` routine is used to
///   pick a scored base color from the frequency map (preferred color for
///   building a `CorePalette`).
/// - A `CorePalette` is created from the base ARGB color and a collection
///   of tonal values is extracted for primary/secondary/tertiary/neutral
///   and neutralVariant palettes.
///
/// Return value (`Map<String, int>`): the worker returns a flat map of tone
/// keys to ARGB integers so the main isolate can deterministically map
/// tones to UI roles. Typical keys include:
/// - `'base'` : scored base ARGB int (0xAARRGGBB)
/// - `'surface'` : a default surface/neutral tone (e.g. neutral_99)
/// - `'primary_100'`, `'primary_99'`, `'primary_90'`, ..., `'primary_10'`
/// - `'secondary_100'`, ... (same pattern for `tertiary`, `neutral`,
///   `neutralVariant`)
///
/// Notes:
/// - This function MUST be a top-level function (not a closure or
///   instance method) so it can be passed to `compute(...)`.
/// - Consumers should treat the returned map as a best-effort set of
///   tonal candidates: some tones may be missing for certain images, so
///   callers should perform graceful fallbacks (as done in
///   `PaletteManager.generatePalette`).
///
/// Example usage:
/// ```dart
/// // Build a small 2x1 RGBA pixel buffer: [r,g,b,a, r,g,b,a]
/// final Uint8List pixels = Uint8List.fromList([
///   255, 0, 0, 255, // opaque red
///   0, 255, 0, 255, // opaque green
/// ]);
/// final payload = {'pixels': pixels, 'width': 2, 'height': 1};
/// // When executed via compute(...) the worker will return a map like:
/// // {
/// //   'base': 0xFFrrggbb,           // scored base ARGB int
/// //   'surface': 0xFFssssss,        // neutral/surface tone
/// //   'primary_100': 0xFF...,       // many tonal entries follow
/// //   'primary_99': 0xFF...,
/// //   'primary_90': 0xFF...,
/// //   'secondary_80': 0xFF...,
/// //   ...
/// // }
/// // Exact ARGB values depend on the scoring and CorePalette mapping.
/// ```
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
