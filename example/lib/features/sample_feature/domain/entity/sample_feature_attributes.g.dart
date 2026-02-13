// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sample_feature_attributes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SampleFeatureAttributes _$SampleFeatureAttributesFromJson(
  Map<String, dynamic> json,
) => _SampleFeatureAttributes(
  caption: json['caption'] as String?,
  confidence: (json['confidence'] as num?)?.toDouble(),
);

Map<String, dynamic> _$SampleFeatureAttributesToJson(
  _SampleFeatureAttributes instance,
) => <String, dynamic>{
  'caption': instance.caption,
  'confidence': instance.confidence,
};
