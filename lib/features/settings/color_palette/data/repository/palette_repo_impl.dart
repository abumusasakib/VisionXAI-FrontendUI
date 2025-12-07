import 'package:flutter/material.dart';
import '../../core/palette_manager.dart';
import '../../domain/repository/palette_repo.dart';
import '../datasource/local/palette_local_data_source.dart';
import 'dart:developer' as developer;

class PaletteRepoImpl implements PaletteRepo {
  final PaletteLocalDataSource _local;

  PaletteRepoImpl([PaletteLocalDataSource? local])
      : _local = local ?? PaletteLocalDataSource();

  @override
  Future<Map<String, Color>> generatePalette(ImageProvider image) async {
    // Only honor user overrides when requesting the default app icon palette.
    // When generating from an arbitrary image (user-picked), we should always
    // compute a fresh palette and ignore previously saved overrides so the
    // generated colors reflect the image contents.
    try {
      if (image is AssetImage && image.assetName == 'assets/icon/icon.png') {
        final overrides = await _local.getOverrides();
        developer.log(
            'PaletteRepoImpl.generatePalette: loaded overrides=$overrides for asset icon',
            name: 'PaletteRepoImpl');
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
          if (map.isNotEmpty) {
            developer.log(
                'PaletteRepoImpl.generatePalette: returning overrides-as-palette=$map',
                name: 'PaletteRepoImpl');
            return map;
          }
        }
      }
    } catch (_) {
      // If anything goes wrong reading overrides, fall back to dynamic generation.
    }

    // Delegate to PaletteManager which contains the image handling and
    // fallback behaviour.
    return PaletteManager.generatePalette(image);
  }
}
