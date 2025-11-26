import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:vision_xai/features/image_caption/presentation/cubit/home/home_state.dart';
import 'package:vision_xai/features/image_caption/presentation/screen/alert/preview_dialog.dart';
import 'package:vision_xai/l10n/localization_extension.dart';

Widget imageDisplay(BuildContext context, HomeState state) {
  if (state.imageFile != null) {
    return GestureDetector(
      onLongPress: () => previewDialog(context, state.imageFile!),
      child: kIsWeb
          ? Image.network(
              state.imageFile!.path,
              height: 220,
              fit: BoxFit.cover,
            )
          : Image.file(
              File(state.imageFile!.path),
              height: 220,
              fit: BoxFit.cover,
            ),
    );
  }

  // Fallback placeholder
  return Container(
    height: 200,
    decoration: BoxDecoration(
      border: Border.all(color: Theme.of(context).dividerColor, width: 2),
      color: Theme.of(context).colorScheme.surface,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Center(
      child: Text(context.tr.noImageSelected),
    ),
  );
}

/// Returns a widget that displays image bytes and shows a preview dialog on long press.
Widget imageWidgetFromBytes(BuildContext context, Uint8List imageBytes) {
  return GestureDetector(
    onLongPress: () => previewDialogFromBytes(context, imageBytes),
    child: Image.memory(
      imageBytes,
      height: 220,
      fit: BoxFit.cover,
    ),
  );
}
