import 'package:freezed_annotation/freezed_annotation.dart';

import 'image_caption_entity.dart';

part 'image_caption_entity_group.freezed.dart';

@freezed
class ImageCaptionEntityGroup with _$ImageCaptionEntityGroup {
  const factory ImageCaptionEntityGroup.success(ImageCaptionEntity entity) =
      _Success;
  const factory ImageCaptionEntityGroup.unKnown() = _Unknown;
}
