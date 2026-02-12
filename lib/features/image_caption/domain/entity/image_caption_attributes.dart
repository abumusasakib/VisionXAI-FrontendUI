import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';
import '../../data/model/attention_grid.dart';
import '../../data/model/topk_item.dart';

part 'image_caption_attributes.freezed.dart';
part 'image_caption_attributes.g.dart';

@freezed
class ImageCaptionAttributes with _$ImageCaptionAttributes {
  const factory ImageCaptionAttributes({
    required String caption,
    String? filename,
    List<int>? tokenIds,
    List<String>? tokens,
    List<double>? tokenScores,
    String? attentionImage,
    @JsonKey(includeFromJson: false, includeToJson: false)
    Uint8List? attentionImageBytes,
    List<double>? attentionMeans,
    List<String>? attentionColors,
    Map<String, String>? attentionColorMap,
    List<List<TopKItem>>? attentionTopk,
    @JsonKey(name: 'attention_topk_items')
    List<List<TopKItem>>? attentionTopkItems,
    AttentionGrid? attentionGrid,
    Map<String, dynamic>? attentionShape,
    @JsonKey(includeFromJson: false, includeToJson: false)
    AttentionGrid? attentionGridTyped,
    @JsonKey(includeFromJson: false, includeToJson: false)
    List<int>? attentionGridList,
    @JsonKey(includeFromJson: false, includeToJson: false)
    Map<String, int>? attentionGridMap,
    double? confidence,
  }) = _ImageCaptionAttributes;

  factory ImageCaptionAttributes.fromJson(Map<String, dynamic> json) =>
      _$ImageCaptionAttributesFromJson(json);
}
