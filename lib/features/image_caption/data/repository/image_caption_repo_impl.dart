import 'package:dartz/dartz.dart';

import '../../domain/entity/image_caption_entity_group.dart';
import '../../domain/repository/image_caption_repo.dart';
import '../mapper/image_caption_response_to_entity_group_mapper.dart';
import '../datasource/remote/image_caption_remote.dart';
import 'dart:typed_data';
import 'package:dio/dio.dart';

class ImageCaptionRepoImpl implements ImageCaptionRepo {
  ImageCaptionRepoImpl({
    required ImageCaptionRemote remote,
    required ImageCaptionResponseToEntityGroupMapper
        responseToEntityGroupMapper,
  })  : _remote = remote,
        _responseToEntityGroupMapper = responseToEntityGroupMapper;

  final ImageCaptionRemote _remote;
  final ImageCaptionResponseToEntityGroupMapper _responseToEntityGroupMapper;

  @override
  Future<Either<Exception, ImageCaptionEntityGroup>> call(
      Uint8List imageBytes, String filename,
      {CancelToken? cancelToken}) async {
    try {
      // The remote uses Dio for API calls.
      // Create a MultipartFile from bytes and send as multipart form field named `image`.
      final multipart = MultipartFile.fromBytes(imageBytes, filename: filename);
      final response =
          await _remote.captionImage(multipart, cancelToken: cancelToken);
      final entityGroup = _responseToEntityGroupMapper.map(response);
      return Right(entityGroup);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }
}
