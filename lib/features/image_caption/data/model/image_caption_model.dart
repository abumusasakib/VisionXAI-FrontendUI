import 'dart:convert';

import 'package:equatable/equatable.dart';

/// Model used by the image caption feature.
/// Stores an optional `id` and a map of arbitrary attributes.
class ImageCaptionModel extends Equatable {
  final String? id;
  final Map<String, dynamic> attributes;

  const ImageCaptionModel({this.id, this.attributes = const {}});

  factory ImageCaptionModel.fromMap(Map<String, dynamic> map) {
    final mapCopy = Map<String, dynamic>.from(map);
    final id = mapCopy.remove('id')?.toString();
    return ImageCaptionModel(id: id, attributes: mapCopy);
  }

  Map<String, dynamic> toMap() => {'id': id, ...attributes};

  factory ImageCaptionModel.fromJson(String source) =>
      ImageCaptionModel.fromMap(json.decode(source) as Map<String, dynamic>);

  String toJson() => json.encode(toMap());

  ImageCaptionModel copyWith({String? id, Map<String, dynamic>? attributes}) {
    return ImageCaptionModel(
      id: id ?? this.id,
      attributes: attributes ?? Map<String, dynamic>.from(this.attributes),
    );
  }

  @override
  List<Object?> get props => [id, attributes];
}
