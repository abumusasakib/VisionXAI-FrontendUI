import 'package:freezed_annotation/freezed_annotation.dart';

part 'sample_feature_response_dto.freezed.dart';
part 'sample_feature_response_dto.g.dart';

@freezed
class SampleFeatureResponseDto with _$SampleFeatureResponseDto {
  const factory SampleFeatureResponseDto({
    required String caption,
    double? confidence,
    String? id,
    int? statusCode,
  }) = _SampleFeatureResponseDto;

  const SampleFeatureResponseDto._();

  factory SampleFeatureResponseDto.fromJson(Map<String, dynamic> json) =>
      _$SampleFeatureResponseDtoFromJson(json);
}
