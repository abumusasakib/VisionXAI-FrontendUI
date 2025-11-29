import 'dart:typed_data';

import 'package:dartz/dartz.dart';

import '../entity/sample_feature_entity_group.dart';

/// Repository interface for the generated feature.
/// Returns Either<Exception, EntityGroup> so generated features don't require a
/// project-specific Failure type.
abstract class SampleFeatureRepo {
  /// Accepts raw image bytes and a filename to send to the remote API.
  Future<Either<Exception, SampleFeatureEntityGroup>> call(
      Uint8List imageBytes, String filename,
      {CancelToken? cancelToken});
}
