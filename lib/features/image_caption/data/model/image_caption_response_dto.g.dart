// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_caption_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageCaptionResponseDto _$ImageCaptionResponseDtoFromJson(
        Map<String, dynamic> json) =>
    ImageCaptionResponseDto(
      caption: json['caption'] as String,
      filename: json['filename'] as String?,
      tokenIds:
          (json['token_ids'] as List<dynamic>?)?.map((e) => e as int).toList(),
      tokens:
          (json['tokens'] as List<dynamic>?)?.map((e) => e as String).toList(),
      tokenScores: (json['token_scores'] as List<dynamic>?)
          ?.map((e) => (e as num).toDouble())
          .toList(),
      attentionImage: json['attention_image'] as String?,
      attentionMeans: (json['attention_means'] as List<dynamic>?)
          ?.map((e) => (e as num).toDouble())
          .toList(),
      attentionTopk: (json['attention_topk'] as List<dynamic>?)
          ?.map((outer) => (outer as List<dynamic>)
              .map((entry) => TopKItem.fromList(entry as List<dynamic>))
              .toList())
          .toList(),
      confidence: (json['confidence'] as num?)?.toDouble(),
      id: json['id'] as String?,
      statusCode: (json['statusCode'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ImageCaptionResponseDtoToJson(
        ImageCaptionResponseDto instance) =>
    <String, dynamic>{
      'caption': instance.caption,
      'filename': instance.filename,
      'token_ids': instance.tokenIds,
      'tokens': instance.tokens,
      'token_scores': instance.tokenScores,
      'attention_image': instance.attentionImage,
      'attention_means': instance.attentionMeans,
      'attention_topk': instance.attentionTopk
          ?.map((outer) => outer.map((item) => item.toList()).toList())
          .toList(),
      'confidence': instance.confidence,
      'id': instance.id,
      'statusCode': instance.statusCode,
    };
