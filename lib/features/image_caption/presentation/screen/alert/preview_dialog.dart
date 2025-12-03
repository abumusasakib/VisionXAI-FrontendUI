import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vision_xai/core/services/dialog_service.dart';

void previewDialog(BuildContext context, XFile imageFile) {
  DialogService.showPreviewFromXFile(context, imageFile);
}

/// Show a preview dialog for raw image bytes (e.g., from memory).
void previewDialogFromBytes(BuildContext context, Uint8List imageBytes) {
  DialogService.showPreviewFromBytes(context, imageBytes);
}
