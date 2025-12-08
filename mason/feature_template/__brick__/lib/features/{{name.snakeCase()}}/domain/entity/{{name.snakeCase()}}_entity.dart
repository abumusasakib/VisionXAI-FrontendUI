import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part '{{name.snakeCase()}}_entity.freezed.dart';
part '{{name.snakeCase()}}_entity.g.dart';

@freezed
class {{name.pascalCase()}}Entity with _${{name.pascalCase()}}Entity {
  const factory {{name.pascalCase()}}Entity({String? id, @Default(<String, dynamic>{}) Map<String, dynamic> attributes}) = _{{name.pascalCase()}}Entity;

  const {{name.pascalCase()}}Entity._();

  factory {{name.pascalCase()}}Entity.fromMap(Map<String, dynamic> map) {
    final mapCopy = Map<String, dynamic>.from(map);
    final id = mapCopy.remove('id')?.toString();
    return {{name.pascalCase()}}Entity(id: id, attributes: mapCopy);
  }

  Map<String, dynamic> toMap() => {'id': id, ...attributes};

  factory {{name.pascalCase()}}Entity.fromJson(Map<String, dynamic> json) => _${{name.pascalCase()}}EntityFromJson(json);

  String toJsonString() => json.encode(toMap());
}
