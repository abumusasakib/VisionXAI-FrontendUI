import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vision_xai/features/settings/color_palette/core/palette_manager.dart';
import 'package:vision_xai/l10n/localization_extension.dart';
import 'package:vision_xai/core/services/dialog_service.dart';
import 'package:vision_xai/features/settings/color_palette/presentation/cubit/palette_settings/palette_settings_cubit.dart';

Future<void> showColorPicker(
    BuildContext ctx, TextEditingController ctrl, String label) async {
  // Parse existing hex or fall back to the current theme surface color.
  Color current;
  try {
    current = PaletteManager.getWebSafeColorFromHex(ctrl.text);
  } catch (_) {
    current = Theme.of(ctx).colorScheme.surface;
  }

  final selected = await DialogService.showColorPicker(ctx,
      initialColor: current, title: ctx.tr.pickAColor);
  if (selected != null) {
    final hex =
        '#${selected.value.toRadixString(16).padLeft(8, '0').substring(2).toUpperCase()}';
    // Update the controller via a full TextEditingValue so listeners and
    // any bound UI receive the change reliably and caret is placed at end.
    ctrl.value = TextEditingValue(
      text: hex,
      selection: TextSelection.collapsed(offset: hex.length),
    );
    // Setting `ctrl.value` above notifies listeners. Also update the
    // PaletteSettingsCubit's preview entry explicitly so the swatch updates
    // immediately for this label.
    try {
      ctx.read<PaletteSettingsCubit>().updatePreviewColor(label, hex);
    } catch (_) {}
  }
}
