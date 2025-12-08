import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'image_caption_model.freezed.dart';
part 'image_caption_model.g.dart';

@freezed
class ImageCaptionModel with _$ImageCaptionModel {
  const factory ImageCaptionModel(
          {String? id,
          @Default(<String, dynamic>{}) Map<String, dynamic> attributes}) =
      _ImageCaptionModel;
  const ImageCaptionModel._();

  /// Preserve the old Map-based constructor semantics (removes 'id' from attributes)
  factory ImageCaptionModel.fromMap(Map<String, dynamic> map) {
    final mapCopy = Map<String, dynamic>.from(map);
    final id = mapCopy.remove('id')?.toString();
    return ImageCaptionModel(id: id, attributes: mapCopy);
  }

  Map<String, dynamic> toMap() => {'id': id, ...attributes};

  factory ImageCaptionModel.fromJson(Map<String, dynamic> json) =>
      _$ImageCaptionModelFromJson(json);

  /// Returns a JSON-encodable `Map` (generated `toJson` from freezed/json_serializable
  /// provides a `Map<String, dynamic>` already). Use `toJsonString` when you
  /// need the encoded JSON `String`.
  String toJsonString() => json.encode(toMap());
}
