import 'package:flutter/material.dart';
import 'package:vision_xai/l10n/localization_extension.dart';

/// Shows a confirmation dialog to delete a named preset.
/// Returns `true` if the user confirmed deletion, `false` if cancelled,
/// or `null` if the dialog was dismissed.
Future<bool?> showDeletePresetDialog(BuildContext ctx, String name) {
  return showDialog<bool>(
    context: ctx,
    builder: (dctx) => AlertDialog(
      title: Text(ctx.tr.deletePresetTitle),
      content: Text(ctx.tr.deletePresetMessage(name)),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(dctx).pop(false),
          child: Text(ctx.tr.cancel),
        ),
        TextButton(
          onPressed: () => Navigator.of(dctx).pop(true),
          child: Text(ctx.tr.delete),
        ),
      ],
    ),
  );
}
