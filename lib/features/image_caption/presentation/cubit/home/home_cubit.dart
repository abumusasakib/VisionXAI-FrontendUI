import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vision_xai/core/constants/string_res.dart';
import 'package:vision_xai/core/utils/error_message_mapper.dart';
import 'package:vision_xai/core/services/notification_service.dart';
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

  final NotificationService _notificationService;

  HomeCubit(this._imageCaptionCubit,
      {required NotificationService notificationService, TtsClient? ttsClient})
      : _notificationService = notificationService,
        _ttsClient = ttsClient ?? FlutterTtsClient(),
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

    // Guard Platform checks because `dart:io` operations are unsupported on web
    // and may throw at runtime (Platform._operatingSystem). Use a try/catch
    // so web builds won't crash when accessing Platform.
    bool isIos = false;
    try {
      isIos = Platform.isIOS;
    } catch (_) {
      isIos = false;
    }

    if (isIos) {
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

    // Stop any ongoing TTS and clear any existing caption/result before
    // starting a new generation to avoid overlapping audio and stale UI.
    try {
      await _ttsClient.stop();
    } catch (_) {}
    emit(state.copyWith(
        isSpeaking: false,
        isLoading: true,
        errorMessage: null,
        testOutput: ''));

    // Wrap the upload+generation flow so we return a Result and optionally
    // show a SnackBar on error (handled inside runWithErrorHandling).
    final result = await runWithErrorHandling<void>(() async {
      final xFile = state.imageFile!;
      // Log effective base URL constructed from the current state (IP/port)
      // and file details so developers can verify what the client will call.
      try {
        final effectiveBase = 'http://${state.ip.trim()}:${state.port.trim()}';
        log('Uploading image to $effectiveBase/caption', name: 'HomeCubit');
        log('Uploading file: ${xFile.name}, size: ${await xFile.length()} bytes',
            name: 'HomeCubit');
      } catch (_) {}

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
          if (context.mounted) {
            emit(state.copyWith(
                testOutput: loaded.entity.attributes['caption'] ?? '',
                isLoading: false));
          }
        },
        failure: (failure) {
          // Convert terminal failure into an exception so runWithErrorHandling
          // can catch it and return a failure Result.
          final err = failure.error;
          throw err;
        },
        unKnown: (_) {
          throw Exception(StringRes.errorOccurred);
        },
      );
    },
        showSnackOnError: false,
        notificationService: _notificationService,
        localizations: context.tr);

    if (!result.isSuccess) {
      // Show a SnackBar for the failure using the global messenger
      try {
        _notificationService.showSnackBar(result.errorMessage ?? '');
      } catch (_) {}
      // Ensure UI reflects error
      emit(state.copyWith(errorMessage: result.errorMessage, isLoading: false));
    }

    _isCaptionGenerationInProgress = false;
    _cancelToken = null;
    emit(state.copyWith(isLoading: false));
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
