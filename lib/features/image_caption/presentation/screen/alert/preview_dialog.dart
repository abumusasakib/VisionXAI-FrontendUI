import 'dart:io';
// dart:typed_data not required because Uint8List is exported by flutter/foundation.dart

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vision_xai/l10n/localization_extension.dart';

// Shared preview dialog implementation that displays a provided image widget
// inside an InteractiveViewer to enable pinch-to-zoom, with consistent dialog
// styling and larger default size.
Future<void> _showPreviewDialogWithWidget(
    BuildContext context, Widget imageWidget) {
  final screenHeight = MediaQuery.of(context).size.height;
  final screenWidth = MediaQuery.of(context).size.width;

  return showDialog(
    context: context,
    builder: (BuildContext context) {
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
    },
  );
}

void previewDialog(BuildContext context, XFile imageFile) {
  final imageWidget = kIsWeb
      ? Image.network(
          imageFile.path,
          fit: BoxFit.contain,
        )
      : Image.file(
          File(imageFile.path),
          fit: BoxFit.contain,
        );
  _showPreviewDialogWithWidget(context, imageWidget);
}

/// Show a preview dialog for raw image bytes (e.g., from memory).
void previewDialogFromBytes(BuildContext context, Uint8List imageBytes) {
  final imageWidget = Image.memory(
    imageBytes,
    fit: BoxFit.contain,
  );
  _showPreviewDialogWithWidget(context, imageWidget);
}
