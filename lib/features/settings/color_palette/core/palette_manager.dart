import 'dart:developer';

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
      // High-level flow:
      // 1) Resolve the given `ImageProvider` into a fully decoded `ui.Image`.
      // 2) Extract raw RGBA bytes from the ui.Image using `toByteData`.
      // 3) Send the raw pixel buffer, width and height to a background
      //    isolate via `compute(...)` where `quantizeAndFindDominant` will
      //    perform color quantization and produce tonal ARGB integers.
      // 4) Choose preferred tonal steps for `primary`, `secondary` and a
      //    neutral `surface`/`background` value using fallbacks to ensure a
      //    usable palette even when some tones are missing.
      // 5) Apply a subtle tint blend to the surface color so backgrounds
      //    are not purely neutral white on some images.
      // 6) Return a small map of canonical roles -> Color.
      try {
        // Convert the ImageProvider -> ImageInfo by listening to the image
        // stream. This is necessary because many ImageProviders (Network,
        // Asset, Memory) resolve asynchronously and we need the decoded
        // pixel data which lives on the resolved `ui.Image`.
        final completer = Completer<ImageInfo>();

        final ImageStream stream = image.resolve(ImageConfiguration.empty);

        // Single-shot listener: complete the completer when the image is
        // available, or complete with error on failure. We guard against
        // multiple invocations by checking `completer.isCompleted`.
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

        // Await the fully decoded image (this yields a ui.Image we can read
        // pixels from). We remove the listener afterwards to avoid leaks.
        final ImageInfo imageInfo = await completer.future;
        stream.removeListener(listener);

        // Extract raw RGBA bytes from the ui.Image. We request
        // `ui.ImageByteFormat.rawRgba` to get a contiguous packed buffer
        // that the quantizer can operate on directly.
        final ui.Image uiImage = imageInfo.image;
        final ByteData? bd =
            await uiImage.toByteData(format: ui.ImageByteFormat.rawRgba);
        if (bd != null) {
          final Uint8List pixels = bd.buffer.asUint8List();

          // Run the quantizer + tonal extraction in a background isolate
          // to avoid jank. The worker returns a map of tonal keys -> ARGB
          // integer values (e.g. 'primary_40', 'neutral_95', 'base', etc.).
          final Map<String, int> result =
              await compute(quantizeAndFindDominant, {
            'pixels': pixels,
            'width': uiImage.width,
            'height': uiImage.height,
          });

          // The worker provides many candidate tones. Choose preferred
          // tones with graceful fallbacks so we always return sensible
          // colors even if some tonal steps are missing for the image.
          // For primary we prefer a mid-tone (40) to provide a distinct
          // accent color. If that is missing, fall back to the scored
          // primary or the base color.
          final int primaryArgb =
              result['primary_40'] ?? result['primary'] ?? result['base']!;

          // For the secondary color prefer a lighter tone (80 -> 60 -> 40)
          // because some images yield very dark secondaries; falling back
          // progressively produces more usable accents.
          final int secondaryArgb = result['secondary_80'] ??
              result['secondary_60'] ??
              result['secondary_40'] ??
              result['secondary'] ??
              result['base']!;

          // For the neutral/surface color prefer a slightly darker neutral
          // (neutral_95/90/99) or a 'surface' token if present. We then
          // subtly mix a very light primary (primary_99) into the neutral
          // to produce a gently tinted surface rather than a flat white.
          final int neutralArgb = result['surface'] ??
              result['neutral_95'] ??
              result['neutral_90'] ??
              result['neutral_99'] ??
              result['base']!;
          final int primary99Argb =
              result['primary_99'] ?? result['primary'] ?? result['base']!;

          // Blend the neutral toward the light primary by an adaptive
          // amount. The adaptive fraction depends on saturation/contrast
          // so strongly tinted images produce a larger tint without
          // exceeding the clamp of 1.0.
          Color blendedSurface = Color(neutralArgb);
          final double fastTintFrac =
              _adaptiveTintFraction(blendedSurface, Color(primary99Argb));
          final double surfaceTintFrac = math.min(1.0, 2.0 * fastTintFrac);
          blendedSurface = Color.lerp(
                  blendedSurface, Color(primary99Argb), surfaceTintFrac) ??
              blendedSurface;
          final int surfaceArgb = blendedSurface.value;

          // Return a small, canonical map of role -> Color. On web we map
          // colors to a web-safe palette to avoid display artifacts.
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
        // If image decoding, byte extraction or the worker fails we log
        // and return hardcoded fallback colors so callers always receive a
        // usable palette instead of crashing or returning nulls.
        log('Palette generation error (fast path): $e',
            name: 'PaletteManager', level: 900);
        return {
          'primary': fallbackPrimary,
          'secondary': fallbackSecondary,
          'background': fallbackBackground,
        };
      }
    } catch (e) {
      // Catch-all guard: if anything unexpected bubbles up, return
      // deterministic fallbacks and log the problem for diagnostics.
      log('Palette generation error: $e', name: 'PaletteManager', level: 900);
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
      );

      return scheme;
    } catch (e) {
      log('generateColorScheme failed: $e', name: 'PaletteManager', level: 900);
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
  /// Algorithm improvements:
  /// 1. Primary: desaturate the background by [desaturateFraction]
  /// 2. Secondary: use complementary or analogous harmony with dynamic adjustments
  /// 3. Ensure proper contrast ratios for both accessibility and aesthetics
  /// 4. Balance saturation levels across the palette
  static Map<String, Color> buildPaletteFromBackgroundColor(Color color,
      {double rotationDegrees = 137.5,
      double desaturateFraction = 0.6,
      bool useComplementary = false}) {
    // Use web-safe color for web targets
    final bg = getWebSafeColor(color);

    // Convert to HSL for hue rotation and saturation change
    final hsl = HSLColor.fromColor(bg);

    // Desaturate background to produce primary color
    final double newSaturation =
        (hsl.saturation * (1.0 - desaturateFraction)).clamp(0.0, 1.0);
    final HSLColor primaryHsl = hsl.withSaturation(newSaturation);

    // Calculate secondary hue based on harmony type
    double secondaryHue;
    if (useComplementary) {
      // Complementary: opposite on color wheel (180°)
      secondaryHue = (hsl.hue + 180.0) % 360.0;
    } else {
      // Split-complementary or triadic for more subtle harmony
      secondaryHue = (hsl.hue + rotationDegrees) % 360.0;
    }

    // Adjust secondary saturation based on background saturation
    // If background is highly saturated, use moderate saturation for secondary
    // If background is muted, allow higher saturation for pop
    double secondarySaturation;
    if (hsl.saturation > 0.6) {
      secondarySaturation = (hsl.saturation * 0.7).clamp(0.3, 0.8);
    } else if (hsl.saturation < 0.3) {
      secondarySaturation = (hsl.saturation + 0.4).clamp(0.4, 0.9);
    } else {
      secondarySaturation = (hsl.saturation * 0.85).clamp(0.4, 0.85);
    }

    // Adjust secondary lightness to balance with background
    // Aim for visual weight balance
    double secondaryLightness;
    if (hsl.lightness > 0.6) {
      // Light background: make secondary darker for contrast
      secondaryLightness = (hsl.lightness - 0.25).clamp(0.3, 0.5);
    } else if (hsl.lightness < 0.4) {
      // Dark background: make secondary lighter
      secondaryLightness = (hsl.lightness + 0.3).clamp(0.5, 0.7);
    } else {
      // Medium background: adjust based on saturation
      secondaryLightness = hsl.saturation > 0.5
          ? (hsl.lightness - 0.15).clamp(0.35, 0.65)
          : (hsl.lightness + 0.1).clamp(0.4, 0.7);
    }

    HSLColor secondaryHsl = HSLColor.fromAHSL(
      1.0,
      secondaryHue,
      secondarySaturation,
      secondaryLightness,
    );

    // Convert to Color values for contrast checks
    Color primaryColor = primaryHsl.toColor();
    Color secondaryColor = secondaryHsl.toColor();

    // Helper function to calculate contrast ratio
    double contrast(Color a, Color b) {
      final double la = a.computeLuminance();
      final double lb = b.computeLuminance();
      return (math.max(la, lb) + 0.05) / (math.min(la, lb) + 0.05);
    }

    // Ensure secondary contrasts with BOTH primary and background
    const double minContrastWithPrimary = 3.0;
    const double minContrastWithBackground = 2.5;

    double contrastWithPrimary = contrast(primaryColor, secondaryColor);
    double contrastWithBg = contrast(bg, secondaryColor);

    // Optimize contrast if needed
    if (contrastWithPrimary < minContrastWithPrimary ||
        contrastWithBg < minContrastWithBackground) {
      double bestScore = _calculateHarmonyScore(
        contrastWithPrimary,
        contrastWithBg,
        minContrastWithPrimary,
        minContrastWithBackground,
      );
      HSLColor bestCandidate = secondaryHsl;

      // Try adjusting lightness in both directions
      final double baseLightness = secondaryHsl.lightness;
      for (int i = 1; i <= 8; i++) {
        final double delta = 0.05 * i;

        // Try lighter
        final HSLColor lighter =
            secondaryHsl.withLightness((baseLightness + delta).clamp(0.0, 1.0));
        final Color lighterColor = lighter.toColor();
        final double cp = contrast(primaryColor, lighterColor);
        final double cb = contrast(bg, lighterColor);
        final double score = _calculateHarmonyScore(
            cp, cb, minContrastWithPrimary, minContrastWithBackground);

        if (score > bestScore) {
          bestScore = score;
          bestCandidate = lighter;
        }

        // Try darker
        final HSLColor darker =
            secondaryHsl.withLightness((baseLightness - delta).clamp(0.0, 1.0));
        final Color darkerColor = darker.toColor();
        final double cpD = contrast(primaryColor, darkerColor);
        final double cbD = contrast(bg, darkerColor);
        final double scoreD = _calculateHarmonyScore(
            cpD, cbD, minContrastWithPrimary, minContrastWithBackground);

        if (scoreD > bestScore) {
          bestScore = scoreD;
          bestCandidate = darker;
        }

        // Early exit if we've achieved good contrast with both
        if (bestScore >= minContrastWithPrimary + minContrastWithBackground) {
          break;
        }
      }

      secondaryHsl = bestCandidate;
      secondaryColor = secondaryHsl.toColor();
    }

    // Apply web-safe adjustment on web
    final Color outPrimary =
        kIsWeb ? getWebSafeColor(primaryColor) : primaryColor;
    final Color outSecondary =
        kIsWeb ? getWebSafeColor(secondaryColor) : secondaryColor;

    return {
      'primary': outPrimary,
      'secondary': outSecondary,
      'background': bg,
    };
  }

  /// Calculate a harmony score based on contrast ratios with targets
  static double _calculateHarmonyScore(
    double contrastWithPrimary,
    double contrastWithBg,
    double targetPrimary,
    double targetBg,
  ) {
    // Reward meeting minimums, but also reward exceeding them moderately
    final double primaryScore = contrastWithPrimary >= targetPrimary
        ? targetPrimary + math.min(contrastWithPrimary - targetPrimary, 3.0)
        : contrastWithPrimary;

    final double bgScore = contrastWithBg >= targetBg
        ? targetBg + math.min(contrastWithBg - targetBg, 2.0)
        : contrastWithBg;

    // Weight primary contrast slightly more than background
    return (primaryScore * 1.2) + bgScore;
  }

  /// Build palette from a hex color string like `#RRGGBB`.
  static Map<String, Color> buildPaletteFromHex(String hex,
      {double rotationDegrees = 137.5, double desaturateFraction = 0.6}) {
    try {
      final Color bg = getWebSafeColorFromHex(hex);
      return buildPaletteFromBackgroundColor(bg,
          rotationDegrees: rotationDegrees,
          desaturateFraction: desaturateFraction,
          useComplementary: true);
    } catch (_) {
      return {
        'primary': fallbackPrimary,
        'secondary': fallbackSecondary,
        'background': fallbackBackground,
      };
    }
  }
}
