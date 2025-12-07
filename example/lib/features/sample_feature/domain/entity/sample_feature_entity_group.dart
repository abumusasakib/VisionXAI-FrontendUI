import 'package:freezed_annotation/freezed_annotation.dart';

import 'sample_feature_entity.dart';

part 'sample_feature_entity_group.freezed.dart';

@freezed
class SampleFeatureEntityGroup with _$SampleFeatureEntityGroup {
  const factory SampleFeatureEntityGroup.success(SampleFeatureEntity entity
  ) = _Success;
  const factory SampleFeatureEntityGroup.unKnown() = _Unknown;
    //TODO write other factory 
}
