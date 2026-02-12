import 'package:vision_xai/features/image_caption/data/model/topk_item.dart';

import 'mapper.dart';
import '../../domain/entity/image_caption_entity_group.dart';

import '../model/image_caption_response_dto.dart';

import 'image_caption_json_to_model_mapper.dart';
import 'image_caption_model_to_entity_mapper.dart';
import 'dart:typed_data';
import 'dart:developer' as developer;
import 'package:vision_xai/features/image_caption/core/utils/attention_utils.dart';

/// Maps a typed [ImageCaptionResponseDto] to an [ImageCaptionEntityGroup].
class ImageCaptionResponseToEntityGroupMapper
    extends MapperImpl<ImageCaptionResponseDto, ImageCaptionEntityGroup> {
  final ImageCaptionJsonToModelMapper _jsonToModelMapper;
  final ImageCaptionModelToEntityMapper _modelToEntityMapper;

  ImageCaptionResponseToEntityGroupMapper({
    required ImageCaptionJsonToModelMapper jsonToModelMapper,
    required ImageCaptionModelToEntityMapper modelToEntityMapper,
  })  : _jsonToModelMapper = jsonToModelMapper,
        _modelToEntityMapper = modelToEntityMapper;

  @override
  ImageCaptionEntityGroup performMap(ImageCaptionResponseDto from) {
    final response = from;
    final status = response.statusCode ?? 200;
    if (status == 200 && response.caption.isNotEmpty) {
      // 1. Convert DTO to basic Map
      final map = response.toMap();

      // 2. Use the chain: Map -> Model -> Entity
      final model = _jsonToModelMapper.map(map);
      final baseEntity = _modelToEntityMapper.map(model);

      // 3. Enrich the entity with fields that might be lost or need decoding
      // (e.g. ignored @JsonKeys, or computed fields)

      Uint8List? attentionImageBytes;
      try {
        attentionImageBytes =
            decodeAttentionImage(response.attentionImageBytes);
      } catch (_) {
        // ignore decode errors
      }

      // Process topk items
      List<List<TopKItem>>? attentionTopkItems = response.attentionTopk;

      // Process grid
      List<int>? attentionGridList;
      Map<String, int>? attentionGridMap;
      if (response.attentionGrid != null) {
        try {
          attentionGridList = response.attentionGrid!.toList();
          attentionGridMap = response.attentionGrid!.toMap();
        } catch (_) {}
      }

      // Create enriched attributes by copying base attributes
      final enrichedAttributes = baseEntity.attributes.copyWith(
        // Ensure these are set even if fromJson didn't pick them up
        filename: response.filename ?? baseEntity.attributes.filename,
        tokenIds: response.tokenIds ?? baseEntity.attributes.tokenIds,
        // Enriched fields:
        attentionImageBytes: attentionImageBytes,
        attentionTopkItems: attentionTopkItems,
        attentionGrid: response.attentionGrid,
        attentionGridTyped: response.attentionGrid,
        attentionGridList: attentionGridList,
        attentionGridMap: attentionGridMap,
        confidence: response.confidence,
      );

      final entity = baseEntity.copyWith(attributes: enrichedAttributes);

      // Summarize attributes to avoid dumping large binary
      try {
        final captionVal = enrichedAttributes.caption;
        final tokensLen = enrichedAttributes.tokens?.length;
        final tokenScoresLen = enrichedAttributes.tokenScores?.length;

        final attBytes = enrichedAttributes.attentionImageBytes;
        String attBytesSummary;
        if (attBytes != null) {
          attBytesSummary = 'Uint8List, ${attBytes.length} bytes';
        } else {
          attBytesSummary = 'null';
        }

        final topk = enrichedAttributes.attentionTopkItems;
        String topkSummary;
        if (topk != null) {
          final outer = topk.length;
          final inner = (topk.isNotEmpty) ? topk[0].length : 0;
          topkSummary = 'List outer=$outer, innerSample=$inner';
        } else {
          topkSummary = 'null';
        }

        final gridTyped = enrichedAttributes.attentionGridTyped;
        final grid = enrichedAttributes.attentionGridList;
        final gridMap = enrichedAttributes.attentionGridMap;
        final shape = enrichedAttributes.attentionShape;

        final buffer = StringBuffer();
        buffer.writeln('ImageCaptionEntity.attributes summary:');
        buffer.writeln(' caption: $captionVal');
        buffer.writeln(
            ' tokens: ${tokensLen ?? 0}, token_scores: ${tokenScoresLen ?? 0}');
        buffer.writeln(' attention_image_bytes: $attBytesSummary');
        buffer.writeln(' attention_topk_items: $topkSummary');
        if (gridTyped != null) {
          buffer.writeln(
              ' attention_grid_typed: rows=${gridTyped.rows}, cols=${gridTyped.cols}');
        } else {
          buffer.writeln(' attention_grid_typed: <none>');
        }
        if (grid != null) {
          buffer.writeln(' attention_grid (list): $grid');
        } else if (gridMap != null) {
          buffer.writeln(' attention_grid (map): $gridMap');
        } else {
          buffer.writeln(' attention_grid: <none>');
        }
        buffer.writeln(' attention_shape: ${shape ?? '<none>'}');

        developer.log(buffer.toString(),
            name: 'ImageCaptionResponseToEntityGroupMapper');
      } catch (_) {
        // ignore logging errors
      }

      return ImageCaptionEntityGroup.success(entity);
    }
    return const ImageCaptionEntityGroup.unKnown();
  }
}
