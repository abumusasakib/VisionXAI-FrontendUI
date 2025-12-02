// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vision_xai/features/settings/color_palette/presentation/cubit/palette/palette_cubit.dart';
import 'package:vision_xai/core/services/bottom_sheet_service.dart';
import 'package:vision_xai/core/services/notification_service.dart';
import 'package:vision_xai/core/services/progress_service.dart';
import 'package:vision_xai/l10n/localization_extension.dart';
import 'package:vision_xai/features/settings/color_palette/core/utils/palette_utils.dart';

class GenerateImageButton extends StatefulWidget {
  final TextEditingController primaryController;
  final TextEditingController secondaryController;
  final TextEditingController backgroundController;

  /// Optional injection points for easier testing.
  final Future<String?> Function(BuildContext)? showImageSourcePicker;
  final Future<File?> Function()? pickFile;
  final Future<File?> Function()? pickFromGallery;
  final Future<Map<String, dynamic>> Function(BuildContext, ImageProvider)?
      generate;

  const GenerateImageButton({
    super.key,
    required this.primaryController,
    required this.secondaryController,
    required this.backgroundController,
    this.showImageSourcePicker,
    this.pickFile,
    this.pickFromGallery,
    this.generate,
  });

  @override
  State<GenerateImageButton> createState() => _GenerateImageButtonState();
}

class _GenerateImageButtonState extends State<GenerateImageButton> {
  @override
  Widget build(BuildContext context) {
    final secondaryColor = _safeSecondaryColor(context);

    return OutlinedButton.icon(
      onPressed: () async {
        // Capture localized strings and services early to avoid using
        // BuildContext across async gaps.
        final tr = context.tr;
        final notifier = defaultNotificationService;
        // Only read the cubit if no injected `generate` function exists.
        final PaletteCubit? paletteCubit =
            widget.generate == null ? context.read<PaletteCubit>() : null;

        try {
          // The bottom sheet uses the provided context to show UI; the
          // resulting await is intentionally permitted. Lint is noisy
          // here because the context is used to present the sheet. Guard
          // subsequent UI calls with `mounted`.
          final choice = await (widget.showImageSourcePicker?.call(context) ??
              BottomSheetService.showImageSourcePicker());
          if (choice == null) return;

          ImageProvider? provider;

          if (choice == 'files') {
            final File? file =
                await (widget.pickFile?.call() ?? _defaultPickFile());
            if (file == null) return;
            if (kIsWeb) {
              // Use notification service; safe to pass context here because
              // we check `mounted` before UI interactions below.
              if (!mounted) return;
              notifier.showSnackBar(tr.localFilesNotSupported);
              return;
            }
            provider = FileImage(file);
          } else if (choice == 'gallery') {
            final File? file = await (widget.pickFromGallery?.call() ??
                _defaultPickFromGallery());
            if (file == null) return;
            provider = FileImage(file);
          }

          if (provider == null) return;

          // Show a blocking progress indicator while generating the palette.
          // Await the show call so the dialog is painted and the
          // CircularProgressIndicator starts animating before starting
          // potentially heavy synchronous work.
          if (!mounted) return;
          await ProgressService.show(context,
              message: tr.generatingPalette, size: 84);
          try {
            final Map<String, dynamic> palette = widget.generate != null
                ? await widget.generate!(context, provider)
                : await paletteCubit!.generateFromImage(provider);

            if (!mounted) return;
            widget.primaryController.text = toHex(palette['primary']);
            widget.secondaryController.text = toHex(palette['secondary']);
            widget.backgroundController.text = toHex(palette['background']);
          } finally {
            if (mounted) {
              ProgressService.hide(context);
            }
          }
        } catch (e) {
          if (!mounted) return;
          final message = tr.paletteGenerationFailed(e.toString());
          defaultNotificationService.showSnackBar(message);
        }
      },
      icon: const Icon(Icons.photo_library, size: 18),
      label: Text(context.tr.generateFromImage),
      // Make this a filled action button using secondary color for the
      // background and white foreground so it matches other actions and
      // remains legible on light surfaces.
      style: OutlinedButton.styleFrom(
        backgroundColor: secondaryColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        side: BorderSide(color: secondaryColor.withOpacity(0.3)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}

Color _safeSecondaryColor(BuildContext context) {
  try {
    return context.read<PaletteCubit>().state.secondaryColor;
  } catch (_) {
    return Colors.grey;
  }
}

// Default helpers used when injection points are not provided.
Future<File?> _defaultPickFile() async {
  final result = await FilePicker.platform.pickFiles(
    type: FileType.image,
    allowMultiple: false,
  );
  if (result == null || result.files.isEmpty) return null;
  final path = result.files.single.path;
  if (path == null) return null;
  return File(path);
}

Future<File?> _defaultPickFromGallery() async {
  final picker = ImagePicker();
  final picked = await picker.pickImage(source: ImageSource.gallery);
  if (picked == null) return null;
  return File(picked.path);
}
