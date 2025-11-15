import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../../../data/model/topk_item.dart';
import '../../../domain/entity/image_caption_entity.dart';

/// Public attention view widget extracted for reuse and testing.
class AttentionView extends StatefulWidget {
  final ImageCaptionEntity entity;

  const AttentionView({super.key, required this.entity});

  @override
  State<AttentionView> createState() => _AttentionViewState();
}

class _AttentionViewState extends State<AttentionView> {
  int? _selectedTokenIndex;

  @override
  Widget build(BuildContext context) {
    final tokens =
        (widget.entity.attributes['tokens'] as List?)?.cast<String>() ?? [];
    final tokenScores = (widget.entity.attributes['token_scores'] as List?)
            ?.map((e) => (e as num).toDouble())
            .toList() ??
        [];
    final Uint8List? imageBytes =
        widget.entity.attributes['attention_image_bytes'] as Uint8List?;
    final rawTopk = widget.entity.attributes['attention_topk_items'];
    List<List<TopKItem>>? topk;
    if (rawTopk is List) {
      try {
        topk = rawTopk
            .map<List<TopKItem>>((outer) => (outer as List).cast<TopKItem>())
            .toList();
      } catch (_) {
        topk = null;
      }
    }

    // Grid override support: server may provide explicit grid size
    int? gridRows;
    int? gridCols;
    final grid = widget.entity.attributes['attention_grid'];
    if (grid is List && grid.length >= 2) {
      gridRows = (grid[0] as int);
      gridCols = (grid[1] as int);
    }
    final shape = widget.entity.attributes['attention_shape'];
    if (shape is Map) {
      gridRows ??= shape['rows'] as int?;
      gridCols ??= shape['cols'] as int?;
    }

    return Column(
      children: [
        if (imageBytes != null) ...[
          SizedBox(
            height: 180,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final width = constraints.maxWidth;
                final height = constraints.maxHeight;
                return Stack(
                  children: [
                    Positioned.fill(
                      child: Image.memory(
                        imageBytes,
                        fit: BoxFit.cover,
                      ),
                    ),
                    if (topk != null && _selectedTokenIndex != null)
                      ..._buildMarkers(
                          topk, _selectedTokenIndex!, width, height,
                          gridRows: gridRows, gridCols: gridCols),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 8),
        ],
        SizedBox(
          height: 48,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            itemBuilder: (context, index) {
              final token = tokens.length > index ? tokens[index] : '—';
              final score =
                  tokenScores.length > index ? tokenScores[index] : null;
              final selected = _selectedTokenIndex == index;
              return ChoiceChip(
                label: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(token),
                    if (score != null) ...[
                      const SizedBox(width: 6),
                      Text(score.toStringAsFixed(3),
                          style: const TextStyle(fontSize: 12)),
                    ]
                  ],
                ),
                selected: selected,
                onSelected: (_) {
                  setState(() {
                    _selectedTokenIndex = selected ? null : index;
                  });
                },
              );
            },
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemCount: tokens.length,
          ),
        ),
      ],
    );
  }

  List<Widget> _buildMarkers(
      List<List<TopKItem>> topk, int tokenIndex, double width, double height,
      {int? gridRows, int? gridCols}) {
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
      return Positioned(
        left: left.clamp(0.0, width - markerSize),
        top: top.clamp(0.0, height - markerSize),
        child: Container(
          key: Key('marker-$tokenIndex-$i'),
          width: markerSize,
          height: markerSize,
          decoration: BoxDecoration(
            color: Colors.red.withOpacity(opacity),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 1.0),
          ),
        ),
      );
    }).toList();
  }
}
