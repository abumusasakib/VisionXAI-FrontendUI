import 'package:bloc/bloc.dart';
import 'package:vision_xai/features/settings/color_palette/presentation/cubit/palette_settings/palette_settings_state.dart';
import 'package:vision_xai/features/settings/color_palette/presentation/cubit/palette/palette_cubit.dart';
import 'package:vision_xai/features/settings/color_palette/data/datasource/palette_local_data_source.dart';

class PaletteSettingsCubit extends Cubit<PaletteSettingsState> {
  final PaletteCubit _paletteCubit;
  final PaletteLocalDataSource _local;

  PaletteSettingsCubit(this._paletteCubit, [PaletteLocalDataSource? local])
      : _local = local ?? PaletteLocalDataSource(),
        super(PaletteSettingsState());

  Future<void> loadOverrides() async {
    emit(state.copyWith(status: PaletteSettingsStatus.loading));
    try {
      final ov = await _local.getOverrides();
      emit(
          state.copyWith(status: PaletteSettingsStatus.success, overrides: ov));
    } catch (e) {
      emit(state.copyWith(
          status: PaletteSettingsStatus.failure, message: e.toString()));
    }
  }

  Future<void> saveOverrides(Map<String, String> overrides) async {
    emit(state.copyWith(status: PaletteSettingsStatus.loading));
    try {
      await _local.saveOverrides(overrides);
      // Refresh palette
      await _paletteCubit.updateColors();
      emit(state.copyWith(
          status: PaletteSettingsStatus.success, overrides: overrides));
    } catch (e) {
      emit(state.copyWith(
          status: PaletteSettingsStatus.failure, message: e.toString()));
    }
  }

  Future<void> clearOverrides() async {
    emit(state.copyWith(status: PaletteSettingsStatus.loading));
    try {
      await _local.clearOverrides();
      await _paletteCubit.updateColors();
      emit(state.copyWith(
          status: PaletteSettingsStatus.success, overrides: null));
    } catch (e) {
      emit(state.copyWith(
          status: PaletteSettingsStatus.failure, message: e.toString()));
    }
  }

  // Presets API
  Future<void> loadPresets() async {
    try {
      final p = await _local.getPresets();
      emit(state.copyWith(presets: p));
    } catch (e) {
      emit(state.copyWith(message: e.toString()));
    }
  }

  Future<void> saveNamedPreset(String name, Map<String, String> colors) async {
    try {
      await _local.savePreset(name, colors);
      await loadPresets();
      emit(state.copyWith(message: 'Preset saved'));
    } catch (e) {
      emit(state.copyWith(message: e.toString()));
    }
  }

  Future<void> deletePreset(String name) async {
    try {
      await _local.deletePreset(name);
      await loadPresets();
      emit(state.copyWith(message: 'Preset deleted'));
    } catch (e) {
      emit(state.copyWith(message: e.toString()));
    }
  }

  Future<void> applyPreset(String name) async {
    try {
      final p = await _local.getPresets();
      final colors = p[name];
      if (colors != null) {
        await saveOverrides(colors);
      }
    } catch (e) {
      emit(state.copyWith(message: e.toString()));
    }
  }
}
