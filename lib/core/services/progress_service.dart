import 'package:flutter/material.dart';

/// Simple service to show a modal, non-dismissible progress indicator.
///
/// Usage:
/// ```dart
/// ProgressService.show(context, message: 'Generating...', size: 96);
/// // long running work
/// ProgressService.hide(context);
/// ```
class ProgressService {
  /// Shows a blocking progress dialog. Optional [message] and [size]
  /// parameters control the displayed message and dialog size.
  static void show(BuildContext context,
      {String? message, double size = 84, Widget? child}) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      // Use a dim barrier so the dialog content stands out. A semi-opaque
      // black overlay works well across light and dark themes and keeps the
      // dialog readable.
      barrierColor: Colors.black54,
      // Use the local navigator by default so the dialog pairs with the
      // same Navigator instance used to hide it. Using the root navigator
      // can cause mismatches in apps that use nested navigators.
      useRootNavigator: false,
      builder: (_) => _ProgressDialog(
        message: message,
        size: size,
        child: child,
      ),
    );
  }

  /// Hides the progress dialog if present. Safe to call even if no dialog
  /// is shown (errors are ignored).
  static void hide(BuildContext context) {
    // Try to pop using the local navigator first, then fall back to the
    // root navigator. Swallow errors so callers can safely call hide()
    // without needing to guard for dialog presence.
    try {
      if (Navigator.of(context, rootNavigator: false).canPop()) {
        Navigator.of(context, rootNavigator: false).pop();
        return;
      }
    } catch (_) {}
    try {
      if (Navigator.of(context, rootNavigator: true).canPop()) {
        Navigator.of(context, rootNavigator: true).pop();
      }
    } catch (_) {}
  }
}

class _ProgressDialog extends StatelessWidget {
  final String? message;
  final double size;
  final Widget? child;

  const _ProgressDialog({this.message, this.size = 84, this.child});

  @override
  Widget build(BuildContext context) {
    final dialogChild = child ??
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: size,
              height: size,
              child: const Center(child: CircularProgressIndicator()),
            ),
            if (message != null) ...[
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  message!,
                  textAlign: TextAlign.center,
                  // Ensure the message uses a high-contrast color relative
                  // to the dialog background so it's legible in light/dark
                  // themes.
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface),
                ),
              ),
            ]
          ],
        );

    // Place the dialog on a themed surface with a small elevation and
    // rounded corners so it remains legible regardless of the app theme.
    return Center(
      child: Material(
        elevation: 6,
        color: Theme.of(context).colorScheme.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: dialogChild,
        ),
      ),
    );
  }
}
