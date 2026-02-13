import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:vision_xai/features/image_caption/core/utils/attention_utils.dart';
import 'package:vision_xai/features/image_caption/presentation/screen/widget/legends_row.dart';
import 'package:vision_xai/features/image_caption/presentation/screen/widget/token_chips_row.dart';
import 'package:vision_xai/features/image_caption/core/utils/image_layout_utils.dart';
import '../../../domain/entity/image_caption_entity.dart';
import 'image_with_markers_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/attention_view/attention_view_cubit.dart';

import 'package:logging/logging.dart';

final Logger _logger = Logger('AttentionView');

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
    final attributes = entity.attributes;
    final tokens = attributes.tokens ?? [];
    final tokenScores = attributes.tokenScores ?? [];
    final Uint8List? imageBytes = attributes.attentionImageBytes;
    final topk = attributes.attentionTopkItems ?? [];

    // Grid override
    // We can use the typed grid directly if available, or fall back to parsing
    // In the new attributes, attentionGridTyped is redundant with attentionGrid if it is strictly typed.
    // The mapper puts attentionGrid (if compatible) into attentionGridTyped.
    // But let's check how ImageCaptionAttributes is defined.
    // It has attentionGrid (AttentionGrid?) and attentionGridTyped (AttentionGrid?).
    // And attentionGridList (List<int>?) and attentionGridMap (Map<String, int>?).
    // The previous logic was:
    // final typedGrid = entity.attributes['attention_grid_typed'];
    // final rawGrid = entity.attributes['attention_grid'];
    // final rawGridMap = entity.attributes['attention_grid_map'];
    // final shape = entity.attributes['attention_shape'];
    // final grid = parseGrid(typedGrid, rawGrid, rawGridMap, shape);

    // We can simplify if we trust our mapper/attributes, but preserving the robust parsing logic is safer
    // if we think there might be some edge cases.
    // However, `parseGrid` expects dynamic inputs.
    // Let's pass the typed values if possible or just use the extracted ones.

    // attributes.attentionGrid is specific type AttentionGrid?
    // attributes.attentionShape is Map<String, dynamic>?

    // Let's rely on the helper `parseGrid` but passing the new properties.
    final grid = parseGrid(
      attributes.attentionGridTyped,
      attributes.attentionGridList ?? attributes.attentionGrid,
      attributes.attentionGridMap,
      attributes.attentionShape,
    );
    final gridRows = grid['rows'];
    final gridCols = grid['cols'];

    final double displayHeight = getResponsiveImageHeight(context);

    return Builder(
      builder: (context) {
        // Logging for attention colors
        _logger.info(
          'tokens=${tokens.length}, colors=${entity.attributes.attentionColors?.length}, colorMap=${entity.attributes.attentionColorMap?.length}',
        );
        if (entity.attributes.attentionColors != null &&
            entity.attributes.attentionColors!.isNotEmpty) {
          _logger.info(
            'First color=${entity.attributes.attentionColors!.first}',
          );
        }

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
                    colorMap: entity.attributes.attentionColorMap,
                    colorsList: entity.attributes.attentionColors,
                    gridRows: gridRows,
                    gridCols: gridCols,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              LegendRow(
                tokens: tokens,
                colorsList: entity.attributes.attentionColors,
                colorMap: entity.attributes.attentionColorMap,
              ),
            ],
            BlocBuilder<AttentionViewCubit, int?>(
              builder: (context, selectedIndex) => TokenChipsRow(
                tokens: tokens,
                tokenScores: tokenScores,
                selectedIndex: selectedIndex,
                colorMap: entity.attributes.attentionColorMap,
                colorsList: entity.attributes.attentionColors,
                onSelected: (index, wasSelected) {
                  context.read<AttentionViewCubit>().toggle(index);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
