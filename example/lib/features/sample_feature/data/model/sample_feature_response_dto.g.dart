// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sample_feature_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SampleFeatureResponseDto _$SampleFeatureResponseDtoFromJson(
  Map<String, dynamic> json,
) => SampleFeatureResponseDto(
  caption: json['caption'] as String,
  confidence: (json['confidence'] as num?)?.toDouble(),
  id: json['id'] as String?,
  statusCode: (json['statusCode'] as num?)?.toInt(),
);

Map<String, dynamic> _$SampleFeatureResponseDtoToJson(
  SampleFeatureResponseDto instance,
) => <String, dynamic>{
  'caption': instance.caption,
  'confidence': instance.confidence,
  'id': instance.id,
  'statusCode': instance.statusCode,
};
