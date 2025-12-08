// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_caption_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ImageCaptionResponseDtoImpl _$$ImageCaptionResponseDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$ImageCaptionResponseDtoImpl(
      caption: json['caption'] as String,
      filename: json['filename'] as String?,
      tokenIds: (json['tokenIds'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      tokens:
          (json['tokens'] as List<dynamic>?)?.map((e) => e as String).toList(),
      tokenScores: (json['tokenScores'] as List<dynamic>?)
          ?.map((e) => (e as num).toDouble())
          .toList(),
      attentionImage: json['attentionImage'] as String?,
      attentionImageBytes: json['attentionImageBytes'] as String?,
      attentionMeans: (json['attentionMeans'] as List<dynamic>?)
          ?.map((e) => (e as num).toDouble())
          .toList(),
      attentionColors: (json['attentionColors'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      attentionColorMap:
          (json['attentionColorMap'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      attentionTopk: (json['attentionTopk'] as List<dynamic>?)
          ?.map((e) => (e as List<dynamic>)
              .map((e) => TopKItem.fromJson(e as Map<String, dynamic>))
              .toList())
          .toList(),
      attentionGrid: json['attentionGrid'] == null
          ? null
          : AttentionGrid.fromJson(
              json['attentionGrid'] as Map<String, dynamic>),
      attentionShape: json['attentionShape'] as Map<String, dynamic>?,
      confidence: (json['confidence'] as num?)?.toDouble(),
      id: json['id'] as String?,
      statusCode: (json['statusCode'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$ImageCaptionResponseDtoImplToJson(
        _$ImageCaptionResponseDtoImpl instance) =>
    <String, dynamic>{
      'caption': instance.caption,
      'filename': instance.filename,
      'tokenIds': instance.tokenIds,
      'tokens': instance.tokens,
      'tokenScores': instance.tokenScores,
      'attentionImage': instance.attentionImage,
      'attentionImageBytes': instance.attentionImageBytes,
      'attentionMeans': instance.attentionMeans,
      'attentionColors': instance.attentionColors,
      'attentionColorMap': instance.attentionColorMap,
      'attentionTopk': instance.attentionTopk,
      'attentionGrid': instance.attentionGrid,
      'attentionShape': instance.attentionShape,
      'confidence': instance.confidence,
      'id': instance.id,
      'statusCode': instance.statusCode,
    };
