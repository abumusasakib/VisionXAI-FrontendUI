import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vision_xai/features/settings/color_palette/presentation/cubit/palette_settings/palette_settings_cubit.dart';
import 'package:vision_xai/features/settings/color_palette/presentation/cubit/palette/palette_cubit.dart';
import 'package:vision_xai/features/settings/color_palette/presentation/screen/widgets/generate_image_button.dart';
import 'package:vision_xai/features/settings/color_palette/presentation/screen/widgets/generate_from_hex_button.dart';
import 'package:vision_xai/l10n/localization_extension.dart';
import 'package:vision_xai/core/services/notification_service.dart';
import 'package:vision_xai/core/services/progress_service.dart';

class ActionButtons extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController primaryController;
  final TextEditingController secondaryController;
  final TextEditingController backgroundController;

  const ActionButtons({
    super.key,
    required this.formKey,
    required this.primaryController,
    required this.secondaryController,
    required this.backgroundController,
  });

  @override
  Widget build(BuildContext context) {
    final secondaryColor = context.watch<PaletteCubit>().state.secondaryColor;
    return Card(
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
                Icon(Icons.settings, color: secondaryColor, size: 24),
                const SizedBox(width: 8),
                Text(
                  context.tr.actionsSection,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                // Save Button
                ElevatedButton.icon(
                  onPressed: () async {
                    if (!formKey.currentState!.validate()) return;
                    final overrides = {
                      'primary': primaryController.text.toUpperCase(),
                      'secondary': secondaryController.text.toUpperCase(),
                      'background': backgroundController.text.toUpperCase(),
                    };
                    final settingsCubit = context.read<PaletteSettingsCubit>();
                    await settingsCubit.saveOverrides(overrides);
                  },
                  icon: const Icon(Icons.save, size: 18),
                  label: Text(context.tr.save),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: secondaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 0,
                  ),
                ),

                // Reset Button with confirmation
                OutlinedButton.icon(
                  onPressed: () async {
                    // Capture label and cubit before showing dialog to avoid
                    // using `context` across async gaps. We use the
                    // `NotificationService` after the async operation so no
                    // BuildContext is required there.
                    final settingsCubit = context.read<PaletteSettingsCubit>();
                    final resetLabel = context.tr.resetConfirmation;
                    final resettingMsg = context.tr.resetting;

                    final ok = await showDialog<bool>(
                      context: context,
                      builder: (dctx) => AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        title: Row(
                          children: [
                            Icon(Icons.refresh, color: secondaryColor),
                            const SizedBox(width: 8),
                            Text(dctx.tr.reset),
                          ],
                        ),
                        content: Text(dctx.tr.resetPrompt),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(dctx).pop(false),
                            child: Text(
                              dctx.tr.cancel,
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () => Navigator.of(dctx).pop(true),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: secondaryColor,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(dctx.tr.reset),
                          ),
                        ],
                      ),
                    );
                    if (ok != true) return;
                    // Show a modal progress indicator while clearing overrides.
                    await ProgressService.show(message: resettingMsg);
                    try {
                      await settingsCubit.clearOverrides();
                    } finally {
                      ProgressService.hide();
                    }

                    // Use the centralized notification service to show the
                    // post-reset message. The service falls back to a global
                    // messenger if no context is provided.
                    defaultNotificationService.showSnackBar(resetLabel,
                        duration: const Duration(seconds: 2));
                  },
                  icon: const Icon(Icons.refresh, size: 18),
                  label: Text(context.tr.reset),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.grey[700],
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    side: BorderSide(color: Colors.grey[400]!),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                // Save Preset Button
                ElevatedButton.icon(
                  onPressed: () async {
                    final nameCtrl = TextEditingController();
                    final settingsCubit = context.read<PaletteSettingsCubit>();
                    final ok = await showDialog<bool>(
                      context: context,
                      builder: (dctx) => AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        title: Row(
                          children: [
                            Icon(Icons.bookmark_add, color: secondaryColor),
                            const SizedBox(width: 8),
                            Text(dctx.tr.presetNameAlertTitle),
                          ],
                        ),
                        content: TextField(
                          controller: nameCtrl,
                          autofocus: true,
                          decoration: InputDecoration(
                            labelText: dctx.tr.presetNamePlaceholder,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            filled: true,
                            fillColor: Colors.grey[50],
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(dctx).pop(false),
                            child: Text(
                              dctx.tr.cancel,
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () => Navigator.of(dctx).pop(true),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: secondaryColor,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(dctx.tr.save),
                          ),
                        ],
                      ),
                    );
                    if (ok != true) return;
                    final name = nameCtrl.text.trim();
                    if (name.isEmpty) return;
                    final colors = {
                      'primary': primaryController.text.toUpperCase(),
                      'secondary': secondaryController.text.toUpperCase(),
                      'background': backgroundController.text.toUpperCase(),
                    };
                    await settingsCubit.saveNamedPreset(name, colors);
                  },
                  icon: const Icon(Icons.bookmark_add, size: 18),
                  label: Text(context.tr.savePreset),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: secondaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 0,
                  ),
                ),
                // Generate from Background Button
                GenerateFromHexButton(
                  primaryController: primaryController,
                  secondaryController: secondaryController,
                  backgroundController: backgroundController,
                ),
                // Generate from Image Button
                GenerateImageButton(
                  primaryController: primaryController,
                  secondaryController: secondaryController,
                  backgroundController: backgroundController,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
