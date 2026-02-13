import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:vision_xai/features/image_caption/data/model/image_caption_response_dto.dart';
import 'package:vision_xai/features/image_caption/data/mapper/image_caption_response_to_entity_group_mapper.dart';
import 'package:vision_xai/features/image_caption/data/mapper/image_caption_json_to_model_mapper.dart';
import 'package:vision_xai/features/image_caption/data/mapper/image_caption_model_to_entity_mapper.dart';
import 'package:vision_xai/features/image_caption/data/model/topk_item.dart';
import 'package:vision_xai/features/image_caption/domain/entity/image_caption_entity.dart';
import 'package:vision_xai/features/image_caption/domain/entity/image_caption_entity_group.dart';

void main() {
  group('ImageCaption DTO and Mapper', () {
    test('DTO parses sample API response', () {
      final sample = {
        'filename': 'image.jpg',
        'caption': 'একটি সুন্দর ছবি',
        'token_ids': [20021, 16452, 15838],
        'tokens': ['একটি', 'সুন্দর', 'ছবি'],
        'token_scores': [0.0000478, 0.0000478, 0.0000478],
        'attention_image': base64Encode([1, 2, 3, 4]),
        'attention_means': [0.66, 0.47, 0.47],
        'attention_topk': [
          [
            [6, 2, 0.999992],
            [7, 6, 0.985347],
          ],
          [
            [0, 6, 0.999996],
            [0, 7, 0.842281],
          ],
          [],
        ],
      };

      final dto = ImageCaptionResponseDto.fromJson(sample);

      expect(dto.filename, 'image.jpg');
      expect(dto.caption, 'একটি সুন্দর ছবি');
      expect(dto.tokens, isNotNull);
      expect(dto.tokenIds, [20021, 16452, 15838]);
      expect(dto.attentionImage, isNotNull);
      expect(dto.attentionMeans, hasLength(3));
      expect(dto.attentionTopk, hasLength(3));
      expect(dto.attentionTopk![0][0], isA<TopKItem>());
      expect(dto.attentionTopk![0][0].row, 6);
      expect(dto.attentionTopk![0][0].col, 2);
    });

    test('Mapper maps DTO to EntityGroup with expected attributes', () {
      final sample = {
        'filename': 'image.jpg',
        'caption': 'একটি সুন্দর ছবি',
        'token_ids': [20021, 16452, 15838],
        'tokens': ['একটি', 'সুন্দর', 'ছবি'],
        'token_scores': [0.0000478, 0.0000478, 0.0000478],
        'attention_image': base64Encode([1, 2, 3, 4]),
        'attention_means': [0.66, 0.47, 0.47],
        'attention_topk': [
          [
            [6, 2, 0.999992],
            [7, 6, 0.985347],
          ],
          [
            [0, 6, 0.999996],
            [0, 7, 0.842281],
          ],
          [],
        ],
      };

      final dto = ImageCaptionResponseDto.fromJson(sample);

      final jsonToModel = ImageCaptionJsonToModelMapper();
      final modelToEntity = ImageCaptionModelToEntityMapper();
      final mapper = ImageCaptionResponseToEntityGroupMapper(
        jsonToModelMapper: jsonToModel,
        modelToEntityMapper: modelToEntity,
      );

      final group = mapper.map(dto);
      // Use `dynamic` access to avoid relying on generated `when`/`map`.
      final dyn = group as dynamic;
      if (dyn.entity != null) {
        final ImageCaptionEntity entity = dyn.entity as ImageCaptionEntity;
        expect(entity.attributes.caption, 'একটি সুন্দর ছবি');
        expect(entity.attributes.tokens, ['একটি', 'সুন্দর', 'ছবি']);
        // entity is enriched with decoded bytes and topk items
        expect(entity.attributes.attentionImageBytes, isNotNull);
        expect(entity.attributes.attentionTopkItems, isNotNull);
      } else {
        fail('Expected success group');
      }
    });
    test('Mapper maps attention colors', () {
      final sample = {
        'caption': 'test',
        'attention_colors': ['#FF0000', '#00FF00'],
        'attention_color_map': {'token1': '#FF0000', 'token2': '#00FF00'},
      };

      final dto = ImageCaptionResponseDto.fromJson(sample);

      final jsonToModel = ImageCaptionJsonToModelMapper();
      final modelToEntity = ImageCaptionModelToEntityMapper();
      final mapper = ImageCaptionResponseToEntityGroupMapper(
        jsonToModelMapper: jsonToModel,
        modelToEntityMapper: modelToEntity,
      );

      final group = mapper.map(dto);

      // Use helper if available, or cast
      // The entity check logic in previous test used dynamic cast, let's stick to that
      // or use the .success convenience method if the entity group suggests it.
      // But let's check the file content again...
      // It has `ImageCaptionEntityGroup.success(entity)`

      group.fold(
        success: (entity) {
          expect(entity.attributes.attentionColors, ['#FF0000', '#00FF00']);
          expect(entity.attributes.attentionColorMap, {
            'token1': '#FF0000',
            'token2': '#00FF00',
          });
        },
        unKnown: () => fail('Expected success'),
      );
    });
    test('Mapper maps token scores', () {
      final sample = {
        'caption': 'test',
        'token_scores': [0.1, 0.2, 0.3],
        'attention_means': [0.4, 0.5, 0.6],
      };

      final dto = ImageCaptionResponseDto.fromJson(sample);

      final jsonToModel = ImageCaptionJsonToModelMapper();
      final modelToEntity = ImageCaptionModelToEntityMapper();
      final mapper = ImageCaptionResponseToEntityGroupMapper(
        jsonToModelMapper: jsonToModel,
        modelToEntityMapper: modelToEntity,
      );

      final group = mapper.map(dto);

      group.fold(
        success: (entity) {
          expect(entity.attributes.tokenScores, [0.1, 0.2, 0.3]);
          expect(entity.attributes.attentionMeans, [0.4, 0.5, 0.6]);
        },
        unKnown: () => fail('Expected success'),
      );
    });
    test('Mapper maps attention shape', () {
      final sample = {
        'caption': 'test',
        'attention_shape': {'rows': 8, 'cols': 8},
      };

      final dto = ImageCaptionResponseDto.fromJson(sample);

      final jsonToModel = ImageCaptionJsonToModelMapper();
      final modelToEntity = ImageCaptionModelToEntityMapper();
      final mapper = ImageCaptionResponseToEntityGroupMapper(
        jsonToModelMapper: jsonToModel,
        modelToEntityMapper: modelToEntity,
      );

      final group = mapper.map(dto);

      group.fold(
        success: (entity) {
          expect(entity.attributes.attentionShape, {'rows': 8, 'cols': 8});
        },
        unKnown: () => fail('Expected success'),
      );
    });
  });
}
