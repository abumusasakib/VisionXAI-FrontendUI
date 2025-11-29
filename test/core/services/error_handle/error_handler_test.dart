import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vision_xai/core/services/error_handle/error_handling.dart';

void main() {
  group('error_message_mapper', () {
    test(
        'mapDioExceptionToMessage returns fallback for timeout when context null',
        () {
      final ex = DioException(
          requestOptions: RequestOptions(path: ''),
          type: DioExceptionType.connectionTimeout);
      final msg = mapDioExceptionToMessage(ex, null);
      expect(msg, equals('Connection timed out'));
    });

    test(
        'mapDioExceptionToMessage returns fallback for badResponse when context null',
        () {
      final response =
          Response(requestOptions: RequestOptions(path: ''), statusCode: 500);
      final ex = DioException(
          requestOptions: RequestOptions(path: ''),
          response: response,
          type: DioExceptionType.badResponse);
      final msg = mapDioExceptionToMessage(ex, null);
      expect(msg, equals('Bad response from server'));
    });

    test('mapErrorToMessage handles SocketException and TimeoutException', () {
      const s = SocketException('failed');
      final t = TimeoutException('timed out');
      expect(mapErrorToMessage(s, null),
          equals('No internet or server unreachable'));
      expect(mapErrorToMessage(t, null), equals('Connection timed out'));
    });

    test('runWithErrorHandling returns failure Result on thrown', () async {
      Future<int> thrower() async => throw const SocketException('no net');
      final res = await runWithErrorHandling<int>(thrower);
      expect(res.isSuccess, isFalse);
      expect(res.errorMessage, equals('No internet or server unreachable'));
    });
  });
}
