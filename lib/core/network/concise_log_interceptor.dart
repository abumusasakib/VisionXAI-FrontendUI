import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:dio/dio.dart';

/// A Dio interceptor that logs requests/responses like [Interceptor]
/// but truncates large bodies and logs summaries for binary payloads.
class ConciseLogInterceptor extends Interceptor {
  final int maxBodyChars;
  final void Function(Object object) logPrint;

  ConciseLogInterceptor(
      {this.maxBodyChars = 1024, void Function(Object)? logPrint})
      : logPrint = logPrint ?? ((o) => log(o.toString(), name: 'Dio'));

  static bool _looksBinaryContentType(String? contentType) {
    if (contentType == null) return false;
    final ct = contentType.toLowerCase();
    return ct.contains('image') ||
        ct.contains('octet-stream') ||
        ct.contains('audio') ||
        ct.contains('video');
  }

  String _truncateString(String s) {
    if (s.length <= maxBodyChars) return s;
    final truncated = s.substring(0, maxBodyChars);
    return '$truncated...(truncated, total ${s.length} chars)';
  }

  String _bodySummary(dynamic data, RequestOptions options) {
    try {
      final contentType =
          options.headers['content-type'] ?? options.contentType?.toString();
      if (data == null) return 'null';
      // Handle multipart/form-data (FormData) which is not JSON-encodable
      if (data is FormData) {
        final fields = data.fields.length;
        final files = data.files.length;
        return 'FormData: fields=$fields, files=$files';
      }
      if (data is MultipartFile) {
        return 'MultipartFile: filename=${data.filename ?? '<unknown>'}';
      }
      if (data is Uint8List || data is List<int>) {
        final len =
            data is Uint8List ? data.lengthInBytes : (data as List<int>).length;
        return 'Binary body: $len bytes';
      }
      if (_looksBinaryContentType(contentType as String?)) {
        // For safety, don't print the literal body if content-type suggests binary
        if (data is String) {
          return 'Binary-like body string: ${data.length} chars';
        }
        return 'Binary-like body (${data.runtimeType})';
      }
      if (data is String) {
        return _truncateString(data);
      }

      // For Map/List/other JSON-like objects, produce a compact summary
      if (data is Map || data is List) {
        return _summarizeJsonLike(data);
      }

      // Fallback: encode and truncate
      final encoded = jsonEncode(data);
      // If encoded is very large and likely contains large embedded strings
      // prefer a key/value summary instead of dumping the full JSON.
      if (encoded.length > maxBodyChars && (data is Map || data is List)) {
        return _summarizeJsonLike(data);
      }
      return _truncateString(encoded);
    } catch (e) {
      return 'Unprintable body (${e.runtimeType})';
    }
  }

  String _responseBodySummary(Response response) {
    try {
      final contentType = response.headers.value('content-type')?.toLowerCase();
      final data = response.data;
      if (data == null) return 'null';
      if (data is Uint8List || data is List<int>) {
        final len =
            data is Uint8List ? data.lengthInBytes : (data as List<int>).length;
        return 'Binary response body: $len bytes';
      }
      if (_looksBinaryContentType(contentType)) {
        if (data is String) {
          return 'Binary-like response string: ${data.length} chars';
        }
        return 'Binary-like response (${data.runtimeType})';
      }
      if (data is String) return _truncateString(data);

      if (data is Map || data is List) {
        return _summarizeJsonLike(data);
      }

      final encoded = jsonEncode(data);
      if (encoded.length > maxBodyChars && (data is Map || data is List)) {
        return _summarizeJsonLike(data);
      }
      return _truncateString(encoded);
    } catch (e) {
      return 'Unprintable response body (${e.runtimeType})';
    }
  }

  String _summarizeJsonLike(dynamic data) {
    try {
      if (data is Map) {
        final parts = <String>[];
        data.forEach((key, value) {
          parts.add('$key: ${_briefValueSummary(value)}');
        });
        return 'JSON object: {${parts.join(', ')}}';
      }
      if (data is List) {
        // Show length and a brief summary of first few items
        final len = data.length;
        final items = data.take(3).map((v) => _briefValueSummary(v)).join(', ');
        return 'JSON array: length=$len, sample=[$items]';
      }
      return _truncateString(jsonEncode(data));
    } catch (e) {
      return 'Unprintable JSON-like body (${e.runtimeType})';
    }
  }

  String _briefValueSummary(dynamic v) {
    if (v == null) return 'null';
    if (v is String) {
      final l = v.length;
      if (l > 128) return 'String($l chars)';
      return '"${_truncateString(v)}"';
    }
    if (v is num || v is bool) return v.toString();
    if (v is Map) return 'Object(${v.length} keys)';
    if (v is List) return 'Array(len=${v.length})';
    if (v is Uint8List || v is List<int>) {
      final len = v is Uint8List ? v.lengthInBytes : (v as List<int>).length;
      return 'Binary($len bytes)';
    }
    return v.runtimeType.toString();
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final buffer = StringBuffer();
    buffer.writeln('--> ${options.method} ${options.uri}');
    if (options.headers.isNotEmpty) {
      buffer.writeln('Headers: ${options.headers}');
    }
    final bodySummary = _bodySummary(options.data, options);
    if (bodySummary.isNotEmpty) buffer.writeln('Request body: $bodySummary');
    buffer.writeln('--> END ${options.method}');
    logPrint(buffer.toString());
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final buffer = StringBuffer();
    buffer.writeln('<-- ${response.statusCode} ${response.requestOptions.uri}');
    if (response.headers.map.isNotEmpty) {
      buffer.writeln('Headers: ${response.headers.map}');
    }
    final bodySummary = _responseBodySummary(response);
    if (bodySummary.isNotEmpty) buffer.writeln('Response body: $bodySummary');
    buffer.writeln('<-- END HTTP');
    logPrint(buffer.toString());
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final buffer = StringBuffer();
    buffer.writeln('*** Dio Error (${err.type}) ***');
    try {
      buffer.writeln(
          'Request: ${err.requestOptions.method} ${err.requestOptions.uri}');
    } catch (_) {}
    if (err.response != null) {
      buffer.writeln('Response status: ${err.response?.statusCode}');
      try {
        buffer.writeln('Response body: ${_responseBodySummary(err.response!)}');
      } catch (_) {}
    }
    buffer.writeln('Message: ${err.message}');
    logPrint(buffer.toString());
    super.onError(err, handler);
  }
}
