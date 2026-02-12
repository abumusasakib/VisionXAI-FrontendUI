// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_caption_attributes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ImageCaptionAttributes _$ImageCaptionAttributesFromJson(
  Map<String, dynamic> json,
) => _ImageCaptionAttributes(
  caption: json['caption'] as String,
  filename: json['filename'] as String?,
  tokenIds: (json['tokenIds'] as List<dynamic>?)
      ?.map((e) => (e as num).toInt())
      .toList(),
  tokens: (json['tokens'] as List<dynamic>?)?.map((e) => e as String).toList(),
  tokenScores: (json['tokenScores'] as List<dynamic>?)
      ?.map((e) => (e as num).toDouble())
      .toList(),
  attentionImage: json['attentionImage'] as String?,
  attentionMeans: (json['attentionMeans'] as List<dynamic>?)
      ?.map((e) => (e as num).toDouble())
      .toList(),
  attentionColors: (json['attentionColors'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  attentionColorMap: (json['attentionColorMap'] as Map<String, dynamic>?)?.map(
    (k, e) => MapEntry(k, e as String),
  ),
  attentionTopk: (json['attentionTopk'] as List<dynamic>?)
      ?.map(
        (e) => (e as List<dynamic>)
            .map((e) => TopKItem.fromJson(e as Map<String, dynamic>))
            .toList(),
      )
      .toList(),
  attentionTopkItems: (json['attention_topk_items'] as List<dynamic>?)
      ?.map(
        (e) => (e as List<dynamic>)
            .map((e) => TopKItem.fromJson(e as Map<String, dynamic>))
            .toList(),
      )
      .toList(),
  attentionGrid: json['attentionGrid'] == null
      ? null
      : AttentionGrid.fromJson(json['attentionGrid'] as Map<String, dynamic>),
  attentionShape: json['attentionShape'] as Map<String, dynamic>?,
  confidence: (json['confidence'] as num?)?.toDouble(),
);

Map<String, dynamic> _$ImageCaptionAttributesToJson(
  _ImageCaptionAttributes instance,
) => <String, dynamic>{
  'caption': instance.caption,
  'filename': instance.filename,
  'tokenIds': instance.tokenIds,
  'tokens': instance.tokens,
  'tokenScores': instance.tokenScores,
  'attentionImage': instance.attentionImage,
  'attentionMeans': instance.attentionMeans,
  'attentionColors': instance.attentionColors,
  'attentionColorMap': instance.attentionColorMap,
  'attentionTopk': instance.attentionTopk,
  'attention_topk_items': instance.attentionTopkItems,
  'attentionGrid': instance.attentionGrid,
  'attentionShape': instance.attentionShape,
  'confidence': instance.confidence,
};
