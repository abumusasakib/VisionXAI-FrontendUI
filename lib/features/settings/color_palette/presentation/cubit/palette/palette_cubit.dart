export 'palette_state.dart';

import 'package:bloc/bloc.dart';
import 'package:logging/logging.dart';
import 'package:flutter/material.dart';
import 'package:vision_xai/features/settings/color_palette/core/utils/palette_utils.dart';
import '../../../domain/use_case/palette_uc.dart';
import 'palette_state.dart';

final _logger = Logger('PaletteCubit');

class PaletteCubit extends Cubit<PaletteState> {
  final PaletteUC _useCase;

  PaletteCubit(this._useCase)
    : super(
        PaletteState(
          primaryColor: const Color(0xFF089BB7), // Default Blue Green
          secondaryColor: const Color(0xFF0FC0B8), // Default Light Sea Green
          backgroundColor: const Color(0xFFFEFDFC), // Default White
        ),
      );

  Future<void> updateColors() async {
    _logger.info('updateColors: requesting default icon palette');
    final palette = await _useCase.call(
      const AssetImage('assets/icon/icon.png'),
    );
    _logger.info('updateColors: generated palette keys: ${palette.keys}');

    final primary = palette['primary'] ?? const Color(0xFF089BB7);
    final secondary = palette['secondary'] ?? const Color(0xFF0FC0B8);
    final background = palette['background'] ?? const Color(0xFFFEFDFC);
    _logger.info(
      'updateColors: emitting primary=${toHex(primary)}, secondary=${toHex(secondary)}, background=${toHex(background)}',
    );

    emit(
      PaletteState(
        primaryColor: primary,
        secondaryColor: secondary,
        backgroundColor: background,
      ),
    );
  }

  /// Generate palette from an arbitrary [ImageProvider]. Returns the
  /// generated palette map and updates the cubit state so listeners can
  /// react to the new colors.
  Future<Map<String, Color>> generateFromImage(ImageProvider image) async {
    _logger.info('generateFromImage: generating from $image');
    final palette = await _useCase.call(image);
    _logger.info('generateFromImage: result keys ${palette.keys}');

    final primary = palette['primary'] ?? const Color(0xFF089BB7);
    final secondary = palette['secondary'] ?? const Color(0xFF0FC0B8);
    final background = palette['background'] ?? const Color(0xFFFEFDFC);
    _logger.info(
      'generateFromImage: emitting primary=${toHex(primary)}, secondary=${toHex(secondary)}, background=${toHex(background)}',
    );

    emit(
      PaletteState(
        primaryColor: primary,
        secondaryColor: secondary,
        backgroundColor: background,
      ),
    );

    return palette;
  }

  /// Update the cubit state directly from a palette map (used by UI helpers
  /// that compute palettes synchronously, for example from a hex string).
  void updateFromMap(Map<String, Color> palette) {
    _logger.info(
      'updateFromMap: updating from provided map keys=${palette.keys}',
    );
    final primary = palette['primary'] ?? const Color(0xFF089BB7);
    final secondary = palette['secondary'] ?? const Color(0xFF0FC0B8);
    final background = palette['background'] ?? const Color(0xFFFEFDFC);
    _logger.info(
      'updateFromMap: emitting primary=${toHex(primary)}, secondary=${toHex(secondary)}, background=${toHex(background)}',
    );
    emit(
      PaletteState(
        primaryColor: primary,
        secondaryColor: secondary,
        backgroundColor: background,
      ),
    );
  }
}
