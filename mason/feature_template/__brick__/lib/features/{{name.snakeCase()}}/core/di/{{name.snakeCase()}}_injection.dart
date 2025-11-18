import 'package:dio/dio.dart';

import '../../data/mapper/{{name.snakeCase()}}_json_to_model_mapper.dart';
import '../../data/mapper/{{name.snakeCase()}}_model_to_entity_mapper.dart';
import '../../data/mapper/{{name.snakeCase()}}_response_to_entity_group_mapper.dart';
import '../../data/datasource/remote/{{name.snakeCase()}}_remote.dart';
import '../../data/repository/{{name.snakeCase()}}_repo_impl.dart';
import '../../domain/use_case/{{name.snakeCase()}}_uc.dart';

/// Helper that wires concrete data-layer implementations and returns a ready-to-use
/// use-case instance for the feature.
{{name.pascalCase()}}UC create{{name.pascalCase()}}UseCase(Dio dio, {String? baseUrl}) {
  final remote = {{name.pascalCase()}}Remote(dio, baseUrl: baseUrl);
  final jsonToModel = {{name.pascalCase()}}JsonToModelMapper();
  final modelToEntity = {{name.pascalCase()}}ModelToEntityMapper();
  final responseMapper = {{name.pascalCase()}}ResponseToEntityGroupMapper(
    jsonToModelMapper: jsonToModel,
    modelToEntityMapper: modelToEntity,
  );

  final repo = {{name.pascalCase()}}RepoImpl(
    remote: remote,
    responseToEntityGroupMapper: responseMapper,
  );

  return {{name.pascalCase()}}UC(repo);
}
