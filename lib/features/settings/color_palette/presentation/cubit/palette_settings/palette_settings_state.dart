enum PaletteSettingsStatus { initial, loading, success, failure }

class PaletteSettingsState {
  final PaletteSettingsStatus status;
  final Map<String, String>? overrides;
  final Map<String, Map<String, String>>? presets;
  final Map<String, String>? previewColors;
  // Timestamps indicating when the overrides and previewColors maps were
  // last updated. These are used to deterministically prefer the newest
  // values when deciding whether to apply persisted overrides over
  // transient user-generated previews.
  final DateTime? overridesUpdatedAt;
  final DateTime? previewColorsUpdatedAt;
  final String? message;

  PaletteSettingsState({
    this.status = PaletteSettingsStatus.initial,
    this.overrides,
    this.presets,
    this.previewColors,
    this.overridesUpdatedAt,
    this.previewColorsUpdatedAt,
    this.message,
  });

  PaletteSettingsState copyWith({
    PaletteSettingsStatus? status,
    Map<String, String>? overrides,
    Map<String, Map<String, String>>? presets,
    Map<String, String>? previewColors,
    DateTime? overridesUpdatedAt,
    DateTime? previewColorsUpdatedAt,
    String? message,
    // Allow explicitly clearing timestamps by passing a wrapper
    bool clearOverridesTimestamp = false,
    bool clearPreviewTimestamp = false,
  }) {
    return PaletteSettingsState(
      status: status ?? this.status,
      overrides: overrides ?? this.overrides,
      presets: presets ?? this.presets,
      previewColors: previewColors ?? this.previewColors,
      overridesUpdatedAt: clearOverridesTimestamp
          ? null
          : (overridesUpdatedAt ?? this.overridesUpdatedAt),
      previewColorsUpdatedAt: clearPreviewTimestamp
          ? null
          : (previewColorsUpdatedAt ?? this.previewColorsUpdatedAt),
      message: message ?? this.message,
    );
  }
}
