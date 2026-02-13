import 'package:flutter/material.dart';

/// Calculates a responsive display height based on viewport size.
///
/// This is useful for widgets inside [SingleChildScrollView] where
/// [LayoutBuilder] constraints are unbounded.
///
/// [heightFactor] - percentage of screen height to use (e.g., 0.65 for 65%)
/// [minHeight] - minimum height in logical pixels (default: 220.0)
double getResponsiveImageHeight(
  BuildContext context, {
  double heightFactor = 0.65,
  double minHeight = 220.0,
}) {
  final screenHeight = MediaQuery.sizeOf(context).height;
  return (screenHeight * heightFactor).clamp(minHeight, screenHeight);
}
