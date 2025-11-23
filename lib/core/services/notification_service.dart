import 'package:flutter/material.dart';
import 'package:vision_xai/core/services/global_ui_service.dart';

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
