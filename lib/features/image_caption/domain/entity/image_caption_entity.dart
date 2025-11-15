import 'package:equatable/equatable.dart';

/// Entity used by the image caption feature.
/// Keeps an `id` and an attributes map.
class ImageCaptionEntity extends Equatable {
  final String? id;
  final Map<String, dynamic> attributes;

  const ImageCaptionEntity({this.id, this.attributes = const {}});

  factory ImageCaptionEntity.fromMap(Map<String, dynamic> map) {
    final mapCopy = Map<String, dynamic>.from(map);
    final id = mapCopy.remove('id')?.toString();
    return ImageCaptionEntity(id: id, attributes: mapCopy);
  }

  Map<String, dynamic> toMap() => {'id': id, ...attributes};

  @override
  List<Object?> get props => [id, attributes];
}
