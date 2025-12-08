import 'package:freezed_annotation/freezed_annotation.dart';

part 'image_caption_entity.freezed.dart';
part 'image_caption_entity.g.dart';

@freezed
class ImageCaptionEntity with _$ImageCaptionEntity {
  const factory ImageCaptionEntity(
          {String? id,
          @Default(<String, dynamic>{}) Map<String, dynamic> attributes}) =
      _ImageCaptionEntity;
  const ImageCaptionEntity._();

  factory ImageCaptionEntity.fromJson(Map<String, dynamic> json) =>
      _$ImageCaptionEntityFromJson(json);

  factory ImageCaptionEntity.fromMap(Map<String, dynamic> map) {
    final mapCopy = Map<String, dynamic>.from(map);
    final id = mapCopy.remove('id')?.toString();
    return ImageCaptionEntity(id: id, attributes: mapCopy);
  }

  Map<String, dynamic> toMap() => {'id': id, ...attributes};
}
