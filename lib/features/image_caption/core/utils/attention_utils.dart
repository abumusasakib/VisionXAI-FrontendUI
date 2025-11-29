import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';

import 'package:vision_xai/features/image_caption/data/model/attention_grid.dart';
import 'package:vision_xai/features/image_caption/data/model/topk_item.dart';

/// Decode a base64-encoded PNG (or image bytes) into a [Uint8List].
/// Returns null when input is null or empty.
Uint8List? decodeAttentionImage(String? base64Str) {
  if (base64Str == null) return null;
  if (base64Str.isEmpty) return null;
  try {
    return base64Decode(base64Str);
  } catch (_) {
    return null;
  }
}

Color? parseHexColor(String? hex) {
  if (hex == null) return null;
  try {
    final cleaned = hex.replaceFirst('#', '');
    if (cleaned.length == 6) {
      return Color(int.parse('0xff$cleaned'));
    }
    if (cleaned.length == 8) {
      return Color(int.parse('0x$cleaned'));
    }
  } catch (_) {}
  return null;
}

List<List<TopKItem>>? parseTopK(dynamic rawTopk) {
  if (rawTopk is! List) return null;
  try {
    final parsed = <List<TopKItem>>[];
    for (final outer in rawTopk) {
      if (outer is List) {
        final inner = <TopKItem>[];
        for (final entry in outer) {
          if (entry is TopKItem) {
            inner.add(entry);
          } else if (entry is Map) {
            inner.add(TopKItem.fromMap(Map<String, dynamic>.from(entry)));
          } else if (entry is List) {
            inner.add(TopKItem.fromList(entry));
          }
        }
        parsed.add(inner);
      }
    }
    return parsed;
  } catch (_) {
    return null;
  }
}

Map<String, int?> parseGrid(
    dynamic typedGrid, dynamic rawGrid, dynamic rawGridMap, dynamic shape) {
  int? gridRows;
  int? gridCols;

  if (typedGrid is AttentionGrid) {
    gridRows = typedGrid.rows;
    gridCols = typedGrid.cols;
  } else if (rawGrid is AttentionGrid) {
    gridRows = rawGrid.rows;
    gridCols = rawGrid.cols;
  } else if (rawGrid is List && rawGrid.length >= 2) {
    final r = rawGrid[0];
    final c = rawGrid[1];
    if (r is num) {
      gridRows = r.toInt();
    } else if (r is String) {
      gridRows = int.tryParse(r);
    }
    if (c is num) {
      gridCols = c.toInt();
    } else if (c is String) {
      gridCols = int.tryParse(c);
    }
  } else if (rawGridMap is Map) {
    final r = rawGridMap['rows'];
    final c = rawGridMap['cols'];
    if (r is num) {
      gridRows = r.toInt();
    } else if (r is String) {
      gridRows = int.tryParse(r);
    }
    if (c is num) {
      gridCols = c.toInt();
    } else if (c is String) {
      gridCols = int.tryParse(c);
    }
  }

  if (shape is Map) {
    gridRows ??= (shape['rows'] is num)
        ? (shape['rows'] as num).toInt()
        : (shape['rows'] is String
            ? int.tryParse(shape['rows'].toString())
            : null);
    gridCols ??= (shape['cols'] is num)
        ? (shape['cols'] as num).toInt()
        : (shape['cols'] is String
            ? int.tryParse(shape['cols'].toString())
            : null);
  }

  return {'rows': gridRows, 'cols': gridCols};
}
