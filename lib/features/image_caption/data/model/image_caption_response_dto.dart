import 'dart:convert';
import 'topk_item.dart';
import 'attention_grid.dart';

/// Lightweight DTO for the image-caption API response.
///
/// A custom `fromMap` factory so the DTO can accept multiple
/// server-side shapes: either `attention_topk`
/// as nested lists (list of list of [row,col,score]) or `attention_topk_items`
/// as nested lists of objects `{row,col,score}`. The server may also return
/// `attention_image` or `attention_image_bytes` (both base64 strings) — prefer
/// `attention_image_bytes` when present.
class ImageCaptionResponseDto {
  final String caption;
  final String? filename;
  final List<int>? tokenIds;
  final List<String>? tokens;
  final List<double>? tokenScores;
  final String? attentionImage; // legacy key
  final String? attentionImageBytes; // preferred key
  final List<double>? attentionMeans;
  final List<String>? attentionColors;
  final Map<String, String>? attentionColorMap;
  final List<List<TopKItem>>? attentionTopk;
  final AttentionGrid? attentionGrid;
  final Map<String, dynamic>? attentionShape;
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
    this.attentionImageBytes,
    this.attentionColors,
    this.attentionColorMap,
    this.attentionMeans,
    this.attentionGrid,
    this.attentionShape,
    this.attentionTopk,
    this.confidence,
    this.id,
    this.statusCode,
  });

  /// Create DTO from a raw map
  factory ImageCaptionResponseDto.fromMap(Map<String, dynamic> json) {
    // caption is required by our client; if missing, set empty string
    final caption = (json['caption'] ?? '') as String;

    // token ids / tokens / scores
    final tokenIds =
        (json['token_ids'] as List<dynamic>?)?.map((e) => e as int).toList();
    final tokens =
        (json['tokens'] as List<dynamic>?)?.map((e) => e as String).toList();
    final tokenScores = (json['token_scores'] as List<dynamic>?)
        ?.map((e) => (e as num).toDouble())
        .toList();

    // attention image: prefer `attention_image_bytes` if present
    final attentionImageBytes = json['attention_image_bytes'] as String? ??
        json['attention_image'] as String?;

    // attention means
    final attentionMeans = (json['attention_means'] as List<dynamic>?)
        ?.map((e) => (e as num).toDouble())
        .toList();

    // attention topk: either `attention_topk` (list of lists of lists)
    // or `attention_topk_items` (list of lists of maps {row,col,score})
    List<List<TopKItem>>? parsedTopk;
    final rawTopk = json['attention_topk'];
    final rawTopkItems = json['attention_topk_items'];

    if (rawTopk is List) {
      try {
        parsedTopk = (rawTopk)
            .map<List<TopKItem>>((outer) => (outer as List)
                .map<TopKItem>((entry) => TopKItem.fromList(entry as List))
                .toList())
            .toList();
      } catch (_) {
        parsedTopk = null;
      }
    } else if (rawTopkItems is List) {
      try {
        parsedTopk = (rawTopkItems)
            .map<List<TopKItem>>((outer) => (outer as List)
                .map<TopKItem>(
                    (entry) => TopKItem.fromMap(entry as Map<String, dynamic>))
                .toList())
            .toList();
      } catch (_) {
        parsedTopk = null;
      }
    }

    // Parse attention_grid either as list [rows,cols] or as map {rows,cols}
    AttentionGrid? grid;
    final rawGrid = json['attention_grid'];
    if (rawGrid is List) {
      try {
        grid = AttentionGrid.fromList(rawGrid);
      } catch (_) {
        grid = null;
      }
    } else if (rawGrid is Map) {
      try {
        grid = AttentionGrid.fromMap(Map<String, dynamic>.from(rawGrid));
      } catch (_) {
        grid = null;
      }
    }

    return ImageCaptionResponseDto(
      caption: caption,
      filename: json['filename'] as String?,
      tokenIds: tokenIds,
      tokens: tokens,
      tokenScores: tokenScores,
      attentionImage: json['attention_image'] as String?,
      attentionImageBytes: attentionImageBytes,
      attentionColors: (json['attention_colors'] as List<dynamic>?)
        ?.map((e) => e as String)
        .toList(),
      attentionColorMap: (json['attention_color_map'] is Map)
        ? Map<String, String>.from(json['attention_color_map'] as Map)
        : null,
      attentionMeans: attentionMeans,
      attentionGrid: grid,
      attentionShape: (json['attention_shape'] is Map)
          ? Map<String, dynamic>.from(json['attention_shape'] as Map)
          : null,
      attentionTopk: parsedTopk,
      confidence: (json['confidence'] as num?)?.toDouble(),
      id: json['id'] as String?,
      statusCode: (json['statusCode'] as num?)?.toInt(),
    );
  }

  /// Convenience constructor used that expect
  /// a `fromJson(String)` factory. It simply decodes the JSON string and
  /// delegates to `fromMap`.
  factory ImageCaptionResponseDto.fromJson(dynamic source) {
    if (source is String) {
      final Map<String, dynamic> map =
          jsonDecode(source) as Map<String, dynamic>;
      return ImageCaptionResponseDto.fromMap(map);
    }

    if (source is Map<String, dynamic>) {
      return ImageCaptionResponseDto.fromMap(source);
    }

    // Accept also Map<String, Object> or similar
    if (source is Map) {
      return ImageCaptionResponseDto.fromMap(Map<String, dynamic>.from(source));
    }

    throw ArgumentError.value(source, 'source', 'Expected String or Map');
  }

  Map<String, dynamic> toMap() => {
        'caption': caption,
        'filename': filename,
        'token_ids': tokenIds,
        'tokens': tokens,
        'token_scores': tokenScores,
        'attention_image': attentionImage,
        'attention_image_bytes': attentionImageBytes,
        'attention_colors': attentionColors,
        'attention_color_map': attentionColorMap,
        'attention_grid': attentionGrid?.toList(),
        'attention_shape': attentionShape,
        'attention_means': attentionMeans,
        'attention_topk': attentionTopk
            ?.map((outer) => outer.map((item) => item.toList()).toList())
            .toList(),
        'confidence': confidence,
        'id': id,
        'statusCode': statusCode,
      };
}
