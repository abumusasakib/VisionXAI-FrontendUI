// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_caption_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ImageCaptionModel _$ImageCaptionModelFromJson(Map<String, dynamic> json) =>
    _ImageCaptionModel(
      id: json['id'] as String?,
      attributes:
          json['attributes'] as Map<String, dynamic>? ??
          const <String, dynamic>{},
    );

Map<String, dynamic> _$ImageCaptionModelToJson(_ImageCaptionModel instance) =>
    <String, dynamic>{'id': instance.id, 'attributes': instance.attributes};
