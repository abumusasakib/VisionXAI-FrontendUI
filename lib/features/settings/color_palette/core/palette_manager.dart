import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/services.dart' show rootBundle;
import 'package:image/image.dart' as img;

class PaletteManager {
  static const Color fallbackPrimary = Color(0xFF089BB7); // Blue Green
  static const Color fallbackSecondary = Color(0xFF0FC0B8); // Light Sea Green
  static const Color fallbackBackground = Color(0xFFFEFDFC); // White 2

  static Future<Map<String, Color>> generatePalette(ImageProvider image) async {
    try {
      // If the ImageProvider is a FileImage or AssetImage we can obtain raw
      // bytes and run a CPU-bound color extraction in an isolate via
      // compute (implemented here using a lightweight sampling algorithm).
      // For other providers we fall back to PaletteGenerator which uses
      // the engine's ui.Image and runs on the UI thread.
      if (image is FileImage) {
        final bytes = await image.file.readAsBytes();
        final result = _computePaletteFromBytes(bytes);
        return {
          'primary': getWebSafeColor(Color(result['primary']!)),
          'secondary': getWebSafeColor(Color(result['secondary']!)),
          'background': getWebSafeColor(Color(result['background']!)),
        };
      }

      if (image is AssetImage) {
        final data = await rootBundle.load(image.assetName);
        final bytes = data.buffer.asUint8List();
        final result = _computePaletteFromBytes(bytes);
        return {
          'primary': getWebSafeColor(Color(result['primary']!)),
          'secondary': getWebSafeColor(Color(result['secondary']!)),
          'background': getWebSafeColor(Color(result['background']!)),
        };
      }

      // Fallback: use PaletteGenerator for other ImageProvider types.
      final completer = Completer<ImageInfo>();
      final ImageStream stream = image.resolve(ImageConfiguration.empty);
      final listener = ImageStreamListener((ImageInfo info, bool _) {
        if (!completer.isCompleted) completer.complete(info);
      }, onError: (exception, stackTrace) {
        if (!completer.isCompleted) completer.completeError(exception, stackTrace);
      });
      stream.addListener(listener);
      final imageInfo = await completer.future;
      stream.removeListener(listener);
      final PaletteGenerator paletteGenerator = await PaletteGenerator.fromImage(imageInfo.image);
      return {
        'primary': kIsWeb ? getWebSafeColor(fallbackPrimary) : paletteGenerator.dominantColor?.color ?? fallbackPrimary,
        'secondary': kIsWeb ? getWebSafeColor(fallbackSecondary) : paletteGenerator.lightVibrantColor?.color ?? fallbackSecondary,
        'background': kIsWeb ? getWebSafeColor(fallbackBackground) : paletteGenerator.lightMutedColor?.color ?? fallbackBackground,
      };
    } catch (e) {
      debugPrint('Palette generation error: $e');
      return {
        'primary': fallbackPrimary,
        'secondary': fallbackSecondary,
        'background': fallbackBackground,
      };
    }
  }

  /// A lightweight palette extraction implementation that operates on raw
  /// image bytes. It decodes the image using `package:image` and samples
  /// pixels to produce primary/secondary/background colors. This is
  /// intentionally simple and fast; it is designed to be safe to run in an
  /// isolate (we call it from the main thread here, but it's pure Dart
  /// computation and could be moved to `compute` if desired).
  static Map<String, int> _computePaletteFromBytes(List<int> bytes) {
    try {
      final decoded = img.decodeImage(bytes);
      if (decoded == null) {
        return {
          'primary': fallbackPrimary.value,
          'secondary': fallbackSecondary.value,
          'background': fallbackBackground.value,
        };
      }

      final w = decoded.width;
      final h = decoded.height;
      // Choose sampling step so we inspect at most ~10000 pixels.
      final area = (w * h).toDouble();
      final target = 10000.0;
      final factor = math.sqrt(math.max(1.0, area / target));
      final stepX = math.max(1, factor.floor());
      final stepY = math.max(1, factor.floor());

      int sumR = 0;
      int sumG = 0;
      int sumB = 0;
      int count = 0;

      int borderSumR = 0;
      int borderSumG = 0;
      int borderSumB = 0;
      int borderCount = 0;

      // First pass: compute overall average and border average.
      for (int y = 0; y < h; y += stepY) {
        for (int x = 0; x < w; x += stepX) {
          final c = decoded.getPixel(x, y);
          final r = img.getRed(c);
          final g = img.getGreen(c);
          final b = img.getBlue(c);
          sumR += r;
          sumG += g;
          sumB += b;
          count++;

          // border defined as within 5% of edges
          final borderThresholdX = (w * 0.05).ceil();
          final borderThresholdY = (h * 0.05).ceil();
          if (x <= borderThresholdX || x >= w - borderThresholdX || y <= borderThresholdY || y >= h - borderThresholdY) {
            borderSumR += r;
            borderSumG += g;
            borderSumB += b;
            borderCount++;
          }
        }
      }

      if (count == 0) {
        return {
          'primary': fallbackPrimary.value,
          'secondary': fallbackSecondary.value,
          'background': fallbackBackground.value,
        };
      }

      final avgR = (sumR / count).round();
      final avgG = (sumG / count).round();
      final avgB = (sumB / count).round();

      // Compute background as border average when available, else use overall average
      final bgR = borderCount > 0 ? (borderSumR / borderCount).round() : avgR;
      final bgG = borderCount > 0 ? (borderSumG / borderCount).round() : avgG;
      final bgB = borderCount > 0 ? (borderSumB / borderCount).round() : avgB;

      // Secondary: choose a color slightly desaturated or lighter than primary
      // Derive HSL-like adjustments using simple arithmetic on RGB
      int secR = ((avgR + 255) / 2).round();
      int secG = ((avgG + 255) / 2).round();
      int secB = ((avgB + 255) / 2).round();

      // Clamp
      secR = secR.clamp(0, 255);
      secG = secG.clamp(0, 255);
      secB = secB.clamp(0, 255);

      final primary = (0xFF << 24) | (avgR << 16) | (avgG << 8) | avgB;
      final secondary = (0xFF << 24) | (secR << 16) | (secG << 8) | secB;
      final background = (0xFF << 24) | (bgR << 16) | (bgG << 8) | bgB;

      return {
        'primary': primary,
        'secondary': secondary,
        'background': background,
      };
    } catch (_) {
      return {
        'primary': fallbackPrimary.value,
        'secondary': fallbackSecondary.value,
        'background': fallbackBackground.value,
      };
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
