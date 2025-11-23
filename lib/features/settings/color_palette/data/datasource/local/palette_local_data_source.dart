import 'package:hive_flutter/hive_flutter.dart';

/// Simple local data source for persisting user-selected palette overrides.
///
/// Stores hex color strings under keys 'primary', 'secondary', 'background'
/// in the Hive box named 'palette'. Methods return `null` when no overrides
/// are present.
class PaletteLocalDataSource {
  static const _boxName = 'palette';

  PaletteLocalDataSource();

  Future<Map<String, String>?> getOverrides() async {
    try {
      final box = Hive.box(_boxName);
      if (box.isEmpty) return null;
      final primary = box.get('primary') as String?;
      final secondary = box.get('secondary') as String?;
      final background = box.get('background') as String?;
      if (primary == null && secondary == null && background == null) {
        return null;
      }
      return {
        if (primary != null) 'primary': primary,
        if (secondary != null) 'secondary': secondary,
        if (background != null) 'background': background,
      };
    } catch (_) {
      return null;
    }
  }

  Future<void> saveOverrides(Map<String, String> overrides) async {
    final box = Hive.box(_boxName);
    await box.putAll(overrides);
  }

  Future<void> clearOverrides() async {
    final box = Hive.box(_boxName);
    await box.clear();
  }

  // Presets management
  // Presets are stored under key 'presets' as a Map<String, Map<String,String>>
  Future<Map<String, Map<String, String>>> getPresets() async {
    final box = Hive.box(_boxName);
    final raw = box.get('presets') as Map<dynamic, dynamic>?;
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

  Future<void> savePreset(String name, Map<String, String> colors) async {
    final box = Hive.box(_boxName);
    final raw = (box.get('presets') as Map<dynamic, dynamic>?) ?? {};
    raw[name] = colors;
    await box.put('presets', raw);
  }

  Future<void> deletePreset(String name) async {
    final box = Hive.box(_boxName);
    final raw = (box.get('presets') as Map<dynamic, dynamic>?) ?? {};
    raw.remove(name);
    await box.put('presets', raw);
  }
}
