import 'package:flutter/material.dart';
import 'package:vision_xai/core/services/global_ui_service.dart';
import 'package:vision_xai/l10n/localization_extension.dart';

/// Small service to present commonly used bottom sheets.
class BottomSheetService {
  /// Shows an image source picker and returns the selected option:
  /// - 'files' for picking from the file system
  /// - 'gallery' for picking from the image gallery
  /// - null when cancelled
  static Future<String?> showImageSourcePicker([BuildContext? context]) async {
    // Prefer to use a provided context; if not available attempt to use
    // the global navigator context.
    final ctx = context ?? GlobalUiService.context;
    if (ctx == null) return null;
    return showModalBottomSheet<String>(
      context: ctx,
      builder: (dctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.folder_open),
              title: Text(ctx.tr.pickFromFiles),
              onTap: () => Navigator.of(dctx).pop('files'),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: Text(ctx.tr.pickFromGallery),
              onTap: () => Navigator.of(dctx).pop('gallery'),
            ),
            ListTile(
              leading: const Icon(Icons.cancel),
              title: Text(ctx.tr.cancel),
              onTap: () => Navigator.of(dctx).pop(null),
            ),
          ],
        ),
      ),
    );
  }
}
