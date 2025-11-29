import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vision_xai/features/settings/color_palette/presentation/screen/widgets/generate_from_hex_button.dart';
import 'package:vision_xai/features/settings/color_palette/core/utils/palette_utils.dart';
import 'package:vision_xai/l10n/app_localizations.dart';

void main() {
  testWidgets('GenerateFromHexButton updates controllers with palette',
      (tester) async {
    final p = TextEditingController(text: '#FF0000');
    final s = TextEditingController(text: '#00FF00');
    final b = TextEditingController(text: '#0000FF');

    // Build widget
    await tester.pumpWidget(MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        body: GenerateFromHexButton(
          primaryController: p,
          secondaryController: s,
          backgroundController: b,
        ),
      ),
    ));

    // Initially background is #0000FF
    expect(b.text, '#0000FF');

    // Update background to a new hex and tap button
    b.text = '#123456';
    await tester.tap(find.byType(GenerateFromHexButton));
    await tester.pumpAndSettle();

    // The controllers should update to the generated palette values (hex)
    // We can recompute expected values using toHex on the generated colors
    final palette = buildPaletteFromHex('#123456');
    expect(p.text, toHex(palette['primary']!));
    expect(s.text, toHex(palette['secondary']!));
    expect(b.text, toHex(palette['background']!));
  });
}
