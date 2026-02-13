import 'package:freezed_annotation/freezed_annotation.dart';

part 'sample_feature_attributes.freezed.dart';
part 'sample_feature_attributes.g.dart';

/// Strongly-typed attributes for SampleFeatureEntity.
/// Customize these fields based on your API response structure.
@freezed
class SampleFeatureAttributes with _$SampleFeatureAttributes {
  const factory SampleFeatureAttributes({
    /// Example field - replace with your actual attributes
    String? caption,
    double? confidence,
    // Add more fields as needed for your feature
  }) = _SampleFeatureAttributes;

  factory SampleFeatureAttributes.fromJson(Map<String, dynamic> json) =>
      _$SampleFeatureAttributesFromJson(json);
}
