import 'dart:convert';
import 'dart:typed_data';

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
