import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vision_xai/features/image_caption/presentation/cubit/home/home_cubit.dart';
import 'package:vision_xai/features/image_caption/presentation/cubit/home/home_state.dart';
import 'package:vision_xai/features/image_caption/presentation/cubit/image_caption/image_caption_cubit.dart';
import 'package:vision_xai/features/image_caption/presentation/screen/widget/attention_view.dart';
import 'package:vision_xai/l10n/localization_extension.dart';

Widget controlsWidget(BuildContext context, HomeCubit cubit, HomeState state,
    ImagePicker picker) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      // Button to Select Image
      ElevatedButton.icon(
        onPressed: () async {
          final pickedImage = await picker.pickImage(
            source: ImageSource.gallery,
          );
          if (pickedImage != null) {
            cubit.selectImage(pickedImage);
          }
        },
        icon: const Icon(Icons.photo_library),
        label: Text(context.tr.selectImageFromGallery),
      ),
      const SizedBox(height: 16),
      if (!kIsWeb && !Platform.isWindows)
        ElevatedButton.icon(
          onPressed: () async {
            final pickedImage = await picker.pickImage(
              source: ImageSource.camera,
            );
            if (pickedImage != null) {
              cubit.selectImage(pickedImage);
            }
          },
          icon: const Icon(Icons.camera_alt),
          label: Text(context.tr.camera),
        ),
      const SizedBox(height: 16),
      // Button to Upload Image
      ElevatedButton.icon(
        onPressed: state.isLoading
            ? null
            : () async {
                if (context.mounted) {
                  cubit.uploadAndGenerateCaption(context);
                }
              },
        icon: const Icon(Icons.cloud_upload),
        label: state.isLoading
            ? CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).colorScheme.onSecondary),
              )
            : Text(context.tr.generateCaption),
      ),
      const SizedBox(height: 16),
      if (state.isLoading)
        ElevatedButton.icon(
          onPressed: () {
            cubit.stopCaptionGeneration(context);
          },
          icon: const Icon(Icons.stop),
          label: Text(context.tr.stopCaptionGeneration),
        ),
      const SizedBox(height: 16),
      if (state.isLoading)
        Center(
          child: Text(
            context.tr.generatingCaption,
            style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
          ),
        ),
      const SizedBox(height: 16),
      // Text Output for Caption
      Container(
        constraints: const BoxConstraints(minHeight: 100),
        child: Center(
          child: state.testOutput.isNotEmpty
              ? Column(
                  children: [
                    Text(
                      state.testOutput,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Show attention image and token-level UI when image-captioned entity is available
                    BlocBuilder<ImageCaptionCubit, ImageCaptionState>(
                      builder: (context, imgState) {
                        return imgState.maybeWhen(
                            loaded: (entity) => AttentionView(entity: entity),
                            orElse: () => const SizedBox.shrink());
                      },
                    ),
                    const SizedBox(height: 12),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder: (child, animation) => FadeTransition(
                        opacity: animation,
                        child: child,
                      ),
                      child: state.isSpeaking
                          // Stop button (only visible when speaking)
                          ? ElevatedButton.icon(
                              key: const ValueKey('stopButton'),
                              onPressed: () {
                                context.read<HomeCubit>().stopSpeaking();
                              },
                              icon: const Icon(Icons.stop),
                              label: Text(context.tr.stop),
                            )
                          // Listen button (only visible when not speaking)
                          : ElevatedButton.icon(
                              key: const ValueKey('listenButton'),
                              onPressed: () {
                                context
                                    .read<HomeCubit>()
                                    .speakCaption(state.testOutput, context);
                              },
                              icon: const Icon(Icons.volume_up),
                              label: Text(context.tr.listen),
                            ),
                    ),
                  ],
                )
              : Text(
                  context.tr.captionText,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
        ),
      ),
    ],
  );
}
