import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../core/common/client/tts_client.dart';
import 'package:dio/dio.dart';
import '../image_caption/image_caption_cubit.dart';
import 'package:vision_xai/l10n/localization_extension.dart';

import 'home_state.dart';

/// Presentation cubit for the image caption feature.
class HomeCubit extends Cubit<HomeState> {
  final ImagePicker _picker = ImagePicker();
  final ImageCaptionCubit _imageCaptionCubit;
  bool _isCaptionGenerationInProgress = false;
  CancelToken? _cancelToken;

  final TtsClient _ttsClient;

  HomeCubit(this._imageCaptionCubit, {TtsClient? ttsClient})
      : _ttsClient = ttsClient ?? FlutterTtsClient(),
        super(HomeState.initial()) {
    _configureTts();
  }

  void _configureTts() async {
    await _ttsClient.awaitSpeakCompletion(true);
    await _ttsClient.setLanguage("bn-BD"); // Bengali (Bangladesh)
    await _ttsClient.setSpeechRate(0.5);
    await _ttsClient.setVolume(1.0);
    await _ttsClient.setPitch(1.0);

    _ttsClient.setStartHandler(() {
      emit(state.copyWith(isSpeaking: true));
    });

    _ttsClient.setCompletionHandler(() {
      emit(state.copyWith(isSpeaking: false));
    });

    _ttsClient.setCancelHandler(() {
      emit(state.copyWith(isSpeaking: false));
    });

    _ttsClient.setErrorHandler((msg) {
      emit(state.copyWith(isSpeaking: false));
    });

    if (Platform.isIOS) {
      await _ttsClient.setSharedInstance(true);
      await _ttsClient.setIosAudioCategory(
        IosTextToSpeechAudioCategory.ambient,
        [
          IosTextToSpeechAudioCategoryOptions.allowBluetooth,
          IosTextToSpeechAudioCategoryOptions.allowBluetoothA2DP,
          IosTextToSpeechAudioCategoryOptions.mixWithOthers
        ],
        IosTextToSpeechAudioMode.voicePrompt,
      );
    }
  }

  Future<void> speakCaption(String text, BuildContext context) async {
    try {
      await _ttsClient.stop();
      emit(state.copyWith(isSpeaking: true));
      await _ttsClient.speak(text);
      emit(state.copyWith(isSpeaking: false));
    } catch (e, stackTrace) {
      emit(state.copyWith(isSpeaking: false));
      if (context.mounted) {
        emit(state.copyWith(
            errorMessage: context.tr.failedToSpeak, isSpeaking: false));
      }
      log('Exception in speakCaption: $e',
          stackTrace: stackTrace, name: 'HomeCubit');
    }
  }

  Future<void> stopSpeaking() async {
    await _ttsClient.stop();
    emit(state.copyWith(isSpeaking: false));
  }

  @override
  Future<void> close() {
    _ttsClient.stop();
    return super.close();
  }

  void setIpAndPort(String ip, String port) {
    emit(state.copyWith(ip: ip, port: port));
  }

  Future<void> selectImage(XFile file) async {
    emit(state.copyWith(imageFile: file));
  }

  Future<void> pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      emit(state.copyWith(imageFile: pickedFile));
    }
  }

  /// Uploads image bytes via the feature use-case (which uses Dio).
  /// The repository expects `Uint8List imageBytes` and `String filename`.
  Future<void> uploadAndGenerateCaption(BuildContext context) async {
    if (state.imageFile == null) {
      emit(state.copyWith(errorMessage: context.tr.noImageSelected));
      return;
    }

    emit(state.copyWith(isLoading: true, errorMessage: null));

    try {
      final xFile = state.imageFile!;
      final bytes = await xFile.readAsBytes();
      final filename = xFile.name;

      _isCaptionGenerationInProgress = true;

      _cancelToken = CancelToken();

      // Trigger API via ImageCaptionCubit and get the terminal state directly
      final terminalState = await _imageCaptionCubit.call(bytes, filename,
          cancelToken: _cancelToken);

      terminalState.map(
        initial: (_) {},
        loading: (_) {},
        loaded: (loaded) {
          emit(state.copyWith(
              testOutput: loaded.entity.attributes['caption'] ?? '',
              isLoading: false));
        },
        failure: (failure) {
          if (context.mounted) {
            emit(state.copyWith(
                errorMessage: failure.error.toString(), isLoading: false));
          }
        },
        unKnown: (_) {
          if (context.mounted) {
            emit(state.copyWith(
                errorMessage: context.tr.captionMissing, isLoading: false));
          }
        },
      );
    } catch (e, stackTrace) {
      log('Exception in uploadAndGenerateCaption: $e',
          stackTrace: stackTrace, name: 'HomeCubit');
      if (context.mounted) {
        emit(state.copyWith(
            errorMessage: context.tr.unknownError, isLoading: false));
      }
    } finally {
      _isCaptionGenerationInProgress = false;
      _cancelToken = null;
      emit(state.copyWith(isLoading: false));
    }
  }

  /// Stops the caption generation flow
  void stopCaptionGeneration(BuildContext context) {
    if (!_isCaptionGenerationInProgress) {
      emit(state.copyWith(errorMessage: context.tr.noCaptionInProgress));
      return;
    }

    _isCaptionGenerationInProgress = false;
    // Cancel the in-flight request if present
    try {
      _cancelToken?.cancel();
    } catch (_) {}
    _cancelToken = null;
    emit(state.copyWith(
        infoMessage: context.tr.captionStoppedShort, isLoading: false));
  }

  void clearInfoMessage() {
    emit(state.copyWith(infoMessage: null));
  }

  void reset() {
    _isCaptionGenerationInProgress = false;
    try {
      _cancelToken?.cancel();
    } catch (_) {}
    _cancelToken = null;
    emit(HomeState.initial());
    emit(state.copyWith(errorMessage: null));
  }
}
