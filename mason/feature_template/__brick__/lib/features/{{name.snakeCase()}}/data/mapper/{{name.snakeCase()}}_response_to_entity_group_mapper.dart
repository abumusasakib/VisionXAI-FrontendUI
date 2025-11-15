import 'mapper.dart';
import '../../domain/entity/{{name.snakeCase()}}_entity_group.dart';

import '../model/{{name.snakeCase()}}_response_dto.dart';
import '{{name.snakeCase()}}_json_to_model_mapper.dart';
import '{{name.snakeCase()}}_model_to_entity_mapper.dart';

/// Maps a typed response DTO to an entity group.
class {{name.pascalCase()}}ResponseToEntityGroupMapper implements Mapper<{{name.pascalCase()}}ResponseDto, {{name.pascalCase()}}EntityGroup> {
  const {{name.pascalCase()}}ResponseToEntityGroupMapper({
    required {{name.pascalCase()}}JsonToModelMapper jsonToModelMapper,
    required {{name.pascalCase()}}ModelToEntityMapper modelToEntityMapper,
  }) : _jsonToModelMapper = jsonToModelMapper,
       _modelToEntityMapper = modelToEntityMapper;

  final {{name.pascalCase()}}JsonToModelMapper _jsonToModelMapper;
  final {{name.pascalCase()}}ModelToEntityMapper _modelToEntityMapper;

  @override
  {{name.pascalCase()}}EntityGroup map({{name.pascalCase()}}ResponseDto response) {
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
        return {{name.pascalCase()}}EntityGroup.success(entity);
      }
      return const {{name.pascalCase()}}EntityGroup.unKnown();
    } catch (_) {
      return const {{name.pascalCase()}}EntityGroup.unKnown();
    }
  }
}
