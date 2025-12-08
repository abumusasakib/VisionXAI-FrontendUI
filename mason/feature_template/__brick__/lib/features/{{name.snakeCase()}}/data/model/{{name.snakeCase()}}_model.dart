import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part '{{name.snakeCase()}}_model.freezed.dart';
part '{{name.snakeCase()}}_model.g.dart';

@freezed
class {{name.pascalCase()}}Model with _${{name.pascalCase()}}Model {
  const factory {{name.pascalCase()}}Model({String? id, @Default(<String, dynamic>{}) Map<String, dynamic> attributes}) = _{{name.pascalCase()}}Model;

  const {{name.pascalCase()}}Model._();

  /// Preserve original Map-based constructor semantics (remove 'id' from attributes)
  factory {{name.pascalCase()}}Model.fromMap(Map<String, dynamic> map) {
    final mapCopy = Map<String, dynamic>.from(map);
    final id = mapCopy.remove('id')?.toString();
    return {{name.pascalCase()}}Model(id: id, attributes: mapCopy);
  }

  /// Generated JSON factory (Map -> model).
  factory {{name.pascalCase()}}Model.fromJson(Map<String, dynamic> json) => _${{name.pascalCase()}}ModelFromJson(json);

  /// Convenience: return JSON string encoded from the Map representation.
  String toJsonString() => json.encode(toMap());

  Map<String, dynamic> toMap() => {'id': id, ...attributes};
}
