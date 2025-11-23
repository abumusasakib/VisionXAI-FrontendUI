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

  Color? _parseHexColor(String? hex) {
    if (hex == null) return null;
    try {
      final cleaned = hex.replaceFirst('#', '');
      if (cleaned.length == 6) {
        return Color(int.parse('0xff$cleaned'));
      }
      if (cleaned.length == 8) {
        return Color(int.parse('0x$cleaned'));
      }
    } catch (_) {}
    return null;
  }

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
                // compute marker color for the selected token (if any)
                Color? _selectedTokenColor;
                int? _selectedIdx;
                if (topk != null && _selectedTokenIndex != null) {
                  _selectedIdx = _selectedTokenIndex!;
                  final colorMap =
                      widget.entity.attributes['attention_color_map'];
                  final token = tokens.length > _selectedIdx
                      ? tokens[_selectedIdx]
                      : null;
                  if (colorMap is Map && token != null) {
                    _selectedTokenColor =
                        _parseHexColor(colorMap[token] as String?);
                  }
                  if (_selectedTokenColor == null) {
                    final colorsList =
                        widget.entity.attributes['attention_colors'];
                    if (colorsList is List &&
                        colorsList.length > _selectedIdx) {
                      _selectedTokenColor =
                          _parseHexColor(colorsList[_selectedIdx] as String?);
                    }
                  }
                }

                return Stack(
                  children: [
                    Positioned.fill(
                      child: imageWidgetFromBytes(context, imageBytes),
                    ),
                    if (topk != null && _selectedIdx != null)
                      ...markersWidget(topk, _selectedIdx, width, height,
                          gridRows: gridRows,
                          gridCols: gridCols,
                          color: _selectedTokenColor),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          // Legend row: show color swatches aligned with tokens when available
          Builder(builder: (context) {
            final colorsList = widget.entity.attributes['attention_colors'];
            final colorMap = widget.entity.attributes['attention_color_map'];
            if ((colorsList is List && colorsList.isNotEmpty) || (colorMap is Map && colorMap.isNotEmpty)) {
              return Padding(
                key: const Key('attention-legend'),
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List<Widget>.generate(tokens.length, (i) {
                      final tok = tokens.length > i ? tokens[i] : null;
                      Color? col;
                      if (colorMap is Map && tok != null) {
                        col = _parseHexColor(colorMap[tok] as String?);
                      }
                      if (col == null && colorsList is List && colorsList.length > i) {
                        col = _parseHexColor(colorsList[i] as String?);
                      }
                      col ??= Colors.grey;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Row(
                          children: [
                            Container(width: 14, height: 14, decoration: BoxDecoration(color: col, borderRadius: BorderRadius.circular(3.0), border: Border.all(color: Colors.black12))),
                            const SizedBox(width: 6),
                            Text(tok ?? '—'),
                          ],
                        ),
                      );
                    }),
                  ),
                ),
              );
            }
            return const SizedBox.shrink();
          }),
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
              // Determine color for this token: prefer explicit color map,
              // otherwise use the positional attention_colors list.
              Color? tokenColor;
              final colorMap = widget.entity.attributes['attention_color_map'];
              if (colorMap is Map) {
                final hex = colorMap[token] as String?;
                tokenColor = _parseHexColor(hex);
              }
              if (tokenColor == null) {
                final colorsList = widget.entity.attributes['attention_colors'];
                if (colorsList is List && colorsList.length > index) {
                  tokenColor = _parseHexColor(colorsList[index] as String?);
                }
              }

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
                backgroundColor: tokenColor,
                selectedColor: tokenColor?.withOpacity(0.9),
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
