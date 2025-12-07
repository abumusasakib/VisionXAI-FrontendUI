import 'package:hive_flutter/hive_flutter.dart';
import 'dart:developer' as developer;

/// Simple local data source for persisting user-selected palette overrides.
///
/// Stores hex color strings under keys 'primary', 'secondary', 'background'
/// in the Hive box named 'palette'. Methods return `null` when no overrides
/// are present.
class PaletteLocalDataSource {
  static const _boxName = 'palette';

  PaletteLocalDataSource();

  static const _overridesTimestampKey = '_overrides_updated_at';

  Future<Map<String, String>?> getOverrides() async {
    try {
      final box = Hive.box(_boxName);
      developer.log(
          'PaletteLocalDataSource.getOverrides: box keys=${box.keys.toList()}',
          name: 'PaletteLocalDataSource');
      if (box.isEmpty) return null;
      final primary = box.get('primary') as String?;
      final secondary = box.get('secondary') as String?;
      final background = box.get('background') as String?;
      developer.log(
          'PaletteLocalDataSource.getOverrides: primary=$primary secondary=$secondary background=$background',
          name: 'PaletteLocalDataSource');
      if (primary == null && secondary == null && background == null) {
        return null;
      }
      return {
        if (primary != null) 'primary': primary,
        if (secondary != null) 'secondary': secondary,
        if (background != null) 'background': background,
      };
    } catch (_) {
      developer.log('PaletteLocalDataSource.getOverrides: error reading box',
          name: 'PaletteLocalDataSource');
      return null;
    }
  }

  Future<void> saveOverrides(Map<String, String> overrides) async {
    final box = Hive.box(_boxName);
    developer.log(
        'PaletteLocalDataSource.saveOverrides: saving overrides=$overrides',
        name: 'PaletteLocalDataSource');
    await box.putAll(overrides);
    // Persist a timestamp so we can distinguish when overrides were
    // actually saved (useful across app restarts / cubit recreation).
    await box.put(_overridesTimestampKey, DateTime.now());
  }

  Future<void> clearOverrides() async {
    final box = Hive.box(_boxName);
    developer.log('PaletteLocalDataSource.clearOverrides: removing overrides',
        name: 'PaletteLocalDataSource');
    // Only remove the override keys and timestamp so presets remain intact.
    await box.delete('primary');
    await box.delete('secondary');
    await box.delete('background');
    await box.delete(_overridesTimestampKey);
  }

  // Presets management
  // Presets are stored under key 'presets' as a Map<String, Map<String,String>>
  Future<Map<String, Map<String, String>>> getPresets() async {
    final box = Hive.box(_boxName);
    final raw = box.get('presets') as Map<dynamic, dynamic>?;
    developer.log('PaletteLocalDataSource.getPresets: raw=$raw',
        name: 'PaletteLocalDataSource');
    if (raw == null) return {};
    // Normalize types
    final Map<String, Map<String, String>> out = {};
    raw.forEach((k, v) {
      try {
        final name = k.toString();
        if (v is Map) {
          final map = <String, String>{};
          v.forEach((kk, vv) {
            map[kk.toString()] = vv.toString();
          });
          out[name] = map;
        }
      } catch (_) {}
    });
    return out;
  }

  /// Returns the DateTime when overrides were last saved or null if not present.
  Future<DateTime?> getOverridesUpdatedAt() async {
    final box = Hive.box(_boxName);
    final raw = box.get(_overridesTimestampKey);
    developer.log('PaletteLocalDataSource.getOverridesUpdatedAt: raw=$raw',
        name: 'PaletteLocalDataSource');
    if (raw == null) return null;
    try {
      if (raw is DateTime) return raw;
      // Accept strings containing ISO-8601 timestamps as a fallback.
      if (raw is String) return DateTime.tryParse(raw);
    } catch (_) {}
    return null;
  }

  Future<void> savePreset(String name, Map<String, String> colors) async {
    final box = Hive.box(_boxName);
    final raw = (box.get('presets') as Map<dynamic, dynamic>?) ?? {};
    developer.log(
        'PaletteLocalDataSource.savePreset: name=$name colors=$colors',
        name: 'PaletteLocalDataSource');
    raw[name] = colors;
    await box.put('presets', raw);
  }

  Future<void> deletePreset(String name) async {
    final box = Hive.box(_boxName);
    final raw = (box.get('presets') as Map<dynamic, dynamic>?) ?? {};
    developer.log(
        'PaletteLocalDataSource.deletePreset: name=$name existingKeys=${raw.keys.toList()}',
        name: 'PaletteLocalDataSource');
    raw.remove(name);
    await box.put('presets', raw);
  }
}
