import 'dart:typed_data';

import 'package:dartz/dartz.dart';

import '../entity/{{name.snakeCase()}}_entity_group.dart';
import '../repository/{{name.snakeCase()}}_repo.dart';

/// Simple use-case wrapper for the generated feature. Keeps the API small so
/// generated features don't require external usecase base classes.
class {{name.pascalCase()}}UC {
  final {{name.pascalCase()}}Repo repository;

  const {{name.pascalCase()}}UC(this.repository);

  Future<Either<Exception, {{name.pascalCase()}}EntityGroup>> call(Uint8List imageBytes, String filename, {CancelToken? cancelToken}) async {
    return await repository.call(imageBytes, filename, cancelToken: cancelToken);
  }
}
