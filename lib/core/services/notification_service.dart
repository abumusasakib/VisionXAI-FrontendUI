import 'package:flutter/material.dart';

/// Abstract notification service to allow injection and easy testing.
abstract class NotificationService {
  void showSnackBar(BuildContext? context, String message,
      {Color? backgroundColor, Duration? duration, TextStyle? textStyle});
}

/// Default implementation that uses `ScaffoldMessenger` to show a SnackBar.
class NotificationServiceImpl implements NotificationService {
  @override
  void showSnackBar(BuildContext? context, String message,
      {Color? backgroundColor, Duration? duration, TextStyle? textStyle}) {
    if (context == null) return;
    try {
      final snack = SnackBar(
        content: Text(message, style: textStyle),
        backgroundColor: backgroundColor,
        duration: duration ?? const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
      );
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(snack);
    } catch (_) {}
  }
}

/// A convenient default instance used by code paths that don't have DI.
final NotificationService defaultNotificationService =
    NotificationServiceImpl();
