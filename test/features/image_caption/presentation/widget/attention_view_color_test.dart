import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vision_xai/features/image_caption/presentation/screen/widget/attention_view.dart';
import 'package:vision_xai/features/image_caption/domain/entity/image_caption_entity.dart';

void main() {
  testWidgets('AttentionView shows legend and markers with parsed colors',
      (tester) async {
    // tiny 1x1 PNG base64
    const b64 =
        'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR4nGNgYAAAAAMAAWgmWQ0AAAAASUVORK5CYII=';
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

    await tester.pumpWidget(
        MaterialApp(home: Scaffold(body: AttentionView(entity: entity))));
    await tester.pumpAndSettle();

    // Legend should be present
    final legendFinder = find.byKey(const Key('attention-legend'));
    expect(legendFinder, findsOneWidget);

    // Tap the token ChoiceChip to select it and show markers
    await tester.tap(find.widgetWithText(ChoiceChip, 'tok1'));
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

  testWidgets('AttentionView supports attention_color_map and multiple tokens',
      (tester) async {
    // tiny 1x1 PNG base64
    const b64 =
        'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR4nGNgYAAAAAMAAWgmWQ0AAAAASUVORK5CYII=';
    final bytes = base64Decode(b64);

    final entity = ImageCaptionEntity(attributes: {
      'tokens': const ['a', 'b'],
      'token_scores': const [1.0, 0.8],
      'attention_image_bytes': Uint8List.fromList(bytes),
      'attention_topk_items': const [
        [
          {'row': 0, 'col': 0, 'score': 1.0}
        ],
        [
          {'row': 0, 'col': 1, 'score': 0.8}
        ]
      ],
      'attention_color_map': const {'a': '#00ff00', 'b': '#0000ff'},
    });

    await tester.pumpWidget(
        MaterialApp(home: Scaffold(body: AttentionView(entity: entity))));
    await tester.pumpAndSettle();

    // Legend should contain both tokens
    expect(find.byKey(const Key('attention-legend')), findsOneWidget);
    expect(find.text('a'), findsWidgets);
    expect(find.text('b'), findsWidgets);

    // Select token 'b' (the ChoiceChip) and ensure its marker is rendered and colored correctly
    await tester.tap(find.widgetWithText(ChoiceChip, 'b'));
    await tester.pumpAndSettle();

    final markerFinder = find.byKey(const Key('marker-1-0'));
    expect(markerFinder, findsOneWidget);

    final container = tester.widget<Container>(markerFinder);
    final BoxDecoration? decoration = container.decoration as BoxDecoration?;
    expect(decoration, isNotNull);
    final Color? markerColor = decoration!.color;

    // expected base color for 'b' is #0000ff
    const expectedBase = Color(0xff0000ff);
    // score 0.8 -> opacity = 0.35 + 0.8*0.6 = 0.83
    final expected = expectedBase.withOpacity(0.35 + 0.8 * 0.6);
    expect(markerColor, equals(expected));
  });

  testWidgets('Color parsing handles 6/8-length/no-hash/invalid and fallbacks',
      (tester) async {
    const b64 =
        'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR4nGNgYAAAAAMAAWgmWQ0AAAAASUVORK5CYII=';
    final bytes = base64Decode(b64);

    final entity = ImageCaptionEntity(attributes: {
      'tokens': const ['t0', 't1', 't2', 't3'],
      'token_scores': const [1.0, 0.5, 0.2, 0.9],
      'attention_image_bytes': Uint8List.fromList(bytes),
      'attention_topk_items': const [
        [
          {'row': 0, 'col': 0, 'score': 1.0}
        ],
        [
          {'row': 0, 'col': 1, 'score': 0.5}
        ],
        [
          {'row': 0, 'col': 2, 'score': 0.2}
        ],
        [
          {'row': 0, 'col': 3, 'score': 0.9}
        ]
      ],
      // various formats
      'attention_colors': const ['ff0000', '#80ff0000', 'BADHEX', '00ff00'],
    });

    await tester.pumpWidget(
        MaterialApp(home: Scaffold(body: AttentionView(entity: entity))));
    await tester.pumpAndSettle();

    final legendFinder = find.byKey(const Key('attention-legend'));
    expect(legendFinder, findsOneWidget);

    // Expected parsed colors
    const expected0 = Color(0xffff0000); // 'ff0000' -> 0xffff0000
    const expected1 = Color(0x80ff0000); // '#80ff0000' -> 0x80ff0000
    const expected2 = Colors.grey; // 'BADHEX' -> fallback
    const expected3 = Color(0xff00ff00); // '00ff00' -> 0xff00ff00

    WidgetPredicate matchColor(Color c) => (Widget w) {
          if (w is Container) {
            final dec = w.decoration;
            if (dec is BoxDecoration) {
              return dec.color == c;
            }
          }
          return false;
        };

    expect(find.descendant(of: legendFinder, matching: find.byWidgetPredicate(matchColor(expected0))), findsWidgets);
    expect(find.descendant(of: legendFinder, matching: find.byWidgetPredicate(matchColor(expected1))), findsWidgets);
    expect(find.descendant(of: legendFinder, matching: find.byWidgetPredicate(matchColor(expected2))), findsWidgets);
    expect(find.descendant(of: legendFinder, matching: find.byWidgetPredicate(matchColor(expected3))), findsWidgets);
  });

  testWidgets('Missing colors fallback to grey for tokens beyond list length',
      (tester) async {
    const b64 =
        'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR4nGNgYAAAAAMAAWgmWQ0AAAAASUVORK5CYII=';
    final bytes = base64Decode(b64);

    final entity = ImageCaptionEntity(attributes: {
      'tokens': const ['x', 'y', 'z'],
      'token_scores': const [1.0, 1.0, 1.0],
      'attention_image_bytes': Uint8List.fromList(bytes),
      'attention_topk_items': const [
        [
          {'row': 0, 'col': 0, 'score': 1.0}
        ],
        [
          {'row': 0, 'col': 1, 'score': 1.0}
        ],
        [
          {'row': 0, 'col': 2, 'score': 1.0}
        ]
      ],
      'attention_colors': const ['#123456'],
    });

    await tester.pumpWidget(
        MaterialApp(home: Scaffold(body: AttentionView(entity: entity))));
    await tester.pumpAndSettle();

    final legendFinder = find.byKey(const Key('attention-legend'));
    expect(legendFinder, findsOneWidget);

    // Only one provided color, other tokens should show grey swatches
    final greyFinder = find.descendant(
        of: legendFinder,
        matching: find.byWidgetPredicate((w) {
          if (w is Container) {
            final dec = w.decoration;
            if (dec is BoxDecoration) return dec.color == Colors.grey;
          }
          return false;
        }));
    expect(greyFinder, findsWidgets);
  });
}
