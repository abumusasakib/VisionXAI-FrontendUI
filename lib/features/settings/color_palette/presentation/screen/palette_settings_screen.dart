import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vision_xai/features/settings/color_palette/core/palette_utils.dart';
import 'package:vision_xai/features/settings/color_palette/presentation/cubit/palette/palette_cubit.dart';
import 'package:vision_xai/features/settings/color_palette/presentation/cubit/palette_settings/palette_settings_cubit.dart';
import 'package:vision_xai/features/settings/color_palette/presentation/cubit/palette_settings/palette_settings_state.dart';
import 'package:vision_xai/features/settings/color_palette/presentation/screen/alert/show_color_picker.dart';
import 'package:vision_xai/features/settings/color_palette/presentation/screen/widgets/hex_field.dart';
import 'package:vision_xai/features/settings/color_palette/presentation/screen/widgets/action_buttons.dart';
import 'package:vision_xai/features/settings/color_palette/presentation/screen/widgets/presets_list.dart';
import 'package:vision_xai/l10n/localization_extension.dart';
import 'package:vision_xai/core/services/notification_service.dart';

class PaletteSettingsScreen extends StatefulWidget {
  const PaletteSettingsScreen({super.key});

  @override
  State<PaletteSettingsScreen> createState() => _PaletteSettingsScreenState();
}

class _PaletteSettingsScreenState extends State<PaletteSettingsScreen> {
  late final TextEditingController primaryController;
  late final TextEditingController secondaryController;
  late final TextEditingController backgroundController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    final palette = context.read<PaletteCubit>().state;
    primaryController =
        TextEditingController(text: toHex(palette.primaryColor));
    secondaryController =
        TextEditingController(text: toHex(palette.secondaryColor));
    backgroundController =
        TextEditingController(text: toHex(palette.backgroundColor));
    // Load persisted overrides and presets after the first frame so the
    // provided cubit is available in the widget tree.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final settingsCubit = context.read<PaletteSettingsCubit>();
      settingsCubit.loadOverrides();
      settingsCubit.loadPresets();
    });
  }

  @override
  void dispose() {
    primaryController.dispose();
    secondaryController.dispose();
    backgroundController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<PaletteCubit, dynamic>(
          // Listen to PaletteCubit so the settings card always shows the
          // currently applied palette (e.g. when user generates from image).
          listener: (ctx, paletteState) {
            try {
              final primaryHex = toHex(paletteState.primaryColor);
              final secondaryHex = toHex(paletteState.secondaryColor);
              final backgroundHex = toHex(paletteState.backgroundColor);
              // Only update controllers if they differ to avoid stomping edits.
              if (primaryController.text != primaryHex) {
                primaryController.text = primaryHex;
              }
              if (secondaryController.text != secondaryHex) {
                secondaryController.text = secondaryHex;
              }
              if (backgroundController.text != backgroundHex) {
                backgroundController.text = backgroundHex;
              }
            } catch (_) {
              // ignore: if paletteState shape changes in tests or is null
            }
          },
        ),
        BlocListener<PaletteSettingsCubit, PaletteSettingsState>(
          listener: (ctx, state) {
            if (state.message != null) {
              // Use global notification service so the listener doesn't need
              // to depend on ScaffoldMessenger directly.
              defaultNotificationService.showSnackBar(state.message!,
                  duration: const Duration(seconds: 3));
            }
            if (state.overrides != null) {
              final o = state.overrides!;
              primaryController.text =
                  (o['primary'] ?? primaryController.text).toString();
              secondaryController.text =
                  (o['secondary'] ?? secondaryController.text).toString();
              backgroundController.text =
                  (o['background'] ?? backgroundController.text).toString();
            }
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          title: Text(context.tr.paletteSettings),
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Color Settings Card
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.palette,
                                color: context
                                    .watch<PaletteCubit>()
                                    .state
                                    .secondaryColor,
                                size: 24),
                            const SizedBox(width: 8),
                            Text(
                              context.tr.colorConfiguration,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[800],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              HexField(
                                label: context.tr.primaryColor,
                                controller: primaryController,
                                swatchColor:
                                    colorFromHex(primaryController.text),
                                onPickColor: showColorPicker,
                                validator: hexValidator,
                              ),
                              const SizedBox(height: 16),
                              HexField(
                                label: context.tr.secondaryColor,
                                controller: secondaryController,
                                swatchColor:
                                    colorFromHex(secondaryController.text),
                                onPickColor: showColorPicker,
                                validator: hexValidator,
                              ),
                              const SizedBox(height: 16),
                              HexField(
                                label: context.tr.backgroundColor,
                                controller: backgroundController,
                                swatchColor:
                                    colorFromHex(backgroundController.text),
                                onPickColor: showColorPicker,
                                validator: hexValidator,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Action Buttons
                ActionButtons(
                  formKey: _formKey,
                  primaryController: primaryController,
                  secondaryController: secondaryController,
                  backgroundController: backgroundController,
                ),

                const SizedBox(height: 24),

                // Presets Section
                const PresetsList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
