import 'mapper.dart';
import '../../domain/entity/image_caption_entity_group.dart';

import '../model/image_caption_response_dto.dart';
import '../model/attention_grid.dart';
import 'image_caption_json_to_model_mapper.dart';
import 'image_caption_model_to_entity_mapper.dart';
import 'dart:typed_data';
import 'dart:developer' as developer;
import 'package:vision_xai/features/image_caption/core/utils/attention_utils.dart';
import '../../domain/entity/image_caption_entity.dart';

/// Maps a typed [ImageCaptionResponseDto] to an [ImageCaptionEntityGroup].
class ImageCaptionResponseToEntityGroupMapper
    extends MapperImpl<ImageCaptionResponseDto, ImageCaptionEntityGroup> {
  ImageCaptionResponseToEntityGroupMapper({
    required ImageCaptionJsonToModelMapper jsonToModelMapper,
    required ImageCaptionModelToEntityMapper modelToEntityMapper,
  })  : _jsonToModelMapper = jsonToModelMapper,
        _modelToEntityMapper = modelToEntityMapper;

  final ImageCaptionJsonToModelMapper _jsonToModelMapper;
  final ImageCaptionModelToEntityMapper _modelToEntityMapper;

  @override
  ImageCaptionEntityGroup performMap(ImageCaptionResponseDto from) {
    final response = from;
    final status = response.statusCode ?? 200;
    if (status == 200 && response.caption.isNotEmpty) {
      // Create a model-friendly map so that the JSON->Model mapper can be used.
      final bodyMap = <String, dynamic>{
        'id': response.id,
        'filename': response.filename,
        'caption': response.caption,
        'confidence': response.confidence,
        'token_ids': response.tokenIds,
        'tokens': response.tokens,
        'token_scores': response.tokenScores,
        'attention_image': response.attentionImage,
        'attention_means': response.attentionMeans,
        'attention_topk': response.attentionTopk
            ?.map((outer) => outer.map((item) => item.toList()).toList())
            .toList(),
        'attention_grid': response.attentionGrid,
        'attention_shape': response.attentionShape,
        // attention_grid/shape in the raw response map
        'attention_image_bytes': response.attentionImageBytes,
        'attention_topk_items': response.attentionTopk
            ?.map((outer) => outer.map((item) => item.toMap()).toList())
            .toList(),
      };
      final model = _jsonToModelMapper.map(bodyMap);
      final entity = _modelToEntityMapper.map(model);

      // Enrich entity attributes with strongly-typed topk items and decoded attention image bytes
      final enriched = Map<String, dynamic>.from(entity.attributes);
      // Prefer already-provided base64 bytes key; use utility to decode
      try {
        final decodedFromBytes =
            decodeAttentionImage(response.attentionImageBytes);
        if (decodedFromBytes != null) {
          enriched['attention_image_bytes'] = decodedFromBytes;
        } else {
          final decodedFromImage =
              decodeAttentionImage(response.attentionImage);
          if (decodedFromImage != null) {
            enriched['attention_image_bytes'] = decodedFromImage;
          }
        }
      } catch (_) {
        // ignore decode errors
      }

      if (response.attentionTopk != null) {
        enriched['attention_topk_items'] = response.attentionTopk!
            .map((outer) => outer.map((item) => item.toMap()).toList())
            .toList();
      }

      // Expose both typed and primitive forms of the attention grid so
      // UI code can prefer a typed value but still read primitive lists/maps.
      if (response.attentionGrid != null) {
        enriched['attention_grid_typed'] = response.attentionGrid;
        try {
          enriched['attention_grid'] = response.attentionGrid!.toList();
          enriched['attention_grid_map'] = response.attentionGrid!.toMap();
        } catch (_) {
          // fallback: leave as-is
          enriched['attention_grid'] = response.attentionGrid;
        }
      }

      final enrichedEntity =
          ImageCaptionEntity(id: entity.id, attributes: enriched);

      // Summarize attributes to avoid dumping large binary
      try {
        final attrs = enriched;
        final captionVal = attrs['caption'];
        final tokensLen = (attrs['tokens'] as List?)?.length;
        final tokenScoresLen = (attrs['token_scores'] as List?)?.length;

        final attBytes = attrs['attention_image_bytes'];
        String attBytesSummary;
        if (attBytes is Uint8List) {
          attBytesSummary = 'Uint8List, ${attBytes.length} bytes';
        } else if (attBytes is List<int>) {
          attBytesSummary = 'List<int>, ${attBytes.length} bytes';
        } else if (attBytes is String) {
          attBytesSummary = 'String (base64?), length ${attBytes.length}';
        } else {
          attBytesSummary = 'null';
        }

        final topk = attrs['attention_topk_items'];
        String topkSummary;
        if (topk is List) {
          final outer = topk.length;
          final inner = (topk.isNotEmpty && topk[0] is List)
              ? (topk[0] as List).length
              : 0;
          topkSummary = 'List outer=$outer, innerSample=$inner';
        } else {
          topkSummary = 'null';
        }

        final gridTyped = attrs['attention_grid_typed'];
        final grid = attrs['attention_grid'];
        final gridMap = attrs['attention_grid_map'];
        final shape = attrs['attention_shape'];

        final buffer = StringBuffer();
        buffer.writeln('ImageCaptionEntity.attributes summary:');
        buffer.writeln(' caption: ${captionVal ?? '<null>'}');
        buffer.writeln(
            ' tokens: ${tokensLen ?? 0}, token_scores: ${tokenScoresLen ?? 0}');
        buffer.writeln(' attention_image_bytes: $attBytesSummary');
        buffer.writeln(' attention_topk_items: $topkSummary');
        if (gridTyped is AttentionGrid) {
          buffer.writeln(
              ' attention_grid_typed: rows=${gridTyped.rows}, cols=${gridTyped.cols}');
        } else {
          buffer.writeln(' attention_grid_typed: ${gridTyped ?? '<none>'}');
        }
        if (grid is List) {
          buffer.writeln(' attention_grid (list): $grid');
        } else if (gridMap is Map) {
          buffer.writeln(' attention_grid (map): $gridMap');
        } else {
          buffer.writeln(' attention_grid: ${grid ?? '<none>'}');
        }
        buffer.writeln(' attention_shape: ${shape ?? '<none>'}');

        developer.log(buffer.toString(),
            name: 'ImageCaptionResponseToEntityGroupMapper');
      } catch (_) {
        // ignore logging errors
      }

      return ImageCaptionEntityGroup.success(enrichedEntity);
    }
    return const ImageCaptionEntityGroup.unKnown();
  }
}
