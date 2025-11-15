import 'mapper.dart';
import '../model/image_caption_model.dart';

class ImageCaptionJsonToModelMapper
    implements Mapper<Object, ImageCaptionModel> {
  @override
  ImageCaptionModel map(Object tFrom) {
    if (tFrom is String) return ImageCaptionModel.fromJson(tFrom);
    if (tFrom is Map<String, dynamic>) return ImageCaptionModel.fromMap(tFrom);
    throw ArgumentError(
        'Unsupported input for ImageCaptionJsonToModelMapper: ${tFrom.runtimeType}');
  }
}
