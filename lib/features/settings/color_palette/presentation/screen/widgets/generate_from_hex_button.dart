import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer' as developer;
import 'package:vision_xai/features/settings/color_palette/core/utils/palette_utils.dart';
import 'package:vision_xai/l10n/localization_extension.dart';
import 'package:vision_xai/features/settings/color_palette/presentation/cubit/palette/palette_cubit.dart';
import 'package:vision_xai/features/settings/color_palette/presentation/cubit/palette_settings/palette_settings_cubit.dart';

class GenerateFromHexButton extends StatelessWidget {
  final TextEditingController primaryController;
  final TextEditingController secondaryController;
  final TextEditingController backgroundController;

  const GenerateFromHexButton({
    super.key,
    required this.primaryController,
    required this.secondaryController,
    required this.backgroundController,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () async {
        final hex = backgroundController.text.trim();
        if (hex.isEmpty) return;
        final normalized = hex.toUpperCase();
        try {
          final palette = buildPaletteFromHex(normalized);
          primaryController.text = toHex(palette['primary']!);
          secondaryController.text = toHex(palette['secondary']!);
          backgroundController.text = toHex(palette['background']!);
          developer.log(
              'GenerateFromHex: palette generated primary=${toHex(palette['primary']!)}, secondary=${toHex(palette['secondary']!)}, background=${toHex(palette['background']!)}',
              name: 'GenerateFromHexButton');
          // Also update the live PaletteCubit so UI previews update immediately
          try {
            final cubit = context.read<PaletteCubit>();
            developer.log('GenerateFromHex: updating PaletteCubit from hex',
                name: 'GenerateFromHexButton');
            cubit.updateFromMap({
              'primary': palette['primary']!,
              'secondary': palette['secondary']!,
              'background': palette['background']!,
            });
          } catch (_) {
            // If cubit isn't available in this context (tests/isolated usage), ignore.
          }
          // Persist the generated palette as overrides so the local data
          // source and overrides timestamp reflect the user's generated
          // palette. This prevents later reloads from accidentally
          // reverting the UI back to old stored overrides.
          try {
            final settings = context.read<PaletteSettingsCubit>();
            final overrides = {
              'primary': toHex(palette['primary']!),
              'secondary': toHex(palette['secondary']!),
              'background': toHex(palette['background']!),
            };
            developer.log(
                'GenerateFromHex: persisting generated overrides=$overrides',
                name: 'GenerateFromHexButton');
            await settings.saveOverrides(overrides);
          } catch (_) {}
        } catch (_) {
          // ignore invalid input
        }
      },
      icon: const Icon(Icons.auto_fix_high, size: 18),
      label: Text(context.tr.generate),
      // Use filled secondary color with white text like the other action
      // buttons so the button remains legible on light backgrounds.
      style: OutlinedButton.styleFrom(
        backgroundColor: _safeSecondaryColor(context),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        side: BorderSide(color: _safeSecondaryColor(context).withOpacity(0.3)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}

Color _safeSecondaryColor(BuildContext context) {
  try {
    return context.read<PaletteCubit>().state.secondaryColor;
  } catch (_) {
    return Colors.grey;
  }
}
