import 'package:flutter/material.dart';
import 'package:vision_xai/l10n/localization_extension.dart';
import 'package:vision_xai/core/services/dialog_service.dart';

/// Shows a confirmation dialog to delete a named preset.
/// Returns `true` if the user confirmed deletion, `false` if cancelled,
/// or `null` if the dialog was dismissed.
Future<bool?> showDeletePresetDialog(BuildContext ctx, String name) {
  return DialogService.showConfirm(
    context: ctx,
    title: ctx.tr.deletePresetTitle,
    content: ctx.tr.deletePresetMessage(name),
    confirmLabel: ctx.tr.delete,
    confirmColor: Colors.red,
    cancelLabel: ctx.tr.cancel,
  );
}
