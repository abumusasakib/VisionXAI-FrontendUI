import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vision_xai/features/settings/color_palette/presentation/cubit/palette_settings/palette_settings_cubit.dart';
import 'package:vision_xai/features/settings/color_palette/core/palette_manager.dart';
import 'package:vision_xai/l10n/localization_extension.dart';
import 'package:vision_xai/features/settings/color_palette/presentation/screen/alert/delete_preset_dialog.dart';

class PresetsList extends StatelessWidget {
  const PresetsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaletteSettingsCubit, dynamic>(builder: (ctx, s) {
      final state = s as dynamic;
      final presets =
          (state.presets as Map<String, Map<String, String>>?) ?? {};
      if (presets.isEmpty) return const SizedBox.shrink();
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(context.tr.presetsList,
              style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          SizedBox(
            height: 92,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: presets.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (ctx2, i) {
                final entry = presets.entries.elementAt(i);
                final name = entry.key;
                final parts = entry.value;
                Color p1 = Theme.of(ctx2).colorScheme.surface,
                    p2 = Theme.of(ctx2).colorScheme.surface,
                    p3 = Theme.of(ctx2).colorScheme.surface;
                try {
                  p1 = PaletteManager.getWebSafeColorFromHex(
                      parts['primary'] ?? '#FFFFFF');
                  p2 = PaletteManager.getWebSafeColorFromHex(
                      parts['secondary'] ?? '#FFFFFF');
                  p3 = PaletteManager.getWebSafeColorFromHex(
                      parts['background'] ?? '#FFFFFF');
                } catch (_) {}

                return GestureDetector(
                  onTap: () async {
                    final settingsCubit = ctx.read<PaletteSettingsCubit>();
                    await settingsCubit.applyPreset(name);
                  },
                  child: Container(
                    width: 220,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        border: Border.all(color: Theme.of(ctx).dividerColor),
                        borderRadius: BorderRadius.circular(8)),
                    child: Column(children: [
                      Row(children: [
                        Container(width: 40, height: 40, color: p1),
                        const SizedBox(width: 6),
                        Container(width: 40, height: 40, color: p2),
                        const SizedBox(width: 6),
                        Container(width: 40, height: 40, color: p3),
                        const Spacer(),
                        IconButton(
                          onPressed: () async {
                            final settingsCubit =
                                ctx.read<PaletteSettingsCubit>();
                            final confirm =
                                await showDeletePresetDialog(ctx, name);
                            if (confirm == true) {
                              await settingsCubit.deletePreset(name);
                            }
                          },
                          icon: Icon(Icons.delete,
                              color: Theme.of(ctx).colorScheme.error),
                        )
                      ]),
                      const SizedBox(height: 6),
                      Align(
                          alignment: Alignment.centerLeft,
                          child:
                              Text(name, style: const TextStyle(fontSize: 12)))
                    ]),
                  ),
                );
              },
            ),
          )
        ],
      );
    });
  }
}
