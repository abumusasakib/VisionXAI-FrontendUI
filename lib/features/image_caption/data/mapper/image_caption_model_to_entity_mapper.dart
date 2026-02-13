import 'mapper.dart';

import '../../domain/entity/image_caption_entity.dart';
import '../../domain/entity/image_caption_attributes.dart';
import '../model/image_caption_model.dart';

class ImageCaptionModelToEntityMapper
    extends MapperImpl<ImageCaptionModel, ImageCaptionEntity> {
  @override
  ImageCaptionEntity performMap(ImageCaptionModel from) {
    return ImageCaptionEntity(
        id: from.id,
        attributes: ImageCaptionAttributes.fromJson(from.attributes));
  }
}
