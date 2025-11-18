import 'package:flutter/material.dart';
import '../../core/palette_manager.dart';
import '../../domain/repository/palette_repo.dart';
import '../datasource/palette_local_data_source.dart';

class PaletteRepoImpl implements PaletteRepo {
  final PaletteLocalDataSource _local;

  PaletteRepoImpl([PaletteLocalDataSource? local])
      : _local = local ?? PaletteLocalDataSource();

  @override
  Future<Map<String, Color>> generatePalette(ImageProvider image) async {
    // Check for user overrides stored locally first.
    try {
      final overrides = await _local.getOverrides();
      if (overrides != null) {
        final Map<String, Color> map = {};
        if (overrides.containsKey('primary')) {
          map['primary'] =
              PaletteManager.getWebSafeColorFromHex(overrides['primary']!);
        }
        if (overrides.containsKey('secondary')) {
          map['secondary'] =
              PaletteManager.getWebSafeColorFromHex(overrides['secondary']!);
        }
        if (overrides.containsKey('background')) {
          map['background'] =
              PaletteManager.getWebSafeColorFromHex(overrides['background']!);
        }
        if (map.isNotEmpty) return map;
      }
    } catch (_) {
      // If anything goes wrong reading overrides, fall back to dynamic generation.
    }

    // Delegate to PaletteManager which contains the image handling and
    // fallback behaviour.
    return PaletteManager.generatePalette(image);
  }
}
