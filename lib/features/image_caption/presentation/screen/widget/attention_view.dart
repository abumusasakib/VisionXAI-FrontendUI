import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:vision_xai/features/image_caption/core/utils/attention_utils.dart';
import 'package:vision_xai/features/image_caption/presentation/screen/widget/legends_row.dart';
import 'package:vision_xai/features/image_caption/presentation/screen/widget/token_chips_row.dart';
import '../../../domain/entity/image_caption_entity.dart';
import 'image_with_markers_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/attention_view/attention_view_cubit.dart';

/// Attention view widget
class AttentionView extends StatelessWidget {
  final ImageCaptionEntity entity;

  const AttentionView({super.key, required this.entity});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AttentionViewCubit(),
      child: _AttentionViewBody(entity: entity),
    );
  }
}

class _AttentionViewBody extends StatelessWidget {
  final ImageCaptionEntity entity;

  const _AttentionViewBody({required this.entity});

  @override
  Widget build(BuildContext context) {
    final tokens = (entity.attributes['tokens'] as List?)?.cast<String>() ?? [];
    final tokenScores = (entity.attributes['token_scores'] as List?)
            ?.map((e) => (e as num).toDouble())
            .toList() ??
        [];
    final Uint8List? imageBytes =
        entity.attributes['attention_image_bytes'] as Uint8List?;
    final rawTopk = entity.attributes['attention_topk_items'];
    final topk = parseTopK(rawTopk);

    // Grid override
    final typedGrid = entity.attributes['attention_grid_typed'];
    final rawGrid = entity.attributes['attention_grid'];
    final rawGridMap = entity.attributes['attention_grid_map'];
    final shape = entity.attributes['attention_shape'];
    final grid = parseGrid(typedGrid, rawGrid, rawGridMap, shape);
    final gridRows = grid['rows'];
    final gridCols = grid['cols'];

    // Use a larger, responsive display height (60% of viewport height, clamped).
    final double displayHeight =
        (MediaQuery.of(context).size.height * 0.6).clamp(220.0, 800.0);

    return Column(
      children: [
        if (imageBytes != null) ...[
          SizedBox(
            height: displayHeight,
            width: double.infinity,
            child: BlocBuilder<AttentionViewCubit, int?>(
              builder: (context, selectedIndex) => ImageWithMarkers(
                imageBytes: imageBytes,
                topk: topk,
                selectedIndex: selectedIndex,
                tokens: tokens,
                colorMap: entity.attributes['attention_color_map'],
                colorsList: entity.attributes['attention_colors'],
                gridRows: gridRows,
                gridCols: gridCols,
              ),
            ),
          ),
          const SizedBox(height: 8),
          LegendRow(
            tokens: tokens,
            colorsList: entity.attributes['attention_colors'],
            colorMap: entity.attributes['attention_color_map'],
          ),
        ],
        BlocBuilder<AttentionViewCubit, int?>(
          builder: (context, selectedIndex) => TokenChipsRow(
            tokens: tokens,
            tokenScores: tokenScores,
            selectedIndex: selectedIndex,
            colorMap: entity.attributes['attention_color_map'],
            colorsList: entity.attributes['attention_colors'],
            onSelected: (index, wasSelected) {
              context.read<AttentionViewCubit>().toggle(index);
            },
          ),
        ),
      ],
    );
  }
}
