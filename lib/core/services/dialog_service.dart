import 'package:flutter/material.dart';
import 'package:vision_xai/core/services/global_ui_service.dart';

/// Lightweight dialog helper that centralizes showing dialogs and uses the
/// `GlobalUiService.context` fallback when a `BuildContext` is not available.
class DialogService {
  /// Generic wrapper around `showDialog` that uses the global context when
  /// a context isn't supplied.
  static Future<T?> show<T>({
    BuildContext? context,
    required WidgetBuilder builder,
    bool barrierDismissible = false,
    Color? barrierColor,
    bool useRootNavigator = false,
  }) {
    final useContext = context ?? GlobalUiService.context;
    if (useContext == null) return Future.value(null);

    return showDialog<T>(
      context: useContext,
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor,
      useRootNavigator: useRootNavigator,
      builder: builder,
    );
  }

  /// Shows a simple confirmation dialog and returns `true` when the user
  /// confirms, `false` when cancelled, or `null` if dismissed.
  static Future<bool?> showConfirm({
    BuildContext? context,
    required String title,
    required String content,
    String? confirmLabel,
    String? cancelLabel,
    IconData? icon,
    Color? iconColor,
    Color? confirmColor,
  }) {
    return show<bool>(
      context: context,
      barrierDismissible: false,
      builder: (dctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: icon == null
            ? Text(title)
            : Row(
                children: [
                  Icon(icon, color: iconColor),
                  const SizedBox(width: 8),
                  Text(title),
                ],
              ),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dctx).pop(false),
            child: Text(cancelLabel ?? 'Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(dctx).pop(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: confirmColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: Text(confirmLabel ?? 'OK'),
          ),
        ],
      ),
    );
  }
}
