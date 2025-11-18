import 'mapper.dart';
import '../model/image_caption_model.dart';

class ImageCaptionJsonToModelMapper
    extends MapperImpl<Object, ImageCaptionModel> {
  @override
  ImageCaptionModel performMap(Object from) {
    if (from is String) {
      return ImageCaptionModel.fromJson(from);
    }
    if (from is Map<String, dynamic>) {
      return ImageCaptionModel.fromMap(from);
    }
    throw ArgumentError(
        'Unsupported input for ImageCaptionJsonToModelMapper: ${from.runtimeType}');
  }
}
