import 'dart:convert';

import 'package:equatable/equatable.dart';

/// Generic model used by the feature template.
/// Stores an optional `id` and a map of arbitrary attributes.
class SampleFeatureModel extends Equatable {
  final String? id;
  final Map<String, dynamic> attributes;

  const SampleFeatureModel({this.id, this.attributes = const {}});

  factory SampleFeatureModel.fromMap(Map<String, dynamic> map) {
    final mapCopy = Map<String, dynamic>.from(map);
    final id = mapCopy.remove('id')?.toString();
    return SampleFeatureModel(id: id, attributes: mapCopy);
  }

  Map<String, dynamic> toMap() => {'id': id, ...attributes};

  factory SampleFeatureModel.fromJson(String source) =>
      SampleFeatureModel.fromMap(json.decode(source) as Map<String, dynamic>);

  String toJson() => json.encode(toMap());

  SampleFeatureModel copyWith({String? id, Map<String, dynamic>? attributes}) {
    return SampleFeatureModel(
      id: id ?? this.id,
      attributes: attributes ?? Map<String, dynamic>.from(this.attributes),
    );
  }

  @override
  List<Object?> get props => [id, attributes];
}
