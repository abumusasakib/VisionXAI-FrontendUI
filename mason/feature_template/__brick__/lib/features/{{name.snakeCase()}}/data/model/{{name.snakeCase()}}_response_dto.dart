import 'package:json_annotation/json_annotation.dart';

part '{{name.snakeCase()}}_response_dto.g.dart';

@JsonSerializable()
class {{name.pascalCase()}}ResponseDto {
  final String caption;
  final double? confidence;
  final String? id;
  final int? statusCode;

  {{name.pascalCase()}}ResponseDto({
    required this.caption,
    this.confidence,
    this.id,
    this.statusCode,
  });

  factory {{name.pascalCase()}}ResponseDto.fromJson(Map<String, dynamic> json) => _${{name.pascalCase()}}ResponseDtoFromJson(json);
  Map<String, dynamic> toJson() => _${{name.pascalCase()}}ResponseDtoToJson(this);
}
