import 'package:dio/dio.dart';

import '../../data/mapper/image_caption_json_to_model_mapper.dart';
import '../../data/mapper/image_caption_model_to_entity_mapper.dart';
import '../../data/mapper/image_caption_response_to_entity_group_mapper.dart';
import '../../data/datasource/remote/image_caption_remote.dart';
import '../../data/repository/image_caption_repo_impl.dart';
import '../../domain/use_case/image_caption_uc.dart';

/// Simple helper that wires the concrete data-layer implementations and
/// returns a ready-to-use `ImageCaptionUC` instance.
///
/// Use this in data layer so apps can call it from DI/bootstrap code.
ImageCaptionUC createImageCaptionUseCase(Dio dio, {String? baseUrl}) {
  final remote = ImageCaptionRemote(dio, baseUrl: baseUrl);
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

  return ImageCaptionUC(repo);
}
