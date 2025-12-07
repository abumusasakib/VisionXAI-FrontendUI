import 'package:freezed_annotation/freezed_annotation.dart';

import 'image_caption_entity.dart';

part 'image_caption_entity_group.freezed.dart';

@freezed
class ImageCaptionEntityGroup with _$ImageCaptionEntityGroup {
  const factory ImageCaptionEntityGroup.success(ImageCaptionEntity entity) =
      _Success;
  const factory ImageCaptionEntityGroup.unKnown() = _Unknown;
}

// Public helpers: provide a stable API surface that does not rely on the
// generated `when`/`map` extension methods. Tests and call sites can use
// `fold` or the convenience getters below to inspect the union safely.
extension ImageCaptionEntityGroupHelpers on ImageCaptionEntityGroup {
  /// Returns true when this is a success variant.
  bool get isSuccess => this is _Success;

  /// Returns true when this is an unknown variant.
  bool get isUnknown => this is _Unknown;

  /// Returns the success [ImageCaptionEntity] when present, otherwise null.
  ImageCaptionEntity? get successEntity =>
      this is _Success ? (this as _Success).entity : null;

  /// Fold utility which applies the appropriate callback for the active
  /// variant. This avoids depending on generated pattern-matching helpers.
  T fold<T>({
    required T Function(ImageCaptionEntity) success,
    required T Function() unKnown,
  }) {
    if (this is _Success) return success((this as _Success).entity);
    if (this is _Unknown) return unKnown();
    throw StateError('Unexpected ImageCaptionEntityGroup variant');
  }
}
