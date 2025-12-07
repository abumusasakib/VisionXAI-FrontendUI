import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../entity/image_caption_entity_group.dart';

/// Repository interface for the image caption feature.
/// Returns a `Either<Exception, ImageCaptionEntityGroup>` containing
/// either the failure or the mapped entity group.
abstract class ImageCaptionRepo {
  /// Sends an image payload (bytes) with a filename to the remote and
  /// returns the resulting entity group.
  Future<Either<Exception, ImageCaptionEntityGroup>> call(
      Uint8List imageBytes, String filename,
      {CancelToken? cancelToken});
}
