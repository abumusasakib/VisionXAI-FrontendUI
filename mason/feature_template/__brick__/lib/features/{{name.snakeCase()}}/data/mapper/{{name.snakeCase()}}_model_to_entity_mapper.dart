import 'mapper.dart';

import '../../domain/entity/{{name.snakeCase()}}_entity.dart';
import '../../domain/entity/{{name.snakeCase()}}_attributes.dart';
import '../model/{{name.snakeCase()}}_model.dart';

class {{name.pascalCase()}}ModelToEntityMapper implements Mapper<{{name.pascalCase()}}Model, {{name.pascalCase()}}Entity> {
  @override
  {{name.pascalCase()}}Entity map({{name.pascalCase()}}Model model) {
    return {{name.pascalCase()}}Entity(
        id: model.id,
        attributes: {{name.pascalCase()}}Attributes.fromJson(model.attributes));
  }
}
