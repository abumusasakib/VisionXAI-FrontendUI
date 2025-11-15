import 'mapper.dart';
import '../../domain/entity/image_caption_entity_group.dart';

import '../model/image_caption_response_dto.dart';
import 'image_caption_json_to_model_mapper.dart';
import 'image_caption_model_to_entity_mapper.dart';
import 'dart:convert';
import '../../domain/entity/image_caption_entity.dart';

/// Maps a typed [ImageCaptionResponseDto] to an [ImageCaptionEntityGroup].
class ImageCaptionResponseToEntityGroupMapper
    implements Mapper<ImageCaptionResponseDto, ImageCaptionEntityGroup> {
  const ImageCaptionResponseToEntityGroupMapper({
    required ImageCaptionJsonToModelMapper jsonToModelMapper,
    required ImageCaptionModelToEntityMapper modelToEntityMapper,
  })  : _jsonToModelMapper = jsonToModelMapper,
        _modelToEntityMapper = modelToEntityMapper;

  final ImageCaptionJsonToModelMapper _jsonToModelMapper;
  final ImageCaptionModelToEntityMapper _modelToEntityMapper;

  @override
  ImageCaptionEntityGroup map(ImageCaptionResponseDto response) {
    try {
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
        };
        final model = _jsonToModelMapper.map(bodyMap);
        final entity = _modelToEntityMapper.map(model);

        // Enrich entity attributes with strongly-typed topk items and decoded attention image bytes
        final enriched = Map<String, dynamic>.from(entity.attributes);
        if (response.attentionTopk != null) {
          enriched['attention_topk_items'] = response.attentionTopk;
        }
        if (response.attentionImage != null &&
            response.attentionImage!.isNotEmpty) {
          try {
            enriched['attention_image_bytes'] =
                base64Decode(response.attentionImage!);
          } catch (_) {
            // ignore decode errors
          }
        }

        final enrichedEntity =
            ImageCaptionEntity(id: entity.id, attributes: enriched);
        return ImageCaptionEntityGroup.success(enrichedEntity);
      }
      return const ImageCaptionEntityGroup.unKnown();
    } catch (_) {
      return const ImageCaptionEntityGroup.unKnown();
    }
  }
}
