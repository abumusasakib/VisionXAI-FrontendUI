import 'mapper.dart';
import '../../domain/entity/sample_feature_entity_group.dart';

import '../model/sample_feature_response_dto.dart';
import 'sample_feature_json_to_model_mapper.dart';
import 'sample_feature_model_to_entity_mapper.dart';

/// Maps a typed response DTO to an entity group.
class SampleFeatureResponseToEntityGroupMapper implements Mapper<SampleFeatureResponseDto, SampleFeatureEntityGroup> {
  const SampleFeatureResponseToEntityGroupMapper({
    required SampleFeatureJsonToModelMapper jsonToModelMapper,
    required SampleFeatureModelToEntityMapper modelToEntityMapper,
  }) : _jsonToModelMapper = jsonToModelMapper,
       _modelToEntityMapper = modelToEntityMapper;

  final SampleFeatureJsonToModelMapper _jsonToModelMapper;
  final SampleFeatureModelToEntityMapper _modelToEntityMapper;

  @override
  SampleFeatureEntityGroup map(SampleFeatureResponseDto response) {
    try {
      final status = response.statusCode ?? 200;
      if (status == 200 && response.caption.isNotEmpty) {
        final bodyMap = <String, dynamic>{
          'id': response.id,
          'caption': response.caption,
          'confidence': response.confidence,
        };
        final model = _jsonToModelMapper.map(bodyMap);
        final entity = _modelToEntityMapper.map(model);
        return SampleFeatureEntityGroup.success(entity);
      }
      return const SampleFeatureEntityGroup.unKnown();
    } catch (_) {
      return const SampleFeatureEntityGroup.unKnown();
    }
  }
}
