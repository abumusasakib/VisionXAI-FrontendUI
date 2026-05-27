import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vision_xai/core/services/global_ui_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('GlobalUiService', () {
    test('navigatorKey should be non-null and correctly typed', () {
      expect(GlobalUiService.navigatorKey, isNotNull);
      expect(GlobalUiService.navigatorKey, isA<GlobalKey<NavigatorState>>());
    });

    test('scaffoldMessengerKey should be non-null and correctly typed', () {
      expect(GlobalUiService.scaffoldMessengerKey, isNotNull);
      expect(GlobalUiService.scaffoldMessengerKey,
          isA<GlobalKey<ScaffoldMessengerState>>());
    });

    test('context and messenger should be null initially when not attached', () {
      expect(GlobalUiService.context, isNull);
      expect(GlobalUiService.messenger, isNull);
    });
  });
}
