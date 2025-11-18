import 'package:json_annotation/json_annotation.dart';

part 'sample_feature_response_dto.g.dart';

@JsonSerializable()
class SampleFeatureResponseDto {
  final String caption;
  final double? confidence;
  final String? id;
  final int? statusCode;

  SampleFeatureResponseDto({
    required this.caption,
    this.confidence,
    this.id,
    this.statusCode,
  });

  factory SampleFeatureResponseDto.fromJson(Map<String, dynamic> json) => _$SampleFeatureResponseDtoFromJson(json);
  Map<String, dynamic> toJson() => _$SampleFeatureResponseDtoToJson(this);
}
