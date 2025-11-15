import 'mapper.dart';

import '../../domain/entity/{{name.snakeCase()}}_entity.dart';
import '../model/{{name.snakeCase()}}_model.dart';

class {{name.pascalCase()}}ModelToEntityMapper implements Mapper<{{name.pascalCase()}}Model, {{name.pascalCase()}}Entity> {
  @override
  {{name.pascalCase()}}Entity map({{name.pascalCase()}}Model model) {
    // By default we map id + attributes. Projects can override the generated entity later.
    return {{name.pascalCase()}}Entity(id: model.id, attributes: model.attributes);
  }
}
