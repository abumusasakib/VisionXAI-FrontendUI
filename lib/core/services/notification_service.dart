import 'dart:convert';
import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:vision_xai/core/services/global_ui_service.dart';

final Logger _logger = Logger('NotificationService');

/// Abstract notification service to allow injection and easy testing.
abstract class NotificationService {
  void showSnackBar(String message,
      {BuildContext? context,
      Color? backgroundColor,
      Duration? duration,
      TextStyle? textStyle});
}

/// Default implementation that uses `ScaffoldMessenger` to show a SnackBar.
class NotificationServiceImpl implements NotificationService {
  final Logger? logger;

  NotificationServiceImpl({this.logger});

  @override
  void showSnackBar(String message,
      {BuildContext? context,
      Color? backgroundColor,
      Duration? duration,
      TextStyle? textStyle}) {
    try {
      final snack = SnackBar(
        content: Text(message, style: textStyle),
        backgroundColor: backgroundColor,
        duration: duration ?? const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
      );
      // Log the snackbar show with optional context/route information; include JSON metadata
      final String routeName = context != null
          ? (ModalRoute.of(context)?.settings.name ?? 'unknown')
          : (GlobalUiService.context != null
              ? (ModalRoute.of(GlobalUiService.context!)?.settings.name ??
                  'global')
              : 'no-route');
      final meta = {
        'id': DateTime.now().toIso8601String(),
        'caller': () {
          try {
            final lines = StackTrace.current.toString().split('\n');
            return lines.length > 1 ? lines[1].trim() : 'unknown';
          } catch (_) {
            return 'unknown';
          }
        }(),
        'route': routeName,
        'backgroundColor': backgroundColor?.toString(),
        'duration': duration?.inSeconds
      };
        // Structured logging via provided logger or default (preserve meta Map for tests)
        (logger ?? _logger).info('Show SnackBar: "$message"', meta);

        // Dorward a readable JSON-encoded version to dart:developer
        developer.log('Show SnackBar: "$message" | meta: ${jsonEncode(meta)}',
          name: 'NotificationService');

      // Prefer the provided context; fall back to the global scaffold messenger.
      if (context != null) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(snack);
        return;
      }
      final messenger = GlobalUiService.messenger;
      messenger?.hideCurrentSnackBar();
      messenger?.showSnackBar(snack);
    } catch (_) {}
  }
}

/// A convenient default instance used by code paths that don't have DI.
final NotificationService defaultNotificationService =
    NotificationServiceImpl();
