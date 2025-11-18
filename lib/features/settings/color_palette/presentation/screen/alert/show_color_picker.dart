import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:vision_xai/features/settings/color_palette/core/palette_manager.dart';

Future<void> showColorPicker(
      BuildContext ctx, TextEditingController ctrl) async {
    // Parse existing hex or fall back to white.
    Color current;
    try {
      current = PaletteManager.getWebSafeColorFromHex(ctrl.text);
    } catch (_) {
      current = Colors.white;
    }

    Color picked = current;

    final confirmed = await showDialog<bool?>(
      context: ctx,
      builder: (dCtx) => AlertDialog(
        title: const Text('Pick a color'),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: current,
            onColorChanged: (c) => picked = c,
            enableAlpha: false,
            pickerAreaHeightPercent: 0.7,
          ),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(dCtx).pop(false),
              child: const Text('Cancel')),
          TextButton(
              onPressed: () => Navigator.of(dCtx).pop(true),
              child: const Text('Select')),
        ],
      ),
    );

    if (confirmed == true) {
      final hex =
          '#${picked.value.toRadixString(16).padLeft(8, '0').substring(2).toUpperCase()}';
      ctrl.text = hex;
    }
  }