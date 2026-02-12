// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_caption_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ImageCaptionEntityImpl _$$ImageCaptionEntityImplFromJson(
        Map<String, dynamic> json) =>
    _$ImageCaptionEntityImpl(
      id: json['id'] as String?,
      attributes: ImageCaptionAttributes.fromJson(
          json['attributes'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ImageCaptionEntityImplToJson(
        _$ImageCaptionEntityImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'attributes': instance.attributes,
    };
