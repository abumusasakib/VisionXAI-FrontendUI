import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'sample_feature_model.freezed.dart';
part 'sample_feature_model.g.dart';

@freezed
class SampleFeatureModel with _$SampleFeatureModel {
  const factory SampleFeatureModel({String? id, @Default(<String, dynamic>{}) Map<String, dynamic> attributes}) = _SampleFeatureModel;

  const SampleFeatureModel._();

  /// Preserve original Map-based constructor semantics (remove 'id' from attributes)
  factory SampleFeatureModel.fromMap(Map<String, dynamic> map) {
    final mapCopy = Map<String, dynamic>.from(map);
    final id = mapCopy.remove('id')?.toString();
    return SampleFeatureModel(id: id, attributes: mapCopy);
  }

  /// Generated JSON factory (Map -> model).
  factory SampleFeatureModel.fromJson(Map<String, dynamic> json) => _$SampleFeatureModelFromJson(json);

  /// Convenience: return JSON string encoded from the Map representation.
  String toJsonString() => json.encode(toMap());

  Map<String, dynamic> toMap() => {'id': id, ...attributes};
}
