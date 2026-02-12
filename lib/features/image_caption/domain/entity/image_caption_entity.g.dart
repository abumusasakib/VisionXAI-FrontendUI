// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_caption_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ImageCaptionEntity _$ImageCaptionEntityFromJson(Map<String, dynamic> json) =>
    _ImageCaptionEntity(
      id: json['id'] as String?,
      attributes: ImageCaptionAttributes.fromJson(
        json['attributes'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$ImageCaptionEntityToJson(_ImageCaptionEntity instance) =>
    <String, dynamic>{'id': instance.id, 'attributes': instance.attributes};
