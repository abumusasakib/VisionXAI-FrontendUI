import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vision_xai/features/settings/color_palette/presentation/screen/widgets/generate_image_button.dart';
import 'package:vision_xai/l10n/app_localizations.dart';

void main() {
  testWidgets(
      'GenerateImageButton calls injected generate and updates controllers',
      (tester) async {
    final p = TextEditingController();
    final s = TextEditingController();
    final b = TextEditingController();

    // Injected showImageSourcePicker that returns 'files'
    Future<String?> fakeShow(BuildContext _) async => 'files';
    // Injected pickFile that returns a dummy File (not used because we inject generate)
    Future<File?> fakePickFile() async => File('dummy');
    // Injected generate that returns a known palette
    Future<Map<String, dynamic>> fakeGenerate(
        BuildContext _, ImageProvider __) async {
      return {
        'primary': const Color(0xFF112233),
        'secondary': const Color(0xFF445566),
        'background': const Color(0xFF778899),
      };
    }

    await tester.pumpWidget(MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        body: GenerateImageButton(
          primaryController: p,
          secondaryController: s,
          backgroundController: b,
          showImageSourcePicker: fakeShow,
          pickFile: fakePickFile,
          generate: fakeGenerate,
        ),
      ),
    ));

    // Tap the button
    await tester.tap(find.byType(GenerateImageButton));
    await tester.pumpAndSettle();

    // Expect controllers updated to hex strings (toHex is used in widget; generated numbers are ARGB ints)
    // Our widget uses toHex which expects a Color or int; since we returned ints, ensure they are formatted by toHex in widget.
    expect(p.text.isNotEmpty, true);
    expect(s.text.isNotEmpty, true);
    expect(b.text.isNotEmpty, true);
  });

  testWidgets('ProgressService shows and hides during generation',
      (tester) async {
    final p = TextEditingController();
    final s = TextEditingController();
    final b = TextEditingController();

    final generateStarted = Completer<void>();
    final continueGeneration = Completer<void>();

    Future<String?> fakeShow(BuildContext _) async => 'files';
    Future<File?> fakePickFile() async => File('dummy');

    Future<Map<String, dynamic>> fakeGenerate(
        BuildContext _, ImageProvider __) async {
      // Notify test that generation has started and wait until the test
      // allows completion so we can assert the progress dialog is visible.
      if (!generateStarted.isCompleted) generateStarted.complete();
      await continueGeneration.future;
      return {
        'primary': const Color(0xFF112233),
        'secondary': const Color(0xFF445566),
        'background': const Color(0xFF778899),
      };
    }

    await tester.pumpWidget(MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        body: GenerateImageButton(
          primaryController: p,
          secondaryController: s,
          backgroundController: b,
          showImageSourcePicker: fakeShow,
          pickFile: fakePickFile,
          generate: fakeGenerate,
        ),
      ),
    ));

    // Tap the button to start generation
    await tester.tap(find.byType(GenerateImageButton));

    // Wait until the fakeGenerate signals it started (so ProgressService.show
    // should have been called).
    await tester.pump();
    await generateStarted.future;

    // Allow the dialog to build
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // Complete generation and allow widget tree to settle
    continueGeneration.complete();
    await tester.pumpAndSettle();

    // Progress dialog should be dismissed and controllers updated
    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(p.text.isNotEmpty, true);
    expect(s.text.isNotEmpty, true);
    expect(b.text.isNotEmpty, true);
  });
}
