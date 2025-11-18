import 'dart:async';
import 'dart:io';
import 'dart:developer' as developer;

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:vision_xai/l10n/localization_extension.dart';
import 'result.dart';
import '../services/notification_service.dart';

/// Runs [action] and returns a [Result]. If [showSnackOnError] is true and
/// a valid [context] is provided, a SnackBar with the mapped message will be
/// shown when an error occurs.
Future<Result<T>> runWithErrorHandling<T>(Future<T> Function() action,
    {bool showSnackOnError = false,
    NotificationService? notificationService,
    BuildContext? context,
    bool rethrowOnError = false,
    String? successMessage,
    bool showSuccessOnSuccess = false}) async {
  try {
    final value = await action();
    // Optionally show a success SnackBar when action completes successfully.
    if (showSuccessOnSuccess && successMessage != null) {
      try {
        final ns = notificationService ?? defaultNotificationService;
        // ignore: use_build_context_synchronously
        ns.showSnackBar(context, successMessage);
      } catch (_) {}
    }
    return Result.success(value);
  } catch (e, st) {
    // ignore: use_build_context_synchronously
    final msg = mapErrorToMessage(e, context);

    // Optionally show a SnackBar using the provided NotificationService
    if (showSnackOnError) {
      try {
        final ns = notificationService ?? defaultNotificationService;
        // ignore: use_build_context_synchronously
        ns.showSnackBar(context, msg);
      } catch (_) {}
    }

    developer.log('runWithErrorHandling failure: $msg',
        name: 'runWithErrorHandling', error: e, stackTrace: st);

    if (rethrowOnError) rethrow;

    return Result.failure(msg);
  }
}

/// Convenience helper to show an error SnackBar for [error]. If [context]
/// is null this becomes a no-op.
void showErrorSnackBar(BuildContext? context, Object error) {
  if (context == null) return;
  final msg = mapErrorToMessage(error, context);
  try {
    defaultNotificationService.showSnackBar(context, msg);
  } catch (_) {}
}

/// Maps Dio and common network/IO errors to user-visible localized messages.
///
/// Use `mapErrorToMessage(error, context)` when handling exceptions in Cubits
/// or repositories.
String mapDioExceptionToMessage(DioException e, BuildContext? context) {
  // Fallback English messages when no BuildContext is available.
  const fallbackTimeout = 'Connection timed out';
  const fallbackBadResponse = 'Bad response from server';
  const fallbackCancelled = 'Request cancelled';
  const fallbackNoInternet = 'No internet or server unreachable';
  const fallbackUnknown = 'Unknown error';

  final tr = context?.tr;

  if (e.type == DioExceptionType.connectionTimeout ||
      e.type == DioExceptionType.sendTimeout ||
      e.type == DioExceptionType.receiveTimeout) {
    return tr?.connectionTimeout ?? fallbackTimeout;
  }

  if (e.type == DioExceptionType.badResponse) {
    return tr?.badResponse(e.response?.statusCode?.toString() ?? '') ??
        fallbackBadResponse;
  }

  if (e.type == DioExceptionType.cancel) {
    return tr?.requestCancelled ?? fallbackCancelled;
  }

  if (e.type == DioExceptionType.connectionError ||
      e.error is SocketException) {
    return tr?.noInternetOrServerUnreachable ?? fallbackNoInternet;
  }

  return tr?.unknownError ?? fallbackUnknown;
}

/// Generic mapping for arbitrary errors. Recognizes DioException and common
/// IO/Timeout exceptions and falls back to an unknown error message.
String mapErrorToMessage(Object error, BuildContext? context) {
  if (error is DioException) return mapDioExceptionToMessage(error, context);

  if (error is SocketException) {
    return context?.tr.noInternetOrServerUnreachable ??
        'No internet or server unreachable';
  }

  if (error is TimeoutException) {
    return context?.tr.connectionTimeout ?? 'Connection timed out';
  }

  if (error is HttpException) {
    return context?.tr.noInternetOrServerUnreachable ??
        'No internet or server unreachable';
  }

  return context?.tr.unknownError ?? 'Unknown error';
}
