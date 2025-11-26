import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vision_xai/features/image_caption/data/model/topk_item.dart';
import 'package:vision_xai/features/image_caption/domain/entity/image_caption_entity.dart';
import 'package:vision_xai/features/image_caption/presentation/screen/widget/attention_view.dart';

void main() {
  testWidgets(
      'AttentionView renders image, tokens and markers when token selected',
      (tester) async {
    // 1x1 transparent PNG
    const base64Png =
        'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR4nGNgYAAAAAMAASsJTYQAAAAASUVORK5CYII=';
    final Uint8List imageBytes = base64Decode(base64Png);

    final tokens = ['hello', 'world'];
    final tokenScores = [0.5, 0.1];
    final topk = [
      [const TopKItem(row: 0, col: 0, score: 0.8)],
      [const TopKItem(row: 0, col: 0, score: 0.2)],
    ];

    final entity = ImageCaptionEntity(attributes: {
      'attention_image_bytes': imageBytes,
      'tokens': tokens,
      'token_scores': tokenScores,
      'attention_topk_items': topk,
    });

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Center(
          child: SizedBox(
              width: 400, height: 400, child: AttentionView(entity: entity)),
        ),
      ),
    ));

    // Image should be present
    expect(find.byType(Image), findsOneWidget);

    // Tokens should be present as ChoiceChips (we check by label text)
    expect(find.text('hello'), findsOneWidget);
    expect(find.text('world'), findsOneWidget);

    // Initially no markers (no token selected)
    expect(find.byKey(const Key('marker-0-0')), findsNothing);

    // Tap the first token chip
    final chipFinder = find.widgetWithText(ChoiceChip, 'hello');
    expect(chipFinder, findsOneWidget);
    final center = tester.getCenter(chipFinder);
    await tester.tapAt(center);
    await tester.pumpAndSettle();

    // Now marker for token 0 should appear
    expect(find.byKey(const Key('marker-0-0')), findsOneWidget);
  });

  testWidgets('AttentionView shows multiple markers per token', (tester) async {
    const base64Png =
        'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR4nGNgYAAAAAMAASsJTYQAAAAASUVORK5CYII=';
    final Uint8List imageBytes = base64Decode(base64Png);

    final tokens = ['a'];
    final tokenScores = [0.9];
    final topk = [
      [
        const TopKItem(row: 0, col: 0, score: 0.9),
        const TopKItem(row: 1, col: 1, score: 0.6),
      ],
    ];

    final entity = ImageCaptionEntity(attributes: {
      'attention_image_bytes': imageBytes,
      'tokens': tokens,
      'token_scores': tokenScores,
      'attention_topk_items': topk,
    });

    await tester.pumpWidget(MaterialApp(
        home: Scaffold(
            body: Center(
                child: SizedBox(
                    width: 400,
                    height: 300,
                    child: AttentionView(entity: entity))))));
    // tap token
    final fA = find.text('a');
    final cA = tester.getCenter(fA);
    await tester.tapAt(cA);
    await tester.pumpAndSettle();

    // both markers should be present
    expect(find.byKey(const Key('marker-0-0')), findsOneWidget);
    expect(find.byKey(const Key('marker-0-1')), findsOneWidget);
  });

  testWidgets('AttentionView respects grid override and marker sizing/opacity',
      (tester) async {
    const base64Png =
        'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR4nGNgYAAAAAMAASsJTYQAAAAASUVORK5CYII=';
    final Uint8List imageBytes = base64Decode(base64Png);

    final tokens = ['t'];
    final tokenScores = [0.0];
    // two items with different scores to compare size/opacity
    final topk = [
      [
        const TopKItem(row: 0, col: 0, score: 0.1),
        const TopKItem(row: 0, col: 1, score: 0.9),
      ],
    ];

    final entity = ImageCaptionEntity(attributes: {
      'attention_image_bytes': imageBytes,
      'tokens': tokens,
      'token_scores': tokenScores,
      // Provide explicit grid override
      'attention_grid': const [1, 2],
      'attention_topk_items': topk,
    });

    await tester.pumpWidget(MaterialApp(
        home: Scaffold(
            body: Center(
                child: SizedBox(
                    width: 400,
                    height: 300,
                    child: AttentionView(entity: entity))))));
    await tester.pumpAndSettle();

    // select token
    final fT = find.text('t');
    final cT = tester.getCenter(fT);
    await tester.tapAt(cT);
    await tester.pumpAndSettle();

    final f0 = find.byKey(const Key('marker-0-0'));
    final f1 = find.byKey(const Key('marker-0-1'));
    expect(f0, findsOneWidget);
    expect(f1, findsOneWidget);

    // Check sizes: marker for score 0.9 should be larger than for 0.1
    final container0 = tester.widget<Container>(f0);
    final container1 = tester.widget<Container>(f1);
    final size0 = tester.getSize(f0);
    final size1 = tester.getSize(f1);
    expect(size1.width, greaterThan(size0.width));

    // Check opacity from BoxDecoration color
    final dec0 = container0.decoration as BoxDecoration;
    final dec1 = container1.decoration as BoxDecoration;
    final op0 = dec0.color?.opacity ?? 0.0;
    final op1 = dec1.color?.opacity ?? 0.0;
    expect(op1, greaterThan(op0));
  });

  testWidgets('AttentionView marker exact position math (grid override)',
      (tester) async {
    const base64Png =
        'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR4nGNgYAAAAAMAASsJTYQAAAAASUVORK5CYII=';
    final Uint8List imageBytes = base64Decode(base64Png);

    final tokens = ['p'];
    final tokenScores = [1.0];
    final topk = [
      [const TopKItem(row: 1, col: 0, score: 1.0)],
    ];

    final entity = ImageCaptionEntity(attributes: {
      'attention_image_bytes': imageBytes,
      'tokens': tokens,
      'token_scores': tokenScores,
      // explicit grid override 2x2
      'attention_grid': const [2, 2],
      'attention_topk_items': topk,
    });

    await tester.pumpWidget(MaterialApp(
        home: Scaffold(
            body: Center(
                child: SizedBox(
                    width: 360,
                    height: 240,
                    child: AttentionView(entity: entity))))));
    await tester.pumpAndSettle();

    // select token
    final fP = find.text('p');
    await tester.tapAt(tester.getCenter(fP));
    await tester.pumpAndSettle();

    final imageRect = tester.getRect(find.byType(Image));
    final width = imageRect.width;
    final height = imageRect.height;

    // grid 2x2 -> cell sizes
    const rows = 2;
    const cols = 2;
    final cellW = width / cols;
    final cellH = height / rows;

    // marker size for score 1.0
    const normalized = 1.0;
    const markerSize = 8.0 + (normalized * 20.0);

    final expectedLeftLocal = (0 + 0.5) * cellW - (markerSize / 2);
    final expectedTopLocal = (1 + 0.5) * cellH - (markerSize / 2);

    final expectedLeft =
        imageRect.left + expectedLeftLocal.clamp(0.0, width - markerSize);
    final expectedTop =
        imageRect.top + expectedTopLocal.clamp(0.0, height - markerSize);

    final markerRect = tester.getRect(find.byKey(const Key('marker-0-0')));
    expect(markerRect.left, closeTo(expectedLeft, 1.5));
    expect(markerRect.top, closeTo(expectedTop, 1.5));
  });

  testWidgets('AttentionView uses attention_shape Map variant', (tester) async {
    const base64Png =
        'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR4nGNgYAAAAAMAASsJTYQAAAAASUVORK5CYII=';
    final Uint8List imageBytes = base64Decode(base64Png);

    final tokens = ['m'];
    final tokenScores = [0.5];
    final topk = [
      [const TopKItem(row: 2, col: 3, score: 0.5)],
    ];

    final entity = ImageCaptionEntity(attributes: {
      'attention_image_bytes': imageBytes,
      'tokens': tokens,
      'token_scores': tokenScores,
      // provide shape as Map instead of list
      'attention_shape': const {'rows': 3, 'cols': 4},
      'attention_topk_items': topk,
    });

    await tester.pumpWidget(MaterialApp(
        home: Scaffold(
            body: Center(
                child: SizedBox(
                    width: 480,
                    height: 320,
                    child: AttentionView(entity: entity))))));
    await tester.pumpAndSettle();

    // select token
    final fM = find.text('m');
    await tester.tapAt(tester.getCenter(fM));
    await tester.pumpAndSettle();

    final imageRect = tester.getRect(find.byType(Image));
    final width = imageRect.width;
    final height = imageRect.height;

    const rows = 3;
    const cols = 4;
    final cellW = width / cols;
    final cellH = height / rows;

    final t = topk[0][0];
    final normalized = t.score.clamp(0.0, 1.0);
    final markerSize = 8.0 + (normalized * 20.0);
    final expectedLeftLocal = (t.col + 0.5) * cellW - (markerSize / 2);
    final expectedTopLocal = (t.row + 0.5) * cellH - (markerSize / 2);
    final expectedLeft =
        imageRect.left + expectedLeftLocal.clamp(0.0, width - markerSize);
    final expectedTop =
        imageRect.top + expectedTopLocal.clamp(0.0, height - markerSize);

    final markerRect = tester.getRect(find.byKey(const Key('marker-0-0')));
    expect(markerRect.left, closeTo(expectedLeft, 1.5));
    expect(markerRect.top, closeTo(expectedTop, 1.5));
  });

  testWidgets('AttentionView clamps markers at image edges', (tester) async {
    const base64Png =
        'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR4nGNgYAAAAAMAASsJTYQAAAAASUVORK5CYII=';
    final Uint8List imageBytes = base64Decode(base64Png);

    final tokens = ['edge'];
    final tokenScores = [1.0];
    // Place a marker that would compute a negative left/top without clamping (col = 0, row = 0)
    // and another at the far bottom-right (col = cols-1, row = rows-1)
    final topk = [
      [
        const TopKItem(row: 0, col: 0, score: 1.0),
        const TopKItem(row: 2, col: 2, score: 1.0),
      ],
    ];

    final entity = ImageCaptionEntity(attributes: {
      'attention_image_bytes': imageBytes,
      'tokens': tokens,
      'token_scores': tokenScores,
      // use grid 3x3 so second marker targets bottom-right
      'attention_grid': const [3, 3],
      'attention_topk_items': topk,
    });

    await tester.pumpWidget(MaterialApp(
        home: Scaffold(
            body: Center(
                child: SizedBox(
                    width: 300,
                    height: 300,
                    child: AttentionView(entity: entity))))));
    await tester.pumpAndSettle();

    final f = find.text('edge');
    await tester.tapAt(tester.getCenter(f));
    await tester.pumpAndSettle();

    final imageRect = tester.getRect(find.byType(Image));

    // marker 0 (top-left) should not have negative coordinates after clamping
    final r0 = tester.getRect(find.byKey(const Key('marker-0-0')));
    expect(r0.left, greaterThanOrEqualTo(imageRect.left - 0.5));
    expect(r0.top, greaterThanOrEqualTo(imageRect.top - 0.5));

    // marker 1 (bottom-right) should be within image right/bottom bounds (clamped)
    final r1 = tester.getRect(find.byKey(const Key('marker-0-1')));
    expect(r1.right, lessThanOrEqualTo(imageRect.right + 0.5));
    expect(r1.bottom, lessThanOrEqualTo(imageRect.bottom + 0.5));
  });

  testWidgets('AttentionView toggles markers when switching tokens',
      (tester) async {
    const base64Png =
        'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR4nGNgYAAAAAMAASsJTYQAAAAASUVORK5CYII=';
    final Uint8List imageBytes = base64Decode(base64Png);

    final tokens = ['one', 'two'];
    final tokenScores = [0.8, 0.3];
    final topk = [
      [const TopKItem(row: 0, col: 0, score: 0.8)],
      [const TopKItem(row: 0, col: 1, score: 0.3)],
    ];

    final entity = ImageCaptionEntity(attributes: {
      'attention_image_bytes': imageBytes,
      'tokens': tokens,
      'token_scores': tokenScores,
      'attention_grid': const [1, 2],
      'attention_topk_items': topk,
    });

    await tester.pumpWidget(MaterialApp(
        home: Scaffold(
            body: Center(
                child: SizedBox(
                    width: 360,
                    height: 240,
                    child: AttentionView(entity: entity))))));
    await tester.pumpAndSettle();

    // select token 'one'
    final fOne = find.text('one');
    await tester.tapAt(tester.getCenter(fOne));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('marker-0-0')), findsOneWidget);
    expect(find.byKey(const Key('marker-1-0')), findsNothing);

    // select token 'two' -> marker for 'one' should disappear, 'two' should appear
    final fTwo = find.text('two');
    await tester.tapAt(tester.getCenter(fTwo));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('marker-0-0')), findsNothing);
    expect(find.byKey(const Key('marker-1-0')), findsOneWidget);

    // tap 'two' again to deselect
    await tester.tapAt(tester.getCenter(fTwo));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('marker-1-0')), findsNothing);
  });

  testWidgets('AttentionView precise clipping positions near edges',
      (tester) async {
    const base64Png =
        'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR4nGNgYAAAAAMAASsJTYQAAAAASUVORK5CYII=';
    final Uint8List imageBytes = base64Decode(base64Png);

    final tokens = ['edge-precise'];
    final tokenScores = [1.0];
    // Use high scores to increase marker size and force clamping
    final topk = [
      [
        const TopKItem(row: 0, col: 0, score: 1.0), // top-left
        const TopKItem(row: 2, col: 2, score: 1.0), // bottom-right
      ],
    ];

    final entity = ImageCaptionEntity(attributes: {
      'attention_image_bytes': imageBytes,
      'tokens': tokens,
      'token_scores': tokenScores,
      // grid 3x3 so the right/bottom marker targets the corner cell
      'attention_grid': const [3, 3],
      'attention_topk_items': topk,
    });

    // Use an exact container size so geometry is deterministic
    const containerW = 360.0;
    const containerH = 240.0;
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Center(
          child: SizedBox(
              width: containerW,
              height: containerH,
              child: AttentionView(entity: entity)),
        ),
      ),
    ));
    await tester.pumpAndSettle();

    // select token
    final f = find.text('edge-precise');
    await tester.tapAt(tester.getCenter(f));
    await tester.pumpAndSettle();

    final imageRect = tester.getRect(find.byType(Image));
    final width = imageRect.width;
    final height = imageRect.height;

    // cell sizes for 3x3 grid
    const rows = 3;
    const cols = 3;
    final cellW = width / cols;
    final cellH = height / rows;

    // marker size formula from widget
    const normalized = 1.0;
    const markerSize = 8.0 + (normalized * 20.0); // 28.0

    // expected left/top for top-left before clamping
    final expectedLeftLocal0 = (0 + 0.5) * cellW - (markerSize / 2);
    final expectedTopLocal0 = (0 + 0.5) * cellH - (markerSize / 2);
    final expectedLeft0 =
        imageRect.left + expectedLeftLocal0.clamp(0.0, width - markerSize);
    final expectedTop0 =
        imageRect.top + expectedTopLocal0.clamp(0.0, height - markerSize);

    // expected left/top for bottom-right (col=2,row=2)
    final expectedLeftLocal1 = (2 + 0.5) * cellW - (markerSize / 2);
    final expectedTopLocal1 = (2 + 0.5) * cellH - (markerSize / 2);
    final expectedLeft1 =
        imageRect.left + expectedLeftLocal1.clamp(0.0, width - markerSize);
    final expectedTop1 =
        imageRect.top + expectedTopLocal1.clamp(0.0, height - markerSize);

    final r0 = tester.getRect(find.byKey(const Key('marker-0-0')));
    final r1 = tester.getRect(find.byKey(const Key('marker-0-1')));

    // Use a tight tolerance since geometry is deterministic
    expect(r0.left, closeTo(expectedLeft0, 0.6));
    expect(r0.top, closeTo(expectedTop0, 0.6));
    expect(r1.left, closeTo(expectedLeft1, 0.6));
    expect(r1.top, closeTo(expectedTop1, 0.6));
  });

  testWidgets('AttentionView oversized marker clamps and sizes correctly',
      (tester) async {
    const base64Png =
        'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR4nGNgYAAAAAMAASsJTYQAAAAASUVORK5CYII=';
    final Uint8List imageBytes = base64Decode(base64Png);

    final tokens = ['big'];
    final tokenScores = [1.0];
    // Use a 10x10 grid so each cell is small; place a marker near bottom-right to force clamping
    final topk = [
      [
        const TopKItem(row: 9, col: 9, score: 1.0), // will be clamped
        const TopKItem(row: 0, col: 0, score: 1.0), // top-left
      ],
    ];

    final entity = ImageCaptionEntity(attributes: {
      'attention_image_bytes': imageBytes,
      'tokens': tokens,
      'token_scores': tokenScores,
      'attention_grid': const [10, 10],
      'attention_topk_items': topk,
    });

    // Make container generous so Column won't overflow but image cell sizes remain small
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Center(
          child: SizedBox(
              width: 360, height: 300, child: AttentionView(entity: entity)),
        ),
      ),
    ));
    await tester.pumpAndSettle();

    // select token
    final f = find.text('big');
    await tester.tapAt(tester.getCenter(f));
    await tester.pumpAndSettle();

    final imageRect = tester.getRect(find.byType(Image));
    final width = imageRect.width;
    final height = imageRect.height;

    const rows = 10;
    const cols = 10;
    final cellW = width / cols;
    final cellH = height / rows;

    // marker size = 8 + normalized*20 = 28
    const markerSize = 28.0;

    // For bottom-right (col=9,row=9), expected local before clamp:
    final expectedLeftLocal = (9 + 0.5) * cellW - (markerSize / 2);
    final expectedTopLocal = (9 + 0.5) * cellH - (markerSize / 2);

    // After clamping, expectedLeft = imageRect.left + clamp(expectedLeftLocal, 0, width - markerSize)
    final expectedLeftClamped =
        imageRect.left + expectedLeftLocal.clamp(0.0, width - markerSize);
    final expectedTopClamped =
        imageRect.top + expectedTopLocal.clamp(0.0, height - markerSize);

    // First marker was the bottom-right one (index 0)
    final mr = tester.getRect(find.byKey(const Key('marker-0-0')));
    final mrTopLeft = Offset(mr.left, mr.top);

    expect(mr.width, closeTo(markerSize, 0.5));
    expect(mr.height, closeTo(markerSize, 0.5));
    expect(mrTopLeft.dx, closeTo(expectedLeftClamped, 1.0));
    expect(mrTopLeft.dy, closeTo(expectedTopClamped, 1.0));
  });

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

    expect(
        find.descendant(
            of: legendFinder,
            matching: find.byWidgetPredicate(matchColor(expected0))),
        findsWidgets);
    expect(
        find.descendant(
            of: legendFinder,
            matching: find.byWidgetPredicate(matchColor(expected1))),
        findsWidgets);
    expect(
        find.descendant(
            of: legendFinder,
            matching: find.byWidgetPredicate(matchColor(expected2))),
        findsWidgets);
    expect(
        find.descendant(
            of: legendFinder,
            matching: find.byWidgetPredicate(matchColor(expected3))),
        findsWidgets);
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
