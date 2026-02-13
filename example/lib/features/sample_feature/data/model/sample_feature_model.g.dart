// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sample_feature_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SampleFeatureModel _$SampleFeatureModelFromJson(Map<String, dynamic> json) =>
    _SampleFeatureModel(
      id: json['id'] as String?,
      attributes:
          json['attributes'] as Map<String, dynamic>? ??
          const <String, dynamic>{},
    );

Map<String, dynamic> _$SampleFeatureModelToJson(_SampleFeatureModel instance) =>
    <String, dynamic>{'id': instance.id, 'attributes': instance.attributes};
