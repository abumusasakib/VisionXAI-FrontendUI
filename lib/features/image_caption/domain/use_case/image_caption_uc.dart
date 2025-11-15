import 'dart:typed_data';
import 'package:dio/dio.dart';

import 'package:dartz/dartz.dart';

import '../entity/image_caption_entity_group.dart';
import '../repository/image_caption_repo.dart';

/// Simple use-case for the image caption feature.
class ImageCaptionUC {
  final ImageCaptionRepo repository;

  const ImageCaptionUC(this.repository);

  Future<Either<Exception, ImageCaptionEntityGroup>> call(
      Uint8List imageBytes, String filename,
      {CancelToken? cancelToken}) async {
    return await repository.call(imageBytes, filename,
        cancelToken: cancelToken);
  }
}
