enum PaletteSettingsStatus { initial, loading, success, failure }

class PaletteSettingsState {
  final PaletteSettingsStatus status;
  final Map<String, String>? overrides;
  final Map<String, Map<String, String>>? presets;
  final String? message;

  PaletteSettingsState({
    this.status = PaletteSettingsStatus.initial,
    this.overrides,
    this.presets,
    this.message,
  });

  PaletteSettingsState copyWith({
    PaletteSettingsStatus? status,
    Map<String, String>? overrides,
    Map<String, Map<String, String>>? presets,
    String? message,
  }) {
    return PaletteSettingsState(
      status: status ?? this.status,
      overrides: overrides ?? this.overrides,
      presets: presets ?? this.presets,
      message: message ?? this.message,
    );
  }
}
