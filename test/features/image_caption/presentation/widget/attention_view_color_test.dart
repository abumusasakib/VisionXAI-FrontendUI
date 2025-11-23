import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vision_xai/features/image_caption/presentation/screen/widget/attention_view.dart';
import 'package:vision_xai/features/image_caption/domain/entity/image_caption_entity.dart';

void main() {
  testWidgets('AttentionView shows legend and markers with parsed colors', (tester) async {
    // tiny 1x1 PNG base64
    const b64 = 'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR4nGNgYAAAAAMAAWgmWQ0AAAAASUVORK5CYII=';
    final bytes = base64Decode(b64);

    final entity = ImageCaptionEntity(attributes: {
      'tokens': const ['tok1'],
      'token_scores': const [1.0],
      'attention_image_bytes': Uint8List.fromList(bytes),
      // topk: outer list per token, inner list of items as maps
      'attention_topk_items': const [
        [
          {'row': 0, 'col': 0, 'score': 1.0}
        ]
      ],
      'attention_colors': const ['#ff0000'],
    });

    await tester.pumpWidget(MaterialApp(home: Scaffold(body: AttentionView(entity: entity))));
    await tester.pumpAndSettle();

    // Legend should be present
    final legendFinder = find.byKey(const Key('attention-legend'));
    expect(legendFinder, findsOneWidget);

    // Tap the token chip to select it and show markers
    await tester.tap(find.text('tok1'));
    await tester.pumpAndSettle();

    // Marker should be rendered with key 'marker-0-0'
    final markerFinder = find.byKey(const Key('marker-0-0'));
    expect(markerFinder, findsOneWidget);

    final container = tester.widget<Container>(markerFinder);
    final BoxDecoration? decoration = container.decoration as BoxDecoration?;
    expect(decoration, isNotNull);
    final Color? markerColor = decoration!.color;
    // expected parsed color: #ff0000 with opacity approx 0.95
    const expectedBase = Color(0xffff0000);
    final expected = expectedBase.withOpacity(0.95);
    expect(markerColor, equals(expected));
  });
}
