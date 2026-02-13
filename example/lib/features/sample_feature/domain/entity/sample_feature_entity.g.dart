// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sample_feature_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SampleFeatureEntity _$SampleFeatureEntityFromJson(Map<String, dynamic> json) =>
    _SampleFeatureEntity(
      id: json['id'] as String?,
      attributes: SampleFeatureAttributes.fromJson(
        json['attributes'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$SampleFeatureEntityToJson(
  _SampleFeatureEntity instance,
) => <String, dynamic>{'id': instance.id, 'attributes': instance.attributes};
