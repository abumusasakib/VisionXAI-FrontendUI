import 'mapper.dart';
import '../model/sample_feature_model.dart';

class SampleFeatureJsonToModelMapper implements Mapper<Object, SampleFeatureModel> {
  @override
  SampleFeatureModel map(Object tFrom) {
    if (tFrom is String) return SampleFeatureModel.fromJson(tFrom);
    if (tFrom is Map<String, dynamic>) return SampleFeatureModel.fromMap(tFrom);
    throw ArgumentError('Unsupported input for SampleFeatureJsonToModelMapper: ${tFrom.runtimeType}');
  }
}
