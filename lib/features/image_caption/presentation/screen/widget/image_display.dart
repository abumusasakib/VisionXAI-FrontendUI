import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:vision_xai/features/image_caption/presentation/cubit/home/home_state.dart';
import 'package:vision_xai/features/image_caption/presentation/screen/alert/preview_dialog.dart';
import 'package:vision_xai/l10n/localization_extension.dart';
import '../../../core/utils/image_layout_utils.dart';

Widget imageDisplay(BuildContext context, HomeState state) {
  final double displayHeight = getResponsiveImageHeight(context);

  if (state.imageFile != null) {
    return GestureDetector(
      onLongPress: () => previewDialog(context, state.imageFile!),
      child: kIsWeb
          ? Image.network(
              state.imageFile!.path,
              height: displayHeight,
              width: double.infinity,
              fit: BoxFit.contain,
              alignment: Alignment.center,
            )
          : Image.file(
              File(state.imageFile!.path),
              height: displayHeight,
              width: double.infinity,
              fit: BoxFit.contain,
              alignment: Alignment.center,
            ),
    );
  }

  // Fallback placeholder uses the same display height
  return Container(
    height: displayHeight,
    decoration: BoxDecoration(
      border: Border.all(color: Theme.of(context).dividerColor, width: 2),
      color: Theme.of(context).colorScheme.surface,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Center(
      child: RepaintBoundary(
        key: const ValueKey('no-image-text'),
        child: Text(
          context.tr.noImageSelected,
          key: const ValueKey('no-image-text-inner'),
        ),
      ),
    ),
  );
}

/// Returns a widget that displays image bytes and shows a preview dialog on long press.
Widget imageWidgetFromBytes(BuildContext context, Uint8List imageBytes) {
  final double displayHeight = getResponsiveImageHeight(
    context,
    heightFactor: 0.5,
  );

  return GestureDetector(
    onLongPress: () => previewDialogFromBytes(context, imageBytes),
    child: Image.memory(
      imageBytes,
      height: displayHeight,
      width: double.infinity,
      fit: BoxFit.contain,
      alignment: Alignment.center,
    ),
  );
}
