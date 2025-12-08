import 'package:freezed_annotation/freezed_annotation.dart';

part '{{name.snakeCase()}}_response_dto.freezed.dart';
part '{{name.snakeCase()}}_response_dto.g.dart';

@freezed
class {{name.pascalCase()}}ResponseDto with _${{name.pascalCase()}}ResponseDto {
  const factory {{name.pascalCase()}}ResponseDto({
    required String caption,
    double? confidence,
    String? id,
    int? statusCode,
  }) = _{{name.pascalCase()}}ResponseDto;

  const {{name.pascalCase()}}ResponseDto._();

  factory {{name.pascalCase()}}ResponseDto.fromJson(Map<String, dynamic> json) => _${{name.pascalCase()}}ResponseDtoFromJson(json);
}
