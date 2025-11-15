import 'dart:typed_data';

import 'package:dartz/dartz.dart';

import '../entity/sample_feature_entity_group.dart';
import '../repository/sample_feature_repo.dart';

/// Simple use-case wrapper for the generated feature. Keeps the API small so
/// generated features don't require external usecase base classes.
class SampleFeatureUC {
  final SampleFeatureRepo repository;

  const SampleFeatureUC(this.repository);

  Future<Either<Exception, SampleFeatureEntityGroup>> call(
      Uint8List imageBytes, String filename,
      {CancelToken? cancelToken}) async {
    return await repository.call(imageBytes, filename,
        cancelToken: cancelToken);
  }
}
