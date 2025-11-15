import 'dart:convert';

import 'package:equatable/equatable.dart';

/// Generic model used by the feature template.
/// Stores an optional `id` and a map of arbitrary attributes.
class {{name.pascalCase()}}Model extends Equatable {
  final String? id;
  final Map<String, dynamic> attributes;

  const {{name.pascalCase()}}Model({this.id, this.attributes = const {}});

  factory {{name.pascalCase()}}Model.fromMap(Map<String, dynamic> map) {
    final mapCopy = Map<String, dynamic>.from(map);
    final id = mapCopy.remove('id')?.toString();
    return {{name.pascalCase()}}Model(id: id, attributes: mapCopy);
  }

  Map<String, dynamic> toMap() => {'id': id, ...attributes};

  factory {{name.pascalCase()}}Model.fromJson(String source) =>
      {{name.pascalCase()}}Model.fromMap(json.decode(source) as Map<String, dynamic>);

  String toJson() => json.encode(toMap());

  {{name.pascalCase()}}Model copyWith({String? id, Map<String, dynamic>? attributes}) {
    return {{name.pascalCase()}}Model(
      id: id ?? this.id,
      attributes: attributes ?? Map<String, dynamic>.from(this.attributes),
    );
  }

  @override
  List<Object?> get props => [id, attributes];
}
