import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'sample_feature_entity.freezed.dart';
part 'sample_feature_entity.g.dart';

@freezed
class SampleFeatureEntity with _$SampleFeatureEntity {
  const factory SampleFeatureEntity(
          {String? id,
          @Default(<String, dynamic>{}) Map<String, dynamic> attributes}) =
      _SampleFeatureEntity;

  const SampleFeatureEntity._();

  factory SampleFeatureEntity.fromMap(Map<String, dynamic> map) {
    final mapCopy = Map<String, dynamic>.from(map);
    final id = mapCopy.remove('id')?.toString();
    return SampleFeatureEntity(id: id, attributes: mapCopy);
  }

  Map<String, dynamic> toMap() => {'id': id, ...attributes};

  factory SampleFeatureEntity.fromJson(Map<String, dynamic> json) =>
      _$SampleFeatureEntityFromJson(json);

  String toJsonString() => json.encode(toMap());
}
