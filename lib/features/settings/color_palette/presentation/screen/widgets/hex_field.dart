import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vision_xai/features/settings/color_palette/core/palette_utils.dart';
import 'package:vision_xai/features/settings/color_palette/presentation/cubit/palette/palette_cubit.dart';
import 'package:vision_xai/core/services/notification_service.dart';

typedef PickColorCallback = Future<void> Function(
    BuildContext context, TextEditingController controller);

class HexField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final Color swatchColor;
  final PickColorCallback onPickColor;
  final String? Function(String?)? validator;

  const HexField({
    super.key,
    required this.label,
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

  void _onTextChanged() => setState(() {});

  @override
  void dispose() {
    try {
      _ctrl.removeListener(_onTextChanged);
    } catch (_) {}
    super.dispose();
  }

  Color get _currentSwatch {
    try {
      final hex = _ctrl.text.trim();
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
        Container(width: 56, height: 56, color: _currentSwatch),
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
                    // Use the global notification service so we don't rely on
                    // `BuildContext` after awaiting the clipboard call.
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
            onPressed: () => widget.onPickColor(context, _ctrl),
            icon: Icon(Icons.colorize,
                color: context.watch<PaletteCubit>().state.secondaryColor)),
      ],
    );
  }
}
