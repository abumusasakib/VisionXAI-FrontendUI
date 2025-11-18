import 'package:flutter/material.dart';

/// Abstraction for palette generation so higher layers don't depend on
/// concrete implementations.
abstract class PaletteRepo {
  /// Generate a palette from the provided [image]. Returns a map with keys
  /// 'primary', 'secondary', and 'background'. Implementations should
  /// provide sensible fallbacks on error.
  Future<Map<String, Color>> generatePalette(ImageProvider image);
}
