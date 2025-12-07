import 'package:bloc/bloc.dart';
import 'dart:developer' as developer;
import 'package:vision_xai/features/settings/color_palette/presentation/cubit/palette_settings/palette_settings_state.dart';
import 'package:vision_xai/features/settings/color_palette/presentation/cubit/palette/palette_cubit.dart';
import 'package:vision_xai/features/settings/color_palette/data/datasource/local/palette_local_data_source.dart';

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
      final storedTs = await _local.getOverridesUpdatedAt();
      developer.log('loadOverrides: loaded overrides=$ov',
          name: 'PaletteSettingsCubit');
      // Use the stored timestamp, if any. This timestamp represents when the
      // overrides were saved by the user and must be preserved across app
      // restarts or cubit recreation so it can be compared against transient
      // preview timestamps.
      developer.log('loadOverrides: storedTimestamp=$storedTs',
          name: 'PaletteSettingsCubit');
      emit(state.copyWith(
          status: PaletteSettingsStatus.success,
          overrides: ov,
          overridesUpdatedAt: storedTs,
          clearOverridesTimestamp: ov == null));
    } catch (e) {
      developer.log('loadOverrides: error $e', name: 'PaletteSettingsCubit');
      emit(state.copyWith(
          status: PaletteSettingsStatus.failure, message: e.toString()));
    }
  }

  Future<void> saveOverrides(Map<String, String> overrides) async {
    emit(state.copyWith(status: PaletteSettingsStatus.loading));
    try {
      developer.log('saveOverrides: saving overrides=$overrides',
          name: 'PaletteSettingsCubit');
      await _local.saveOverrides(overrides);
      // Refresh palette
      await _paletteCubit.updateColors();
      // Update the overrides timestamp to mark when the user last saved.
      // Do NOT clear it; preserve a timestamp so subsequent reloads don't
      // create a newer timestamp and overwrite user-generated previews.
      // Clear only the transient preview colors as they are no longer needed.
      developer.log('saveOverrides: saved and refreshed PaletteCubit',
          name: 'PaletteSettingsCubit');
      emit(state.copyWith(
          status: PaletteSettingsStatus.success,
          overrides: overrides,
          overridesUpdatedAt: DateTime.now(),
          previewColors: null,
          clearPreviewTimestamp: true));
    } catch (e) {
      developer.log('saveOverrides: error $e', name: 'PaletteSettingsCubit');
      emit(state.copyWith(
          status: PaletteSettingsStatus.failure, message: e.toString()));
    }
  }

  Future<void> clearOverrides() async {
    emit(state.copyWith(status: PaletteSettingsStatus.loading));
    try {
      developer.log('clearOverrides: clearing persisted overrides',
          name: 'PaletteSettingsCubit');
      await _local.clearOverrides();
      await _paletteCubit.updateColors();
      // Clear persisted overrides and any transient previews so UI shows the
      // dynamically generated palette from the repo.
      developer.log('clearOverrides: cleared and refreshed PaletteCubit',
          name: 'PaletteSettingsCubit');
      emit(state.copyWith(
          status: PaletteSettingsStatus.success,
          overrides: null,
          clearOverridesTimestamp: true,
          previewColors: null,
          clearPreviewTimestamp: true));
    } catch (e) {
      developer.log('clearOverrides: error $e', name: 'PaletteSettingsCubit');
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

  /// Update the preview color for a particular field (identified by [key]).
  /// Passing a null or empty [hex] will remove the preview for that key.
  void updatePreviewColor(String key, String? hex) {
    final current = Map<String, String>.from(state.previewColors ?? {});
    if (hex == null || hex.trim().isEmpty) {
      current.remove(key);
      developer.log('updatePreviewColor: removed preview for key=$key',
          name: 'PaletteSettingsCubit');
    } else {
      current[key] = hex.trim();
      developer.log('updatePreviewColor: set preview $key=$hex',
          name: 'PaletteSettingsCubit');
    }
    emit(state.copyWith(
        previewColors: current, previewColorsUpdatedAt: DateTime.now()));
  }
}
