import 'package:flutter/material.dart';

/// Centralized keys used to show UI (dialogs, bottom sheets, snackbars)
/// without a BuildContext.
class GlobalUiService {
  GlobalUiService._();

  /// Global navigator key to use for showing dialogs or bottom sheets.
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  /// Global scaffold messenger key to use for showing snackbars.
  static final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  static BuildContext? get context => navigatorKey.currentContext;

  static ScaffoldMessengerState? get messenger =>
      scaffoldMessengerKey.currentState;
}
