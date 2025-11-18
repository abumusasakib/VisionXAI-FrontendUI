import 'package:dio/dio.dart';

import '../../data/mapper/sample_feature_json_to_model_mapper.dart';
import '../../data/mapper/sample_feature_model_to_entity_mapper.dart';
import '../../data/mapper/sample_feature_response_to_entity_group_mapper.dart';
import '../../data/datasource/remote/sample_feature_remote.dart';
import '../../data/repository/sample_feature_repo_impl.dart';
import '../../domain/use_case/sample_feature_uc.dart';

/// Helper that wires concrete data-layer implementations and returns a ready-to-use
/// use-case instance for the feature.
SampleFeatureUC createSampleFeatureUseCase(Dio dio, {String? baseUrl}) {
  final remote = SampleFeatureRemote(dio, baseUrl: baseUrl);
  final jsonToModel = SampleFeatureJsonToModelMapper();
  final modelToEntity = SampleFeatureModelToEntityMapper();
  final responseMapper = SampleFeatureResponseToEntityGroupMapper(
    jsonToModelMapper: jsonToModel,
    modelToEntityMapper: modelToEntity,
  );

  final repo = SampleFeatureRepoImpl(
    remote: remote,
    responseToEntityGroupMapper: responseMapper,
  );

  return SampleFeatureUC(repo);
}
