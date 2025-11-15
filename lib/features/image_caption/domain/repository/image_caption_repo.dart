import 'package:dartz/dartz.dart';

import '../entity/image_caption_entity_group.dart';

/// Repository interface for the image caption feature.
/// Returns Either<Exception, EntityGroup>
import 'dart:typed_data';
import 'package:dio/dio.dart';

abstract class ImageCaptionRepo {
  /// Sends an image payload (bytes) with a filename to the remote and
  /// returns the resulting entity group.
  Future<Either<Exception, ImageCaptionEntityGroup>> call(
      Uint8List imageBytes, String filename,
      {CancelToken? cancelToken});
}
