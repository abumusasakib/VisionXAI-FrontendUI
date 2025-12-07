import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer' as developer;
import 'package:vision_xai/features/settings/color_palette/core/utils/palette_utils.dart';
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
      // Let the screen drive loading of persisted overrides and presets so
      // UI has control over timing and avoids duplicate loads from DI
      // layers or route initializers.
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
              developer.log(
                  'PaletteCubit listener: primary=$primaryHex, secondary=$secondaryHex, background=$backgroundHex',
                  name: 'PaletteSettingsScreen');
              // Only update controllers if they differ to avoid stomping edits.
              if (primaryController.text != primaryHex) {
                developer.log(
                    'PaletteSettingsScreen: updating primaryController from ${primaryController.text} -> $primaryHex',
                    name: 'PaletteSettingsScreen');
                primaryController.text = primaryHex;
              }
              if (secondaryController.text != secondaryHex) {
                developer.log(
                    'PaletteSettingsScreen: updating secondaryController from ${secondaryController.text} -> $secondaryHex',
                    name: 'PaletteSettingsScreen');
                secondaryController.text = secondaryHex;
              }
              if (backgroundController.text != backgroundHex) {
                developer.log(
                    'PaletteSettingsScreen: updating backgroundController from ${backgroundController.text} -> $backgroundHex',
                    name: 'PaletteSettingsScreen');
                backgroundController.text = backgroundHex;
              }
            } catch (e) {
              developer.log('PaletteCubit listener error: $e',
                  name: 'PaletteSettingsScreen');
            }
          },
        ),
        BlocListener<PaletteSettingsCubit, PaletteSettingsState>(
          // Only react to overrides changes. Preview updates (which update
          // `previewColors`) should not stomp the user's in-progress edits
          // or recent color picker selections. Use a deep-content comparison
          // so identical-but-new-map instances don't cause unnecessary
          // controller updates.
          listenWhen: (previous, current) {
            bool mapsEqual(Map<String, String>? a, Map<String, String>? b) {
              if (a == null && b == null) return true;
              if (a == null || b == null) return false;
              if (a.length != b.length) return false;
              for (final k in a.keys) {
                if (a[k] != b[k]) return false;
              }
              return true;
            }

            // React when overrides changed OR when a message was added/changed.
            // This ensures snackbars (which use `state.message`) show even
            // if the overrides map itself didn't change (e.g. saving a preset).
            final overridesChanged =
                !mapsEqual(previous.overrides, current.overrides);
            final messageChanged = previous.message != current.message;
            return overridesChanged || messageChanged;
          },
          listener: (ctx, state) {
            try {
              if (state.message != null) {
                // Use global notification service so the listener doesn't need
                // to depend on ScaffoldMessenger directly.
                defaultNotificationService.showSnackBar(state.message!,
                    duration: const Duration(seconds: 3));
                developer.log('PaletteSettingsCubit message: ${state.message}',
                    name: 'PaletteSettingsScreen');
              }
              if (state.overrides != null) {
                final o = state.overrides!;
                developer.log(
                    'PaletteSettingsCubit listener: applying overrides=$o, overridesTs=${state.overridesUpdatedAt}, previewTs=${state.previewColorsUpdatedAt}',
                    name: 'PaletteSettingsScreen');
                // Apply overrides per-key, but prefer newer transient previews
                // when they exist. If a preview for a given key exists and
                // the preview's timestamp is newer than the persisted
                // overrides timestamp, skip applying that override for the
                // key. This makes the decision deterministic when both
                // persisted and transient values are present.
                bool shouldApplyKey(String key) {
                  final previews = state.previewColors;
                  // If no preview for this key, apply the override.
                  if (previews == null || !previews.containsKey(key)) {
                    return true;
                  }
                  final ovTs = state.overridesUpdatedAt;
                  final pvTs = state.previewColorsUpdatedAt;
                  // If there is no stored overrides timestamp, prefer the
                  // transient preview (if present) — the preview is from a
                  // user action that should take precedence unless the saved
                  // override is clearly newer.
                  if (ovTs == null) {
                    return pvTs == null; // only apply override if no preview
                  }
                  if (pvTs == null) return true;
                  // Apply override only if it's newer-or-equal to the preview.
                  final shouldApply =
                      ovTs.isAfter(pvTs) || ovTs.isAtSameMomentAs(pvTs);
                  developer.log(
                      'shouldApplyKey($key): ovTs=$ovTs > pvTs=$pvTs? $shouldApply',
                      name: 'PaletteSettingsScreen');
                  return shouldApply;
                }

                if (shouldApplyKey('primary')) {
                  primaryController.text =
                      (o['primary'] ?? primaryController.text).toString();
                }
                if (shouldApplyKey('secondary')) {
                  secondaryController.text =
                      (o['secondary'] ?? secondaryController.text).toString();
                }
                if (shouldApplyKey('background')) {
                  backgroundController.text =
                      (o['background'] ?? backgroundController.text).toString();
                }
              }
            } catch (e) {
              developer.log('PaletteSettingsCubit listener error: $e',
                  name: 'PaletteSettingsScreen');
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
                                fieldKey: 'primary',
                                controller: primaryController,
                                swatchColor:
                                    colorFromHex(primaryController.text),
                                onPickColor: showColorPicker,
                                validator: hexValidator,
                              ),
                              const SizedBox(height: 16),
                              HexField(
                                label: context.tr.secondaryColor,
                                fieldKey: 'secondary',
                                controller: secondaryController,
                                swatchColor:
                                    colorFromHex(secondaryController.text),
                                onPickColor: showColorPicker,
                                validator: hexValidator,
                              ),
                              const SizedBox(height: 16),
                              HexField(
                                label: context.tr.backgroundColor,
                                fieldKey: 'background',
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
