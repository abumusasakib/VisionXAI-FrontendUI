import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../domain/entity/sample_feature_entity_group.dart';
import '../../domain/repository/sample_feature_repo.dart';
import '../mapper/sample_feature_response_to_entity_group_mapper.dart';
import '../datasource/remote/sample_feature_remote.dart';

class SampleFeatureRepoImpl implements SampleFeatureRepo {
  SampleFeatureRepoImpl({
    required SampleFeatureRemote remote,
    required SampleFeatureResponseToEntityGroupMapper responseToEntityGroupMapper,
  })  : _remote = remote,
        _responseToEntityGroupMapper = responseToEntityGroupMapper;

  final SampleFeatureRemote _remote;
  final SampleFeatureResponseToEntityGroupMapper _responseToEntityGroupMapper;

  @override
  Future<Either<Exception, SampleFeatureEntityGroup>> call(Uint8List imageBytes, String filename, {CancelToken? cancelToken}) async {
    try {
      final multipart = MultipartFile.fromBytes(imageBytes, filename: filename);
      final response = await _remote.captionImage({'image': multipart}, cancelToken: cancelToken);
      final entityGroup = _responseToEntityGroupMapper.map(response);
      return Right(entityGroup);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }
}
