import 'package:json_annotation/json_annotation.dart';
import 'topk_item.dart';

part 'image_caption_response_dto.g.dart';

@JsonSerializable()
class ImageCaptionResponseDto {
  final String caption;
  final String? filename;
  @JsonKey(name: 'token_ids')
  final List<int>? tokenIds;
  final List<String>? tokens;
  @JsonKey(name: 'token_scores')
  final List<double>? tokenScores;
  @JsonKey(name: 'attention_image')
  final String? attentionImage;
  @JsonKey(name: 'attention_means')
  final List<double>? attentionMeans;
  @JsonKey(name: 'attention_topk')
  final List<List<TopKItem>>? attentionTopk;
  final double? confidence;
  final String? id;
  final int? statusCode;

  ImageCaptionResponseDto({
    required this.caption,
    this.filename,
    this.tokenIds,
    this.tokens,
    this.tokenScores,
    this.attentionImage,
    this.attentionMeans,
    this.attentionTopk,
    this.confidence,
    this.id,
    this.statusCode,
  });

  factory ImageCaptionResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ImageCaptionResponseDtoFromJson(json);
  Map<String, dynamic> toJson() => _$ImageCaptionResponseDtoToJson(this);
}
