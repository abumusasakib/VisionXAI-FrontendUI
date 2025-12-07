import 'mapper.dart';

import '../../domain/entity/sample_feature_entity.dart';
import '../model/sample_feature_model.dart';

class SampleFeatureModelToEntityMapper implements Mapper<SampleFeatureModel, SampleFeatureEntity> {
  @override
  SampleFeatureEntity map(SampleFeatureModel model) {
    // By default we map id + attributes. Projects can override the generated entity later.
    return SampleFeatureEntity(id: model.id, attributes: model.attributes);
  }
}
