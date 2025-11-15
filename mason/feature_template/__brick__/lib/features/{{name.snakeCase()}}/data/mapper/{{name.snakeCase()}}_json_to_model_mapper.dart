import 'mapper.dart';
import '../model/{{name.snakeCase()}}_model.dart';

class {{name.pascalCase()}}JsonToModelMapper implements Mapper<Object, {{name.pascalCase()}}Model> {
  @override
  {{name.pascalCase()}}Model map(Object tFrom) {
    if (tFrom is String) return {{name.pascalCase()}}Model.fromJson(tFrom);
    if (tFrom is Map<String, dynamic>) return {{name.pascalCase()}}Model.fromMap(tFrom);
    throw ArgumentError('Unsupported input for {{name.pascalCase()}}JsonToModelMapper: ${tFrom.runtimeType}');
  }
}
