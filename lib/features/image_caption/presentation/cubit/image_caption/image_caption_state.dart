part of 'image_caption_cubit.dart';

@freezed
class ImageCaptionState with _$ImageCaptionState {
  const factory ImageCaptionState.initial() = _Initial;
  const factory ImageCaptionState.loading() = _Loading;
  const factory ImageCaptionState.loaded(ImageCaptionEntity entity) = _Loaded;
  const factory ImageCaptionState.failure(Object error) = _Failure;
  const factory ImageCaptionState.unKnown() = _Unknown;
}
