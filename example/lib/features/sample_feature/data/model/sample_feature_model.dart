import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'sample_feature_model.freezed.dart';
part 'sample_feature_model.g.dart';

@freezed
class SampleFeatureModel with _$SampleFeatureModel {
  const factory SampleFeatureModel(
          {String? id,
          @Default(<String, dynamic>{}) Map<String, dynamic> attributes}) =
      _SampleFeatureModel;

  const SampleFeatureModel._();

  factory SampleFeatureModel.fromMap(Map<String, dynamic> map) {
    final mapCopy = Map<String, dynamic>.from(map);
    final id = mapCopy.remove('id')?.toString();
    return SampleFeatureModel(id: id, attributes: mapCopy);
  }

  Map<String, dynamic> toMap() => {'id': id, ...attributes};

  factory SampleFeatureModel.fromJson(Map<String, dynamic> json) =>
      _$SampleFeatureModelFromJson(json);

  String toJsonString() => json.encode(toMap());
}
