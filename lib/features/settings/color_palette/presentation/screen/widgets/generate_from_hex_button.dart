import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vision_xai/features/settings/color_palette/core/palette_utils.dart';
import 'package:vision_xai/l10n/localization_extension.dart';
import 'package:vision_xai/features/settings/color_palette/presentation/cubit/palette/palette_cubit.dart';

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
      onPressed: () {
        final hex = backgroundController.text.trim();
        if (hex.isEmpty) return;
        final normalized = hex.toUpperCase();
        try {
          final palette = buildPaletteFromHex(normalized);
          primaryController.text = toHex(palette['primary']!);
          secondaryController.text = toHex(palette['secondary']!);
          backgroundController.text = toHex(palette['background']!);
        } catch (_) {
          // ignore invalid input
        }
      },
      icon: const Icon(Icons.auto_fix_high, size: 18),
      label: Text(context.tr.generate),
      style: OutlinedButton.styleFrom(
        foregroundColor: _safePrimaryColor(context),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        side: BorderSide(color: _safeSecondaryColor(context).withOpacity(0.3)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}

Color _safePrimaryColor(BuildContext context) {
  try {
    return context.read<PaletteCubit>().state.primaryColor;
  } catch (_) {
    return Colors.black;
  }
}

Color _safeSecondaryColor(BuildContext context) {
  try {
    return context.read<PaletteCubit>().state.secondaryColor;
  } catch (_) {
    return Colors.grey;
  }
}
