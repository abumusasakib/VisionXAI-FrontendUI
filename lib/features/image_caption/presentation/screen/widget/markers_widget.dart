import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vision_xai/features/image_caption/data/model/topk_item.dart';
import 'package:vision_xai/features/settings/color_palette/presentation/cubit/palette/palette_cubit.dart';

List<Widget> markersWidget(BuildContext context, List<List<TopKItem>> topk,
    int tokenIndex, double width, double height,
    {int? gridRows, int? gridCols, Color? color}) {
  if (tokenIndex >= topk.length) return [];
  final items = topk[tokenIndex];
  if (items.isEmpty) return [];

  int maxRow = 0, maxCol = 0;
  for (final item in items) {
    if (item.row > maxRow) maxRow = item.row;
    if (item.col > maxCol) maxCol = item.col;
  }

  final rows = gridRows ?? (maxRow + 1);
  final cols = gridCols ?? (maxCol + 1);
  final cellW = width / (cols > 0 ? cols : 1);
  final cellH = height / (rows > 0 ? rows : 1);

  return items.asMap().entries.map((entry) {
    final i = entry.key;
    final t = entry.value;
    // Marker size and opacity reflect score magnitude
    final normalized = (t.score.clamp(0.0, 1.0));
    final markerSize = 8.0 + (normalized * 20.0); // 8..28
    final opacity = 0.35 + (normalized * 0.6); // 0.35..0.95

    final left = (t.col + 0.5) * cellW - (markerSize / 2);
    final top = (t.row + 0.5) * cellH - (markerSize / 2);
    Color defaultColor;
    if (color != null) {
      defaultColor = color;
    } else {
      try {
        // try to read PaletteCubit if available; tests or isolated contexts
        // may not provide it, so fall back to a sensible default color.
        defaultColor = context.read<PaletteCubit>().state.secondaryColor;
      } catch (_) {
        defaultColor = Colors.red;
      }
    }
    return Positioned(
      left: left.clamp(0.0, width - markerSize),
      top: top.clamp(0.0, height - markerSize),
      child: Container(
        key: Key('marker-$tokenIndex-$i'),
        width: markerSize,
        height: markerSize,
        decoration: BoxDecoration(
          color: defaultColor.withAlpha((opacity * 255).round()),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 1.0),
        ),
      ),
    );
  }).toList();
}
