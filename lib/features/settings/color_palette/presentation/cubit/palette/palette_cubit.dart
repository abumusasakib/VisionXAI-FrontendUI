export 'palette_state.dart';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../../../domain/use_case/palette_uc.dart';
import 'palette_state.dart';

class PaletteCubit extends Cubit<PaletteState> {
  final PaletteUC _useCase;

  PaletteCubit(this._useCase)
      : super(PaletteState(
          primaryColor: const Color(0xFF089BB7), // Default Blue Green
          secondaryColor: const Color(0xFF0FC0B8), // Default Light Sea Green
          backgroundColor: const Color(0xFFFEFDFC), // Default White
        ));

  Future<void> updateColors() async {
    final palette =
        await _useCase.call(const AssetImage('assets/icon/icon.png'));

    emit(PaletteState(
      primaryColor: palette['primary'] ?? const Color(0xFF089BB7),
      secondaryColor: palette['secondary'] ?? const Color(0xFF0FC0B8),
      backgroundColor: palette['background'] ?? const Color(0xFFFEFDFC),
    ));
  }

  /// Generate palette from an arbitrary [ImageProvider]. Returns the
  /// generated palette map and updates the cubit state so listeners can
  /// react to the new colors.
  Future<Map<String, Color>> generateFromImage(ImageProvider image) async {
    final palette = await _useCase.call(image);

    emit(PaletteState(
      primaryColor: palette['primary'] ?? const Color(0xFF089BB7),
      secondaryColor: palette['secondary'] ?? const Color(0xFF0FC0B8),
      backgroundColor: palette['background'] ?? const Color(0xFFFEFDFC),
    ));

    return palette;
  }
}
