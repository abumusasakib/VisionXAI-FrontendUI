import 'dart:typed_data';

import 'package:dartz/dartz.dart';

import '../entity/{{name.snakeCase()}}_entity_group.dart';

/// Repository interface for the generated feature.
/// Returns Either<Exception, EntityGroup> so generated features don't require a
/// project-specific Failure type.
abstract class {{name.pascalCase()}}Repo {
  /// Accepts raw image bytes and a filename to send to the remote API.
  Future<Either<Exception, {{name.pascalCase()}}EntityGroup>> call(Uint8List imageBytes, String filename, {CancelToken? cancelToken});
}
