import 'mapper.dart';

import '../../domain/entity/sample_feature_entity.dart';
import '../../domain/entity/sample_feature_attributes.dart';
import '../model/sample_feature_model.dart';

class SampleFeatureModelToEntityMapper implements Mapper<SampleFeatureModel, SampleFeatureEntity> {
  @override
  SampleFeatureEntity map(SampleFeatureModel model) {
    return SampleFeatureEntity(
        id: model.id,
        attributes: SampleFeatureAttributes.fromJson(model.attributes));
  }
}
