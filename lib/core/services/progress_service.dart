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
      useRootNavigator: true,
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
    try {
      if (Navigator.of(context, rootNavigator: true).canPop()) {
        Navigator.of(context, rootNavigator: true).pop();
      }
    } catch (_) {
      // swallow any errors; calling hide should be safe
    }
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
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ]
          ],
        );

    return Center(
      child: Material(
        color: Colors.transparent,
        child: dialogChild,
      ),
    );
  }
}
