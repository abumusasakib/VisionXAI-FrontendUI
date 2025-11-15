import 'mapper.dart';

import '../../domain/entity/image_caption_entity.dart';
import '../model/image_caption_model.dart';

class ImageCaptionModelToEntityMapper
    implements Mapper<ImageCaptionModel, ImageCaptionEntity> {
  @override
  ImageCaptionEntity map(ImageCaptionModel model) {
    return ImageCaptionEntity(id: model.id, attributes: model.attributes);
  }
}
