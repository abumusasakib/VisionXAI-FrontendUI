export 'palette_state.dart';

import 'package:bloc/bloc.dart';
import 'dart:developer' as developer;
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
    developer.log('updateColors: requesting default icon palette',
        name: 'PaletteCubit');
    final palette =
        await _useCase.call(const AssetImage('assets/icon/icon.png'));
    developer.log('updateColors: generated palette keys: ${palette.keys}',
        name: 'PaletteCubit');

    final primary = palette['primary'] ?? const Color(0xFF089BB7);
    final secondary = palette['secondary'] ?? const Color(0xFF0FC0B8);
    final background = palette['background'] ?? const Color(0xFFFEFDFC);
    developer.log(
        'updateColors: emitting primary=${primary.value.toRadixString(16)}, secondary=${secondary.value.toRadixString(16)}, background=${background.value.toRadixString(16)}',
        name: 'PaletteCubit');

    emit(PaletteState(
      primaryColor: primary,
      secondaryColor: secondary,
      backgroundColor: background,
    ));
  }

  /// Generate palette from an arbitrary [ImageProvider]. Returns the
  /// generated palette map and updates the cubit state so listeners can
  /// react to the new colors.
  Future<Map<String, Color>> generateFromImage(ImageProvider image) async {
    developer.log('generateFromImage: generating from $image',
        name: 'PaletteCubit');
    final palette = await _useCase.call(image);
    developer.log('generateFromImage: result keys ${palette.keys}',
        name: 'PaletteCubit');

    final primary = palette['primary'] ?? const Color(0xFF089BB7);
    final secondary = palette['secondary'] ?? const Color(0xFF0FC0B8);
    final background = palette['background'] ?? const Color(0xFFFEFDFC);
    developer.log(
        'generateFromImage: emitting primary=${primary.value.toRadixString(16)}, secondary=${secondary.value.toRadixString(16)}, background=${background.value.toRadixString(16)}',
        name: 'PaletteCubit');

    emit(PaletteState(
      primaryColor: primary,
      secondaryColor: secondary,
      backgroundColor: background,
    ));

    return palette;
  }

  /// Update the cubit state directly from a palette map (used by UI helpers
  /// that compute palettes synchronously, for example from a hex string).
  void updateFromMap(Map<String, Color> palette) {
    developer.log(
        'updateFromMap: updating from provided map keys=${palette.keys}',
        name: 'PaletteCubit');
    final primary = palette['primary'] ?? const Color(0xFF089BB7);
    final secondary = palette['secondary'] ?? const Color(0xFF0FC0B8);
    final background = palette['background'] ?? const Color(0xFFFEFDFC);
    developer.log(
        'updateFromMap: emitting primary=${primary.value.toRadixString(16)}, secondary=${secondary.value.toRadixString(16)}, background=${background.value.toRadixString(16)}',
        name: 'PaletteCubit');
    emit(PaletteState(
      primaryColor: primary,
      secondaryColor: secondary,
      backgroundColor: background,
    ));
  }
}
