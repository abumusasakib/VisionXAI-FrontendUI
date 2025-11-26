import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:vision_xai/features/image_caption/data/model/image_caption_response_dto.dart';
import 'package:vision_xai/features/image_caption/data/model/topk_item.dart';
import 'package:vision_xai/features/image_caption/data/model/attention_grid.dart';

void main() {
  group('ImageCaptionResponseDto.fromMap', () {
    test('parses attention_topk (list-of-lists) and attention_grid list', () {
      final raw = {
        'caption': 'একটি সুন্দর ছবি',
        'filename': 'img.jpg',
        'token_ids': [20021, 16452],
        'tokens': ['একটি', 'সুন্দর'],
        'token_scores': [0.1, 0.2],
        'attention_image_bytes': 'B64DATA',
        'attention_topk': [
          [
            [0, 1, 0.9],
            [1, 2, 0.8]
          ],
          [
            [0, 0, 0.7]
          ]
        ],
        'attention_grid': [8, 8],
        'attention_means': [0.5, 0.6],
        'attention_colors': ['#111111', '#222222'],
        'attention_color_map': {'একটি': '#111111', 'সুন্দর': '#222222'},
        'confidence': 0.95,
        'id': 'abc',
        'statusCode': 200,
      };

      final dto = ImageCaptionResponseDto.fromMap(raw);

      expect(dto.caption, 'একটি সুন্দর ছবি');
      expect(dto.filename, 'img.jpg');
      expect(dto.tokenIds, [20021, 16452]);
      expect(dto.tokens, ['একটি', 'সুন্দর']);
      expect(dto.tokenScores, [0.1, 0.2]);
      expect(dto.attentionImageBytes, 'B64DATA');
      expect(dto.attentionMeans, [0.5, 0.6]);
      expect(dto.attentionColors, ['#111111', '#222222']);
      expect(dto.attentionColorMap, {'একটি': '#111111', 'সুন্দর': '#222222'});
      expect(dto.confidence, closeTo(0.95, 1e-9));
      expect(dto.id, 'abc');
      expect(dto.statusCode, 200);

      // topk parsed
      expect(dto.attentionTopk, isNotNull);
      expect(dto.attentionTopk!.length, 2);
      final firstOuter = dto.attentionTopk![0];
      expect(firstOuter.length, 2);
      expect(firstOuter[0], isA<TopKItem>());
      expect(firstOuter[0].row, 0);
      expect(firstOuter[0].col, 1);
      expect(firstOuter[0].score, closeTo(0.9, 1e-9));

      // grid parsed
      expect(dto.attentionGrid, isA<AttentionGrid>());
      expect(dto.attentionGrid!.rows, 8);
      expect(dto.attentionGrid!.cols, 8);
    });

    test('parses attention_topk_items (maps) and attention_image fallback', () {
      final raw = {
        'caption': 'fallback',
        'attention_image': 'OLD_B64',
        'attention_topk_items': [
          [
            {'row': 2, 'col': 3, 'score': 0.55}
          ]
        ],
        'attention_grid': {'rows': 4, 'cols': 5},
      };

      final dto = ImageCaptionResponseDto.fromMap(raw);
      // caption
      expect(dto.caption, 'fallback');
      // attention image preference: since attention_image_bytes absent, should use attention_image
      expect(dto.attentionImageBytes, 'OLD_B64');
      // topk items
      expect(dto.attentionTopk, isNotNull);
      expect(dto.attentionTopk!.length, 1);
      final item = dto.attentionTopk![0][0];
      expect(item.row, 2);
      expect(item.col, 3);
      expect(item.score, closeTo(0.55, 1e-9));

      // grid map parsed
      expect(dto.attentionGrid, isA<AttentionGrid>());
      expect(dto.attentionGrid!.rows, 4);
      expect(dto.attentionGrid!.cols, 5);
    });

    test('fromJson accepts JSON string and map', () {
      final map = {'caption': 'json', 'tokens': ['a', 'b']};
      final jsonStr = jsonEncode(map);

      final dtoFromJson = ImageCaptionResponseDto.fromJson(jsonStr);
      expect(dtoFromJson.caption, 'json');
      expect(dtoFromJson.tokens, ['a', 'b']);

      final dtoFromMap = ImageCaptionResponseDto.fromJson(map);
      expect(dtoFromMap.caption, 'json');
    });

    test('handles missing caption by using empty string', () {
      final dto = ImageCaptionResponseDto.fromMap({});
      expect(dto.caption, '');
    });

    test('gracefully handles malformed attention_topk and topk_items', () {
      // malformed nested lists (inner entries not length 3)
      final raw1 = {
        'attention_topk': [
          [
            [0, 1], // missing score
          ]
        ]
      };

      final dto1 = ImageCaptionResponseDto.fromMap(raw1);
      // parsing should not throw and topk becomes null
      expect(dto1.attentionTopk, isNull);

      // malformed topk_items maps (missing keys)
      final raw2 = {
        'attention_topk_items': [
          [
            {'r': 0, 'c': 1} // wrong keys
          ]
        ]
      };

      final dto2 = ImageCaptionResponseDto.fromMap(raw2);
      expect(dto2.attentionTopk, isNull);
    });

    test('gracefully handles malformed attention_grid', () {
      final raw = {'attention_grid': ['not', 'ints']};
      final dto = ImageCaptionResponseDto.fromMap(raw);
      expect(dto.attentionGrid, isNull);
    });
  });
}
