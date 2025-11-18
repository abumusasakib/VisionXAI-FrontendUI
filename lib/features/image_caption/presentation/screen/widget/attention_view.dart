import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:vision_xai/features/image_caption/presentation/screen/widget/markers_widget.dart';
import '../../../data/model/topk_item.dart';
import '../../../data/model/attention_grid.dart';
import '../../../domain/entity/image_caption_entity.dart';
import 'package:vision_xai/features/image_caption/presentation/screen/widget/image_display.dart';

/// Attention view widget
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
        final parsed = <List<TopKItem>>[];
        for (final outer in rawTopk) {
          if (outer is List) {
            final inner = <TopKItem>[];
            for (final entry in outer) {
              if (entry is TopKItem) {
                inner.add(entry);
              } else if (entry is Map) {
                inner.add(TopKItem.fromMap(Map<String, dynamic>.from(entry)));
              } else if (entry is List) {
                inner.add(TopKItem.fromList(entry));
              } else {
                // skip unknown entry types
              }
            }
            parsed.add(inner);
          }
        }
        topk = parsed;
      } catch (_) {
        topk = null;
      }
    }

    // Grid override support: prefer typed grid, fall back to primitives
    int? gridRows;
    int? gridCols;
    final typedGrid = widget.entity.attributes['attention_grid_typed'];
    final rawGrid = widget.entity.attributes['attention_grid'];
    final rawGridMap = widget.entity.attributes['attention_grid_map'];

    if (typedGrid is AttentionGrid) {
      gridRows = typedGrid.rows;
      gridCols = typedGrid.cols;
    } else if (rawGrid is AttentionGrid) {
      gridRows = rawGrid.rows;
      gridCols = rawGrid.cols;
    } else if (rawGrid is List && rawGrid.length >= 2) {
      final r = rawGrid[0];
      final c = rawGrid[1];
      if (r is num) {
        gridRows = r.toInt();
      } else if (r is String) {
        gridRows = int.tryParse(r);
      }
      if (c is num) {
        gridCols = c.toInt();
      } else if (c is String) {
        gridCols = int.tryParse(c);
      }
    } else if (rawGridMap is Map) {
      final r = rawGridMap['rows'];
      final c = rawGridMap['cols'];
      if (r is num) {
        gridRows = r.toInt();
      } else if (r is String) {
        gridRows = int.tryParse(r);
      }
      if (c is num) {
        gridCols = c.toInt();
      } else if (c is String) {
        gridCols = int.tryParse(c);
      }
    }

    final shape = widget.entity.attributes['attention_shape'];
    if (shape is Map) {
      gridRows ??= (shape['rows'] is num)
          ? (shape['rows'] as num).toInt()
          : (shape['rows'] is String
              ? int.tryParse(shape['rows'].toString())
              : null);
      gridCols ??= (shape['cols'] is num)
          ? (shape['cols'] as num).toInt()
          : (shape['cols'] is String
              ? int.tryParse(shape['cols'].toString())
              : null);
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
                      child: imageWidgetFromBytes(context, imageBytes),
                    ),
                    if (topk != null && _selectedTokenIndex != null)
                      ...markersWidget(
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
}
