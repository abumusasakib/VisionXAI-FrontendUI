import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:vision_xai/core/services/global_ui_service.dart';
import 'package:vision_xai/core/services/dialog_service.dart';

/// Simple service to show a modal, non-dismissible progress indicator.
///
/// Usage:
/// ```dart
/// ProgressService.show(context, message: 'Generating...', size: 96);
/// // long running work
/// ProgressService.hide(context);
/// ```
class ProgressService {
  /// Shows a blocking progress dialog.
  ///
  /// The [context] parameter is optional — when omitted the service will
  /// fall back to `GlobalUiService.context` so callers don't need to hold
  /// a `BuildContext` across async operations. Optional [message] and
  /// [size] parameters control the displayed message and dialog size.
  /// The method awaits one frame so callers can start long-running work
  /// after the dialog is painted and the progress indicator begins
  /// animating.
  static Future<void> show(
      {BuildContext? context,
      String? message,
      double size = 84,
      Widget? child}) async {
    final useContext = context ?? GlobalUiService.context;
    if (useContext == null) {
      // No context available to show a dialog. Nothing to show; return
      // immediately to avoid throwing.
      return;
    }

    // Use the centralized dialog helper so all dialogs render consistently
    // and respect the global fallback for missing contexts.
    DialogService.show<void>(
      context: useContext,
      barrierDismissible: false,
      barrierColor: Colors.black54,
      useRootNavigator: false,
      builder: (_) => _ProgressDialog(
        message: message,
        size: size,
        child: child,
      ),
    );

    // Wait until the current frame completes so the dialog is actually
    // rendered and the CircularProgressIndicator animation can start.
    try {
      await SchedulerBinding.instance.endOfFrame;
    } catch (_) {
      // If scheduler isn't available for some reason, fall back to a short
      // delay to allow the event loop to process the showDialog work.
      await Future.delayed(const Duration(milliseconds: 16));
    }
  }

  /// Hides the progress dialog if present. Safe to call even if no dialog
  /// is shown (errors are ignored).
  static void hide({BuildContext? context}) {
    final useContext = context ?? GlobalUiService.context;
    if (useContext == null) return;

    // Try to pop using the local navigator first, then fall back to the
    // root navigator. Swallow errors so callers can safely call hide()
    // without needing to guard for dialog presence.
    try {
      if (Navigator.of(useContext, rootNavigator: false).canPop()) {
        Navigator.of(useContext, rootNavigator: false).pop();
        return;
      }
    } catch (_) {}
    try {
      if (Navigator.of(useContext, rootNavigator: true).canPop()) {
        Navigator.of(useContext, rootNavigator: true).pop();
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
