import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logging/logging.dart';
import 'package:vision_xai/core/services/global_ui_service.dart';
import 'package:vision_xai/core/services/notification_service.dart';

void main() {
  testWidgets('NotificationServiceImpl logs metadata on showSnackBar',
      (tester) async {
    // Create a dedicated logger for this test
    final testLogger = Logger('NotificationService.Test');
    final records = <LogRecord>[];
    
    // Listen only to our test logger
    testLogger.onRecord.listen((r) {
      records.add(r);
    });

    final service = NotificationServiceImpl(logger: testLogger);

    late BuildContext capturedContext;
    await tester.pumpWidget(MaterialApp(
      scaffoldMessengerKey: GlobalUiService.scaffoldMessengerKey,
      home: Scaffold(
        body: Builder(builder: (ctx) {
          capturedContext = ctx;
          return const SizedBox.shrink();
        }),
      ),
    ));

    service.showSnackBar('log-snack', context: capturedContext);

    // Give time for logging to occur
    await tester.pump();

    expect(records, isNotEmpty, reason: 'No log records captured');

    final rec = records.last;
    expect(rec.message, equals('log-snack'));
    expect(rec.error, isA<Map>());
    
    final meta = rec.error as Map;
    expect(meta.containsKey('id'), isTrue);
    expect(meta.containsKey('caller'), isTrue);
    expect(meta['route'], isA<String>());
  });

  testWidgets('SnackBar is actually shown on screen', (tester) async {
    final service = NotificationServiceImpl();

    late BuildContext capturedContext;
    await tester.pumpWidget(MaterialApp(
      scaffoldMessengerKey: GlobalUiService.scaffoldMessengerKey,
      home: Scaffold(
        body: Builder(builder: (ctx) {
          capturedContext = ctx;
          return const SizedBox.shrink();
        }),
      ),
    ));

    service.showSnackBar('Test SnackBar Message', context: capturedContext);

    // Pump to trigger the frame that shows the SnackBar
    await tester.pump();
    // Pump the beginning of the animation
    await tester.pump(const Duration(milliseconds: 100));

    // Verify SnackBar is displayed
    expect(find.text('Test SnackBar Message'), findsOneWidget);
    expect(find.byType(SnackBar), findsOneWidget);
  });

  testWidgets('Log contains correct route name when using named route',
      (tester) async {
    final testLogger = Logger('NotificationService.RouteTest');
    final records = <LogRecord>[];
    
    testLogger.onRecord.listen((r) {
      records.add(r);
    });

    final service = NotificationServiceImpl(logger: testLogger);

    late BuildContext capturedContext;
    await tester.pumpWidget(MaterialApp(
      scaffoldMessengerKey: GlobalUiService.scaffoldMessengerKey,
      routes: {
        '/test-route': (context) => Scaffold(
              body: Builder(builder: (ctx) {
                capturedContext = ctx;
                return const Text('Test Route');
              }),
            ),
      },
      home: Builder(
        builder: (context) => Scaffold(
          body: ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/test-route'),
            child: const Text('Navigate'),
          ),
        ),
      ),
    ));

    // Navigate to named route
    await tester.tap(find.text('Navigate'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    // Verify we're on the test route
    expect(find.text('Test Route'), findsOneWidget);

    // Show snackbar from named route context
    service.showSnackBar('route-test', context: capturedContext);

    // Pump to trigger logging
    await tester.pump();

    expect(records, isNotEmpty);
    final rec = records.last;
    expect(rec.message, equals('route-test'));
    
    final meta = rec.error as Map;
    // Verify the route name is captured
    expect(meta['route'], equals('/test-route'));
  });

  testWidgets('SnackBar shows with custom styling', (tester) async {
    final service = NotificationServiceImpl();

    late BuildContext capturedContext;
    await tester.pumpWidget(MaterialApp(
      scaffoldMessengerKey: GlobalUiService.scaffoldMessengerKey,
      home: Scaffold(
        body: Builder(builder: (ctx) {
          capturedContext = ctx;
          return const SizedBox.shrink();
        }),
      ),
    ));

    service.showSnackBar(
      'Styled Message',
      context: capturedContext,
      backgroundColor: Colors.red,
      duration: const Duration(seconds: 5),
    );

    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    // Verify SnackBar with styling
    final snackBar = tester.widget<SnackBar>(find.byType(SnackBar));
    expect(snackBar.backgroundColor, equals(Colors.red));
    expect(snackBar.duration, equals(const Duration(seconds: 5)));
    expect(find.text('Styled Message'), findsOneWidget);
  });

  testWidgets('Log metadata includes backgroundColor and duration',
      (tester) async {
    final testLogger = Logger('NotificationService.MetadataTest');
    final records = <LogRecord>[];
    
    testLogger.onRecord.listen((r) {
      records.add(r);
    });

    final service = NotificationServiceImpl(logger: testLogger);

    late BuildContext capturedContext;
    await tester.pumpWidget(MaterialApp(
      scaffoldMessengerKey: GlobalUiService.scaffoldMessengerKey,
      home: Scaffold(
        body: Builder(builder: (ctx) {
          capturedContext = ctx;
          return const SizedBox.shrink();
        }),
      ),
    ));

    service.showSnackBar(
      'metadata-test',
      context: capturedContext,
      backgroundColor: Colors.blue,
      duration: const Duration(seconds: 10),
    );

    await tester.pump();

    expect(records, isNotEmpty);
    final rec = records.last;
    expect(rec.message, equals('metadata-test'));
    
    final meta = rec.error as Map;
    expect(meta.containsKey('backgroundColor'), isTrue);
    expect(meta['backgroundColor'], contains('Color'));
    expect(meta['duration'], equals(10));
  });
}
