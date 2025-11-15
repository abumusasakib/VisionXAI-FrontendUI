import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';

import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:vision_xai/features/image_caption/data/datasource/remote/image_caption_remote.dart';
import 'package:vision_xai/features/image_caption/data/model/image_caption_response_dto.dart';
import 'package:vision_xai/features/image_caption/data/mapper/image_caption_json_to_model_mapper.dart';
import 'package:vision_xai/features/image_caption/data/mapper/image_caption_model_to_entity_mapper.dart';
import 'package:vision_xai/features/image_caption/data/mapper/image_caption_response_to_entity_group_mapper.dart';
import 'package:vision_xai/features/image_caption/data/repository/image_caption_repo_impl.dart';

class FakeRemote extends ImageCaptionRemote {
  final ImageCaptionResponseDto dto;
  FakeRemote(this.dto) : super(Dio());

  @override
  Future<ImageCaptionResponseDto> captionImage(MultipartFile image,
      {CancelToken? cancelToken}) async {
    // Ignore image in fake; return the preconfigured dto.
    return dto;
  }
}

class FakeRemoteError extends ImageCaptionRemote {
  FakeRemoteError() : super(Dio());

  @override
  Future<ImageCaptionResponseDto> captionImage(MultipartFile image,
      {CancelToken? cancelToken}) async {
    // Simulate server error by throwing
    throw Exception('server error');
  }
}

void main() {
  test('repo maps remote dto to entity group success', () async {
    final dto = ImageCaptionResponseDto(
      caption: 'a cat',
      id: '1',
      statusCode: 200,
    );

    final remote = FakeRemote(dto);
    final jsonToModel = ImageCaptionJsonToModelMapper();
    final modelToEntity = ImageCaptionModelToEntityMapper();
    final responseMapper = ImageCaptionResponseToEntityGroupMapper(
      jsonToModelMapper: jsonToModel,
      modelToEntityMapper: modelToEntity,
    );

    final repo = ImageCaptionRepoImpl(
      remote: remote,
      responseToEntityGroupMapper: responseMapper,
    );

    final bytes = Uint8List.fromList([1, 2, 3]);
    final result = await repo.call(bytes, 'image.png');
    expect(result, isA<Right>());
    result.fold((l) => fail('expected right'), (r) {
      r.when(
        success: (entity) {
          expect(entity.id, '1');
          expect(entity.attributes['caption'], 'a cat');
        },
        unKnown: () => fail('expected success'),
      );
    });
  });

  test('repo returns Left when remote throws', () async {
    final remote = FakeRemoteError();
    final jsonToModel = ImageCaptionJsonToModelMapper();
    final modelToEntity = ImageCaptionModelToEntityMapper();
    final responseMapper = ImageCaptionResponseToEntityGroupMapper(
      jsonToModelMapper: jsonToModel,
      modelToEntityMapper: modelToEntity,
    );

    final repo = ImageCaptionRepoImpl(
      remote: remote,
      responseToEntityGroupMapper: responseMapper,
    );

    final bytes = Uint8List.fromList([0]);
    final result = await repo.call(bytes, 'img.png');
    expect(result.isLeft(), true);
  });
}
