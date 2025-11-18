import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vision_xai/features/image_caption/data/model/image_caption_response_dto.dart';
import 'package:vision_xai/features/image_caption/data/mapper/image_caption_response_to_entity_group_mapper.dart';
import 'package:vision_xai/features/image_caption/data/mapper/image_caption_json_to_model_mapper.dart';
import 'package:vision_xai/features/image_caption/data/mapper/image_caption_model_to_entity_mapper.dart';

void main() {
  test('parse sample response.json and map to entity', () {
    final file = File('response.json');
    expect(file.existsSync(), isTrue, reason: 'response.json must exist');

    final raw = file.readAsStringSync();
    final Map<String, dynamic> map = jsonDecode(raw) as Map<String, dynamic>;

    final dto = ImageCaptionResponseDto.fromMap(map);

    // Print a compact summary
    final normalized = dto.toMap();
    final attention = normalized['attention_image_bytes'];
    if (attention is String && attention.isNotEmpty) {
      try {
        final bytes = base64Decode(attention);
        debugPrint(
            'DTO normalized summary: attention_image_bytes: Binary, ${bytes.length} bytes');
      } catch (_) {
        // Not valid base64 — fallback to printing length of the string
        debugPrint(
            'DTO normalized summary: attention_image_bytes: String, length: ${attention.length}');
      }
      // Also print the other top-level keys for quick inspection
      debugPrint(
          'DTO keys: ${normalized.keys.where((k) => k != 'attention_image_bytes').toList()}');
    } else {
      debugPrint('DTO normalized keys: ${normalized.keys.toList()}');
    }

    final mapper = ImageCaptionResponseToEntityGroupMapper(
      jsonToModelMapper: ImageCaptionJsonToModelMapper(),
      modelToEntityMapper: ImageCaptionModelToEntityMapper(),
    );

    final group = mapper.map(dto);

    // Ensure we got a success or unknown (don't fail on unknown)
    group.when(
      success: (entity) {
        debugPrint('Mapped entity id: ${entity.id}');
        debugPrint('Attributes keys: ${entity.attributes.keys.toList()}');
      },
      unKnown: () => debugPrint('Mapped to unknown group'),
    );
  });
}
