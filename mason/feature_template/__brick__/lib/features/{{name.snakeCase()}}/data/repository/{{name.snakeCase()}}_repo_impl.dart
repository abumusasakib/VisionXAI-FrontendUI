import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../domain/entity/{{name.snakeCase()}}_entity_group.dart';
import '../../domain/repository/{{name.snakeCase()}}_repo.dart';
import '../mapper/{{name.snakeCase()}}_response_to_entity_group_mapper.dart';
import '../datasource/remote/{{name.snakeCase()}}_remote.dart';

class {{name.pascalCase()}}RepoImpl implements {{name.pascalCase()}}Repo {
  {{name.pascalCase()}}RepoImpl({
    required {{name.pascalCase()}}Remote remote,
    required {{name.pascalCase()}}ResponseToEntityGroupMapper responseToEntityGroupMapper,
  })  : _remote = remote,
        _responseToEntityGroupMapper = responseToEntityGroupMapper;

  final {{name.pascalCase()}}Remote _remote;
  final {{name.pascalCase()}}ResponseToEntityGroupMapper _responseToEntityGroupMapper;

  @override
  Future<Either<Exception, {{name.pascalCase()}}EntityGroup>> call(Uint8List imageBytes, String filename, {CancelToken? cancelToken}) async {
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
