/// Small utility helpers for attention/visualization features.
/// The template provides a minimal placeholder that the developer can extend.

class AttentionUtils {
  /// Convert a normalized attention value (0..1) to an alpha value for overlay.
  static double attentionToAlpha(double v) => v.clamp(0.0, 1.0).toDouble();
}
