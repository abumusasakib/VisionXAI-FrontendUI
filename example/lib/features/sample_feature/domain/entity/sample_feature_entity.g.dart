// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sample_feature_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SampleFeatureEntity _$SampleFeatureEntityFromJson(Map<String, dynamic> json) =>
    _SampleFeatureEntity(
      id: json['id'] as String?,
      attributes:
          json['attributes'] as Map<String, dynamic>? ??
          const <String, dynamic>{},
    );

Map<String, dynamic> _$SampleFeatureEntityToJson(
  _SampleFeatureEntity instance,
) => <String, dynamic>{'id': instance.id, 'attributes': instance.attributes};
