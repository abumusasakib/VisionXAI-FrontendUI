import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/foundation.dart'
    show compute, ByteData, Uint8List, kIsWeb;
import 'dart:math' as math;
import 'palette_worker.dart';

class PaletteManager {
  static const Color fallbackPrimary = Color(0xFF089BB7); // Blue Green
  static const Color fallbackSecondary = Color(0xFF0FC0B8); // Light Sea Green
  static const Color fallbackBackground = Color(0xFFFEFDFC); // White 2

  static Future<Map<String, Color>> generatePalette(ImageProvider image) async {
    try {
      // Resolve the ImageProvider to a ui.Image, extract raw RGBA bytes,
      // then run a lightweight quantizer in a background isolate using
      // `compute(...)` so this work does not block the UI thread.
      try {
        final completer = Completer<ImageInfo>();

        final ImageStream stream = image.resolve(ImageConfiguration.empty);

        final listener = ImageStreamListener((ImageInfo info, bool _) {
          if (!completer.isCompleted) {
            completer.complete(info);
          }
        }, onError: (exception, stackTrace) {
          if (!completer.isCompleted) {
            completer.completeError(exception, stackTrace);
          }
        });

        stream.addListener(listener);

        final ImageInfo imageInfo = await completer.future;
        stream.removeListener(listener);

        final ui.Image uiImage = imageInfo.image;
        final ByteData? bd =
            await uiImage.toByteData(format: ui.ImageByteFormat.rawRgba);
        if (bd != null) {
          final Uint8List pixels = bd.buffer.asUint8List();

          final Map<String, int> result =
              await compute(quantizeAndFindDominant, {
            'pixels': pixels,
            'width': uiImage.width,
            'height': uiImage.height,
          });

          // Worker returns multiple tonal ARGB ints derived from CorePalette.
          // Prefer specific tonal steps (40 for primary/secondary) so the
          // colors differ instead of falling back to the scored base color.
          final int primaryArgb =
              result['primary_40'] ?? result['primary'] ?? result['base']!;
          // Prefer a lighter secondary tone (80 -> 60 -> 40) to avoid very dark
          // secondaries on some images.
          final int secondaryArgb = result['secondary_80'] ??
              result['secondary_60'] ??
              result['secondary_40'] ??
              result['secondary'] ??
              result['base']!;
          // Prefer a slightly darker neutral for surface/background so it
          // doesn't always return near-white. Try neutral_95 -> neutral_90
          // -> neutral_99 -> base. Then mix a small amount of primary_99
          // into the neutral to produce a subtle tinted surface.
          final int neutralArgb = result['surface'] ??
              result['neutral_95'] ??
              result['neutral_90'] ??
              result['neutral_99'] ??
              result['base']!;
          final int primary99Argb =
              result['primary_99'] ?? result['primary'] ?? result['base']!;
          Color blendedSurface = Color(neutralArgb);
          // Adaptive tint fraction based on saturation/contrast
          // Adaptive tint fraction based on saturation/contrast
          // Double the effect for surface/background blending to make
          // the background tint noticeably stronger, but clamp to 1.0.
          final double fastTintFrac =
              _adaptiveTintFraction(blendedSurface, Color(primary99Argb));
          final double surfaceTintFrac = math.min(1.0, 2.0 * fastTintFrac);
          blendedSurface = Color.lerp(
                  blendedSurface, Color(primary99Argb), surfaceTintFrac) ??
              blendedSurface;
          final int surfaceArgb = blendedSurface.value;

          return {
            'primary': kIsWeb
                ? getWebSafeColor(Color(primaryArgb))
                : Color(primaryArgb),
            'secondary': kIsWeb
                ? getWebSafeColor(Color(secondaryArgb))
                : Color(secondaryArgb),
            'background': kIsWeb
                ? getWebSafeColor(Color(surfaceArgb))
                : Color(surfaceArgb),
          };
        }
      } catch (e) {
        // Image decode / worker failed — return hardcoded fallbacks
        debugPrint('Palette generation error (fast path): $e');
        return {
          'primary': fallbackPrimary,
          'secondary': fallbackSecondary,
          'background': fallbackBackground,
        };
      }
    } catch (e) {
      debugPrint('Palette generation error: $e');
      return {
        'primary': fallbackPrimary,
        'secondary': fallbackSecondary,
        'background': fallbackBackground,
      };
    }
    // Defensive fallback: ensure a non-null map is always returned.
    return {
      'primary': fallbackPrimary,
      'secondary': fallbackSecondary,
      'background': fallbackBackground,
    };
  }

  /// Generate a full Material [ColorScheme] from an [ImageProvider].
  ///
  /// This uses the background isolate worker to score the image colors and
  /// derive M3 tonal palettes, then maps those tones to ColorScheme roles.
  static Future<ColorScheme> generateColorScheme(ImageProvider image,
      {Brightness brightness = Brightness.light}) async {
    try {
      final completer = Completer<ImageInfo>();

      final ImageStream stream = image.resolve(ImageConfiguration.empty);

      final listener = ImageStreamListener((ImageInfo info, bool _) {
        if (!completer.isCompleted) {
          completer.complete(info);
        }
      }, onError: (exception, stackTrace) {
        if (!completer.isCompleted) {
          completer.completeError(exception, stackTrace);
        }
      });

      stream.addListener(listener);
      final ImageInfo imageInfo = await completer.future;
      stream.removeListener(listener);

      final ui.Image uiImage = imageInfo.image;
      final ByteData? bd =
          await uiImage.toByteData(format: ui.ImageByteFormat.rawRgba);
      if (bd == null) throw Exception('Invalid image data');

      final Uint8List pixels = bd.buffer.asUint8List();
      final Map<String, int> result = await compute(quantizeAndFindDominant, {
        'pixels': pixels,
        'width': uiImage.width,
        'height': uiImage.height,
      });

      int tone(String key, [int? fallback]) =>
          result[key] ?? fallback ?? result['base']!;

      // Map M3 tonal values to ColorScheme roles
      final Color primary = Color(tone('primary_40'));
      final Color onPrimary = Color(tone('primary_100'));
      final Color primaryContainer = Color(tone('primary_90'));
      final Color onPrimaryContainer = Color(tone('primary_10'));

      final Color secondary = Color(tone('secondary_80', tone('secondary_40')));
      final Color onSecondary = Color(tone('secondary_100'));
      final Color secondaryContainer = Color(tone('secondary_90'));
      final Color onSecondaryContainer = Color(tone('secondary_10'));

      final Color tertiary = Color(tone('tertiary_40'));
      final Color onTertiary = Color(tone('tertiary_100'));
      final Color tertiaryContainer = Color(tone('tertiary_90'));
      final Color onTertiaryContainer = Color(tone('tertiary_10'));

      // Prefer slightly darker neutral tones for surfaces to avoid near-white
      // backgrounds; fall back progressively if tones are missing. Then mix a
      // small amount of the light primary (primary_99) into the neutral so
      // backgrounds get a subtle tint.
      final Color neutralColor =
          Color(tone('neutral_95', tone('neutral_90', tone('neutral_99'))));
      final Color primary99Color =
          Color(tone('primary_99', tone('primary_90', tone('primary_80'))));
      // Double the adaptive tint for the surface to make the background
      // noticeably more tinted while keeping the fraction clamped.
      final double tintFrac =
          _adaptiveTintFraction(neutralColor, primary99Color);
      final double surfaceTintFrac = math.min(1.0, 2.0 * tintFrac);
      final Color surface =
          Color.lerp(neutralColor, primary99Color, surfaceTintFrac) ??
              neutralColor;
      final Color onSurface = Color(tone('neutral_10'));
      final Color surfaceVariant = Color(tone('neutralVariant_90'));
      final Color onSurfaceVariant = Color(tone('neutralVariant_30'));

      final Color outline = Color(tone('neutralVariant_50'));

      // Best-effort mappings for less-common tokens
      final Color inverseSurface = Color(tone('neutral_20'));
      final Color onInverseSurface = Color(tone('neutral_95'));
      final Color inversePrimary = Color(tone('primary_80'));

      // Error colors (use standard M3 error tones)
      const int errorVal = 0xFFB3261E;
      const int onErrorVal = 0xFFFFFFFF;
      const int errorContainerVal = 0xFFF9DEDC;
      const int onErrorContainerVal = 0xFF410E0B;

      final ColorScheme scheme = ColorScheme(
        brightness: brightness,
        primary: kIsWeb ? getWebSafeColor(primary) : primary,
        onPrimary: kIsWeb ? getWebSafeColor(onPrimary) : onPrimary,
        primaryContainer:
            kIsWeb ? getWebSafeColor(primaryContainer) : primaryContainer,
        onPrimaryContainer:
            kIsWeb ? getWebSafeColor(onPrimaryContainer) : onPrimaryContainer,
        secondary: kIsWeb ? getWebSafeColor(secondary) : secondary,
        onSecondary: kIsWeb ? getWebSafeColor(onSecondary) : onSecondary,
        secondaryContainer:
            kIsWeb ? getWebSafeColor(secondaryContainer) : secondaryContainer,
        onSecondaryContainer: kIsWeb
            ? getWebSafeColor(onSecondaryContainer)
            : onSecondaryContainer,
        tertiary: kIsWeb ? getWebSafeColor(tertiary) : tertiary,
        onTertiary: kIsWeb ? getWebSafeColor(onTertiary) : onTertiary,
        tertiaryContainer:
            kIsWeb ? getWebSafeColor(tertiaryContainer) : tertiaryContainer,
        onTertiaryContainer:
            kIsWeb ? getWebSafeColor(onTertiaryContainer) : onTertiaryContainer,
        error: const Color(errorVal),
        onError: const Color(onErrorVal),
        errorContainer: const Color(errorContainerVal),
        onErrorContainer: const Color(onErrorContainerVal),
        outline: kIsWeb ? getWebSafeColor(outline) : outline,
        outlineVariant:
            kIsWeb ? getWebSafeColor(onSurfaceVariant) : onSurfaceVariant,
        shadow: Colors.black,
        scrim: Colors.black,
        surface: kIsWeb ? getWebSafeColor(surface) : surface,
        onSurface: kIsWeb ? getWebSafeColor(onSurface) : onSurface,
        surfaceTint: kIsWeb ? getWebSafeColor(primary) : primary,
        surfaceContainerHighest:
            kIsWeb ? getWebSafeColor(surfaceVariant) : surfaceVariant,
        inverseSurface:
            kIsWeb ? getWebSafeColor(inverseSurface) : inverseSurface,
        onInverseSurface:
            kIsWeb ? getWebSafeColor(onInverseSurface) : onInverseSurface,
        inversePrimary:
            kIsWeb ? getWebSafeColor(inversePrimary) : inversePrimary,
        // Note: `background`/`onBackground` are deprecated; values are
        // represented by `surface`/`onSurface` above.
      );

      return scheme;
    } catch (e) {
      debugPrint('generateColorScheme failed: $e');
      // Fallback to a seed-based scheme
      return ColorScheme.fromSeed(
          seedColor: fallbackPrimary, brightness: brightness);
    }
  }

  static Color _ensureWebSafeColor(Color color) {
    // Use round instead of integer division to ensure consistent rounding behavior
    final int r = ((color.red / 51).round() * 51).clamp(0, 255);
    final int g = ((color.green / 51).round() * 51).clamp(0, 255);
    final int b = ((color.blue / 51).round() * 51).clamp(0, 255);

    return Color.fromARGB(255, r, g, b);
  }

  static Color getWebSafeColor(Color color) {
    if (kIsWeb) {
      return _ensureWebSafeColor(color);
    }
    return color;
  }

  static Color getWebSafeColorFromHex(String hexColor) {
    final int colorValue = int.parse(hexColor.replaceFirst('#', '0xFF'));
    final Color color = Color(colorValue);
    return getWebSafeColor(color);
  }

  static double _adaptiveTintFraction(Color neutral, Color primary) {
    // Use primary saturation and contrast against the neutral to decide
    // how strong the tint should be. Returns a fraction in [0.03, 0.30].
    final double sat = HSLColor.fromColor(primary).saturation; // 0..1
    final double lumN = neutral.computeLuminance();
    final double lumP = primary.computeLuminance();
    final double contrast =
        (math.max(lumN, lumP) + 0.05) / (math.min(lumN, lumP) + 0.05);

    // Stronger base tint strength for a more noticeable tint
    double frac = 0.10;
    // Increase with saturation (more vivid primaries -> stronger tint)
    // Raised multiplier so vivid primaries produce a larger effect.
    frac += sat * 0.30; // adds up to ~0.30
    // Increase with contrast between primary and neutral (stronger boost)
    // Use a slightly stronger scaling and higher cap to allow bolder tinting.
    frac += math.min((contrast - 1.0) / 4.0, 0.12);

    // Clamp to reasonable bounds (allow a stronger maximum tint)
    if (frac < 0.04) frac = 0.04;
    if (frac > 0.40) frac = 0.40;
    return frac;
  }

  /// Build a palette from a provided background [color].
  ///
  /// Algorithm:
  /// 1. Primary: rotate hue by [rotationDegrees] (default 137.5°) using HSL.
  /// 2. Secondary: desaturate the background by [desaturateFraction]
  ///    (default 0.6 means reduce saturation to 40% of original).
  /// 3. Background: the provided color (web-safe adjusted on web).
  static Map<String, Color> buildPaletteFromBackgroundColor(Color color,
      {double rotationDegrees = 137.5, double desaturateFraction = 0.6}) {
    // Use web-safe color for web targets
    final bg = getWebSafeColor(color);

    // Convert to HSL for hue rotation and saturation change
    final hsl = HSLColor.fromColor(bg);

    // Rotate hue
    final double newHue = (hsl.hue + rotationDegrees) % 360.0;
    final primaryHsl = hsl.withHue(newHue);

    // Desaturate background to produce secondary color
    final double newSaturation =
        (hsl.saturation * (1.0 - desaturateFraction)).clamp(0.0, 1.0);
    final secondaryHsl = hsl.withSaturation(newSaturation);

    return {
      'primary': primaryHsl.toColor(),
      'secondary': secondaryHsl.toColor(),
      'background': bg,
    };
  }

  /// Build palette from a hex color string like `#RRGGBB`.
  static Map<String, Color> buildPaletteFromHex(String hex,
      {double rotationDegrees = 137.5, double desaturateFraction = 0.6}) {
    try {
      final Color bg = getWebSafeColorFromHex(hex);
      return buildPaletteFromBackgroundColor(bg,
          rotationDegrees: rotationDegrees,
          desaturateFraction: desaturateFraction);
    } catch (_) {
      return {
        'primary': fallbackPrimary,
        'secondary': fallbackSecondary,
        'background': fallbackBackground,
      };
    }
  }
}
