import 'package:freezed_annotation/freezed_annotation.dart';

part '{{name.snakeCase()}}_attributes.freezed.dart';
part '{{name.snakeCase()}}_attributes.g.dart';

/// Strongly-typed attributes for {{name.pascalCase()}}Entity.
/// Customize these fields based on your API response structure.
@freezed
class {{name.pascalCase()}}Attributes with _${{name.pascalCase()}}Attributes {
  const factory {{name.pascalCase()}}Attributes({
    /// Example field - replace with your actual attributes
    String? caption,
    double? confidence,
    // Add more fields as needed for your feature
  }) = _{{name.pascalCase()}}Attributes;

  factory {{name.pascalCase()}}Attributes.fromJson(Map<String, dynamic> json) =>
      _${{name.pascalCase()}}AttributesFromJson(json);
}
