import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vision_xai/features/settings/color_palette/core/utils/palette_utils.dart';
import 'package:vision_xai/features/settings/color_palette/presentation/cubit/palette/palette_cubit.dart';
import 'package:vision_xai/features/settings/color_palette/presentation/cubit/palette_settings/palette_settings_cubit.dart';
import 'package:vision_xai/core/services/notification_service.dart';

typedef PickColorCallback = Future<void> Function(
    BuildContext context, TextEditingController controller, String fieldKey);

class HexField extends StatefulWidget {
  final String label;

  /// Canonical key used for preview and persistence (e.g. 'primary').
  /// This key is stable and should not be localized. If omitted the
  /// localized `label` is used as a fallback for backwards compatibility.
  final String? fieldKey;
  final TextEditingController controller;
  final Color swatchColor;
  final PickColorCallback onPickColor;
  final String? Function(String?)? validator;

  const HexField({
    super.key,
    required this.label,
    this.fieldKey,
    required this.controller,
    required this.swatchColor,
    required this.onPickColor,
    this.validator,
  });

  @override
  State<HexField> createState() => _HexFieldState();
}

class _HexFieldState extends State<HexField> {
  late final TextEditingController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = widget.controller;
    _ctrl.addListener(_onTextChanged);
  }

  @override
  void didUpdateWidget(covariant HexField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller.removeListener(_onTextChanged);
      _ctrl = widget.controller;
      _ctrl.addListener(_onTextChanged);
    }
  }

  void _onTextChanged() {
    // Notify the PaletteSettingsCubit of the
    // current controller text so other widgets can react to a preview value.
    try {
      final hex = _ctrl.text.trim();
      // Use canonical key for preview updates; fall back to the label if
      // a fieldKey was not supplied (preserves backward compatibility).
      final key = widget.fieldKey ?? widget.label;
      final cubit = context.read<PaletteSettingsCubit?>();
      cubit?.updatePreviewColor(key, hex.isEmpty ? null : hex);
    } catch (_) {}
  }

  @override
  void dispose() {
    try {
      _ctrl.removeListener(_onTextChanged);
    } catch (_) {}
    super.dispose();
  }

  Color _swatchFrom(String? previewHex) {
    try {
      final hex = previewHex ?? _ctrl.text.trim();
      if (hex.isEmpty) return widget.swatchColor;
      return colorFromHex(hex);
    } catch (_) {
      return widget.swatchColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Listen to previewColors from PaletteSettingsCubit; fall back to
        // controller text when not present.
        BlocBuilder<PaletteSettingsCubit, dynamic>(
          builder: (context, state) {
            final preview = (state is Map || state.previewColors != null)
                ? (state.previewColors ?? <String, String>{})
                : <String, String>{};
            final key = widget.fieldKey ?? widget.label;
            final previewHex = preview[key];
            return Container(
                width: 56, height: 56, color: _swatchFrom(previewHex));
          },
        ),
        const SizedBox(width: 12),
        Expanded(
          child: TextFormField(
            controller: _ctrl,
            decoration: InputDecoration(
              labelText: widget.label,
              suffixIcon: PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert),
                itemBuilder: (_) => [
                  const PopupMenuItem(value: 'copy', child: Text('Copy')),
                  const PopupMenuItem(value: 'paste', child: Text('Paste')),
                ],
                onSelected: (v) async {
                  if (v == 'copy') {
                    await Clipboard.setData(ClipboardData(text: _ctrl.text));
                    defaultNotificationService.showSnackBar('Copied',
                        duration: const Duration(seconds: 2));
                  } else if (v == 'paste') {
                    final data = await Clipboard.getData('text/plain');
                    if (data?.text != null) _ctrl.text = data!.text!;
                  }
                },
              ),
            ),
            validator: widget.validator,
          ),
        ),
        IconButton(
            onPressed: () => widget.onPickColor(
                context, _ctrl, widget.fieldKey ?? widget.label),
            icon: Icon(Icons.colorize,
                color: context.watch<PaletteCubit>().state.secondaryColor)),
      ],
    );
  }
}
