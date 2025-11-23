import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vision_xai/core/services/notification_service.dart';

void main() {
  testWidgets('NotificationServiceImpl shows a SnackBar', (tester) async {
    final service = NotificationServiceImpl();

    // We'll capture the BuildContext from the Builder so we can call the service
    late BuildContext capturedContext;

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Builder(builder: (ctx) {
          capturedContext = ctx;
          return const SizedBox.shrink();
        }),
      ),
    ));

    // Show a snack
    service.showSnackBar('hello-snack',
        context: capturedContext, backgroundColor: Colors.green);

    // Pump to allow the SnackBar animation to start
    await tester.pump();
    // Let the SnackBar be fully visible
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text('hello-snack'), findsOneWidget);
    expect(find.byType(SnackBar), findsOneWidget);
  });
}
