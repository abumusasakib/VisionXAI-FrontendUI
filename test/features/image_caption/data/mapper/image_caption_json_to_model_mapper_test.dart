import 'package:flutter_test/flutter_test.dart';

import 'package:vision_xai/features/image_caption/data/mapper/image_caption_json_to_model_mapper.dart';
import 'package:vision_xai/features/image_caption/data/model/image_caption_model.dart';

void main() {
  group('ImageCaptionJsonToModelMapper', () {
    final mapper = ImageCaptionJsonToModelMapper();

    test('maps Map<String,dynamic> to ImageCaptionModel', () {
      final map = {'id': '123', 'caption': 'a test'};
      final model = mapper.map(map);
      expect(model, isA<ImageCaptionModel>());
      expect(model.id, '123');
      expect(model.attributes['caption'], 'a test');
    });

    test('maps JSON string to ImageCaptionModel', () {
      const json = '{"id":"456","caption":"from json"}';
      final model = mapper.map(json);
      expect(model.id, '456');
      expect(model.attributes['caption'], 'from json');
    });
  });
}
