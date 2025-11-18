import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/painting.dart';
import 'package:vision_xai/features/settings/color_palette/domain/use_case/palette_uc.dart';
import 'package:vision_xai/features/settings/color_palette/domain/repository/palette_repo.dart';
import 'package:flutter/material.dart';

class FakeRepo implements PaletteRepo {
  final Map<String, Color> result;
  FakeRepo(this.result);
  @override
  Future<Map<String, Color>> generatePalette(ImageProvider image) async {
    return result;
  }
}

void main() {
  test('PaletteUC delegates to repo', () async {
    final expected = {
      'primary': const Color(0xFF112233),
      'secondary': const Color(0xFF445566),
      'background': const Color(0xFF778899),
    };

    final uc = PaletteUC(FakeRepo(expected));
    final res = await uc.call(MemoryImage(Uint8List(0)));
    expect(res, equals(expected));
  });
}
