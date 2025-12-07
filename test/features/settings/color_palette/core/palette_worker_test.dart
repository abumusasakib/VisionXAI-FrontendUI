import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:vision_xai/features/settings/color_palette/core/palette_worker.dart';

void main() {
  test('quantizeAndFindDominant returns tonal map for simple payload', () {
    // Two opaque pixels: red and blue
    final pixels = Uint8List.fromList([
      255, 0, 0, 255, // opaque red
      0, 0, 255, 255, // opaque blue
    ]);

    final payload = {'pixels': pixels, 'width': 2, 'height': 1};

    final Map<String, int> out = quantizeAndFindDominant(payload);

    expect(out, isNotEmpty);
    // Worker always provides a scored base or a fallback base key
    expect(out.containsKey('base') || out.containsKey('baseColor'), isTrue);
    // Primary tonal entries should be present in the returned map
    expect(out.keys.any((k) => k.startsWith('primary_')), isTrue);
    // Values are integers representing ARGB colors
    final firstKey = out.keys.first;
    expect(out[firstKey], isA<int>());
  });

  test('quantizeAndFindDominant returns fallback for all-transparent payload',
      () {
    // Two fully transparent pixels (alpha=0) -> worker should return fallback
    final pixels = Uint8List.fromList([
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
    ]);

    final payload = {'pixels': pixels, 'width': 2, 'height': 1};
    final Map<String, int> out = quantizeAndFindDominant(payload);

    // For an empty frequency map the worker returns {'baseColor': 0xFF888888}
    expect(out.containsKey('baseColor'), isTrue);
    expect(out['baseColor'], equals(0xFF888888));
  });
}
