import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logging/logging.dart';
import 'package:vision_xai/core/services/notification_service.dart';

void main() {
  testWidgets('NotificationServiceImpl logs metadata on showSnackBar',
      (tester) async {
    final serviceLogger = Logger('NotificationService');

    final records = <LogRecord>[];
    final sub = Logger.root.onRecord.listen((r) {
      if (r.loggerName == 'NotificationService') records.add(r);
    });

    final service = NotificationServiceImpl(logger: serviceLogger);

    // Capture BuildContext
    late BuildContext capturedContext;
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Builder(builder: (ctx) {
          capturedContext = ctx;
          return const SizedBox.shrink();
        }),
      ),
    ));

    service.showSnackBar('log-snack', context: capturedContext);

    // Pump to allow the SnackBar animation and logging to occur
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(records.isNotEmpty, isTrue, reason: 'No log records captured');

    final rec = records.lastWhere((r) => r.message == 'log-snack');
    expect(rec, isNotNull);
    expect(rec.error, isA<Map>());
    final meta = rec.error as Map;
    expect(meta.containsKey('id'), isTrue);
    expect(meta.containsKey('caller'), isTrue);
    expect(meta['route'], isA<String>());

    await sub.cancel();
  });
}
