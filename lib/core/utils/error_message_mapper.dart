import 'dart:async';
import 'dart:io';
import 'dart:developer' as developer;

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:vision_xai/core/constants/string_res.dart';
import 'package:vision_xai/l10n/localization_extension.dart';
import 'package:vision_xai/l10n/app_localizations.dart';
import 'result.dart';
import '../services/notification_service.dart';

/// Runs [action] and returns a [Result]. If [showSnackOnError] is true and
/// a valid [context] is provided, a SnackBar with the mapped message will be
/// shown when an error occurs.
Future<Result<T>> runWithErrorHandling<T>(Future<T> Function() action,
    {bool showSnackOnError = false,
    NotificationService? notificationService,
    AppLocalizations? localizations,
    bool rethrowOnError = false,
    String? successMessage,
    bool showSuccessOnSuccess = false}) async {
  try {
    final value = await action();
    // Optionally show a success SnackBar when action completes successfully.
    if (showSuccessOnSuccess && successMessage != null) {
      try {
        final ns = notificationService ?? defaultNotificationService;

        // Use global messenger by passing null; this avoids using
        // BuildContext across async gaps.
        ns.showSnackBar(successMessage);
      } catch (_) {}
    }
    return Result.success(value);
  } catch (e, st) {
    final msg = mapErrorToMessage(e, localizations);

    // Optionally show a SnackBar using the provided NotificationService
    if (showSnackOnError) {
      try {
        final ns = notificationService ?? defaultNotificationService;

        // Use global messenger by passing null to avoid BuildContext usage
        // after awaiting the action.
        ns.showSnackBar(msg);
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
  final localizations = context?.tr;
  final msg = mapErrorToMessage(error, localizations);
  try {
    // Use the global messenger to avoid requiring a BuildContext.
    defaultNotificationService.showSnackBar(msg);
  } catch (_) {}
}

/// Maps Dio and common network/IO errors to user-visible localized messages.
///
/// Use `mapErrorToMessage(error, context)` when handling exceptions in Cubits
/// or repositories.
String mapDioExceptionToMessage(DioException e, AppLocalizations? tr) {
  if (e.type == DioExceptionType.connectionTimeout ||
      e.type == DioExceptionType.sendTimeout ||
      e.type == DioExceptionType.receiveTimeout) {
    return tr?.connectionTimeout ?? StringRes.timeout;
  }

  if (e.type == DioExceptionType.badResponse) {
    return tr?.badResponse(e.response?.statusCode?.toString() ?? '') ??
        StringRes.badResponse;
  }

  if (e.type == DioExceptionType.cancel) {
    return tr?.requestCancelled ?? StringRes.requestCancelled;
  }

  if (e.type == DioExceptionType.connectionError ||
      e.error is SocketException) {
    return tr?.noInternetOrServerUnreachable ??
        StringRes.noInternetOrServerUnreachable;
  }

  return tr?.unknownError ?? StringRes.unknownError;
}

/// Generic mapping for arbitrary errors. Recognizes DioException and common
/// IO/Timeout exceptions and falls back to an unknown error message.
String mapErrorToMessage(Object error, AppLocalizations? tr) {
  if (error is DioException) return mapDioExceptionToMessage(error, tr);

  if (error is SocketException) {
    return tr?.noInternetOrServerUnreachable ??
        StringRes.noInternetOrServerUnreachable;
  }

  if (error is TimeoutException) {
    return tr?.connectionTimeout ?? StringRes.timeout;
  }

  if (error is HttpException) {
    return tr?.noInternetOrServerUnreachable ??
        StringRes.noInternetOrServerUnreachable;
  }

  return tr?.unknownError ?? StringRes.unknownError;
}
