import 'package:flutter/material.dart';
import '../repository/palette_repo.dart';

class PaletteUC {
  final PaletteRepo _repo;

  PaletteUC(this._repo);

  Future<Map<String, Color>> call(ImageProvider image) {
    return _repo.generatePalette(image);
  }
}
