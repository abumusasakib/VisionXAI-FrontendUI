import 'package:flutter/material.dart';
import 'package:vision_xai/core/services/global_ui_service.dart';
import 'package:vision_xai/l10n/localization_extension.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

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
            child: Text(cancelLabel ?? dctx.tr.cancel),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(dctx).pop(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: confirmColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            child: Text(confirmLabel ?? dctx.tr.ok),
          ),
        ],
      ),
    );
  }

  /// Shows a simple alert dialog with a single OK button. If [onOk] is
  /// provided it will be invoked before the dialog is dismissed.
  static Future<void> showAlert({
    BuildContext? context,
    required String title,
    required String content,
    String? okLabel,
    VoidCallback? onOk,
  }) {
    return show<void>(
      context: context,
      barrierDismissible: false,
      builder: (dctx) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () {
              if (onOk != null) onOk();
              Navigator.of(dctx).pop();
            },
            child: Text(okLabel ?? dctx.tr.ok),
          ),
        ],
      ),
    );
  }

  /// Shows an image preview dialog for an [XFile]. Uses an
  /// InteractiveViewer for pinch/zoom. Returns when the dialog is closed.
  static Future<void> showPreviewFromXFile(
      BuildContext? context, XFile imageFile) {
    return show<void>(
      context: context,
      builder: (dctx) {
        final imageWidget = kIsWeb
            ? Image.network(imageFile.path, fit: BoxFit.contain)
            : Image.file(File(imageFile.path), fit: BoxFit.contain);
        return _buildPreviewDialog(dctx, imageWidget);
      },
    );
  }

  /// Shows an image preview dialog for raw bytes.
  static Future<void> showPreviewFromBytes(
      BuildContext? context, Uint8List bytes) {
    return show<void>(
      context: context,
      builder: (dctx) =>
          _buildPreviewDialog(dctx, Image.memory(bytes, fit: BoxFit.contain)),
    );
  }

  static Widget _buildPreviewDialog(BuildContext context, Widget imageWidget) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Dialog(
      insetPadding: const EdgeInsets.all(12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: screenHeight * 0.9,
          maxWidth: screenWidth * 0.95,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(8)),
                child: InteractiveViewer(
                  panEnabled: true,
                  minScale: 1.0,
                  maxScale: 4.0,
                  child: imageWidget,
                ),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(context.tr.ok),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Shows a color picker dialog and returns the selected [Color] or `null`
  /// if cancelled.
  static Future<Color?> showColorPicker(BuildContext? context,
      {required Color initialColor, String? title}) async {
    Color picked = initialColor;
    final result = await show<Color?>(
      context: context,
      builder: (dctx) => AlertDialog(
        title: Text(title ?? dctx.tr.pickAColor),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: initialColor,
            onColorChanged: (c) => picked = c,
            enableAlpha: false,
            pickerAreaHeightPercent: 0.7,
          ),
        ),
        actions: [
            TextButton(
              onPressed: () => Navigator.of(dctx).pop(null),
              child: Text(dctx.tr.cancel)),
            TextButton(
              onPressed: () => Navigator.of(dctx).pop(picked),
              child: Text(dctx.tr.select)),
        ],
      ),
    );
    return result;
  }

  /// Shows a text input dialog and returns the entered string or `null` if
  /// cancelled.
  static Future<String?> showTextInput(BuildContext? context,
      {required String title,
      String? placeholder,
      String? initialValue}) async {
    final controller = TextEditingController(text: initialValue ?? '');
    final result = await show<String?>(
      context: context,
      builder: (dctx) => AlertDialog(
        title: Text(title),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: InputDecoration(labelText: placeholder),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(dctx).pop(null),
              child: const Text('Cancel')),
          TextButton(
              onPressed: () => Navigator.of(dctx).pop(controller.text.trim()),
              child: const Text('OK')),
        ],
      ),
    );
    return result;
  }

  /// Shows a simple list picker. Returns the selected item or `null` when
  /// cancelled.
  static Future<T?> showListPicker<T>(BuildContext? context,
      {required String title,
      required List<T> items,
      required String Function(T) display}) async {
    return show<T?>(
      context: context,
      builder: (dctx) => AlertDialog(
        title: Text(title),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: items.length,
            itemBuilder: (_, idx) => ListTile(
              title: Text(display(items[idx])),
              onTap: () => Navigator.of(dctx).pop(items[idx]),
            ),
          ),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(dctx).pop(null),
              child: const Text('Cancel')),
        ],
      ),
    );
  }
}
