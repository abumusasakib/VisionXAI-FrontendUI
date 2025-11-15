import 'package:flutter_tts/flutter_tts.dart';

/// Small adapter interface so presentation code can avoid depending
/// directly on the plugin.
abstract class TtsClient {
  Future<void> awaitSpeakCompletion(bool awaitCompletion);

  Future<void> setLanguage(String language);

  Future<void> setSpeechRate(double rate);

  Future<void> setVolume(double volume);

  Future<void> setPitch(double pitch);

  void setStartHandler(void Function()? handler);

  void setCompletionHandler(void Function()? handler);

  void setCancelHandler(void Function()? handler);

  void setErrorHandler(void Function(dynamic)? handler);

  Future<void> setSharedInstance(bool shared);

  Future<void> setIosAudioCategory(
      IosTextToSpeechAudioCategory category,
      List<IosTextToSpeechAudioCategoryOptions> options,
      IosTextToSpeechAudioMode mode);

  Future<void> stop();

  Future<dynamic> speak(String text);
}

class FlutterTtsClient implements TtsClient {
  final FlutterTts _impl;

  FlutterTtsClient([FlutterTts? impl]) : _impl = impl ?? FlutterTts();

  @override
  Future<void> awaitSpeakCompletion(bool awaitCompletion) =>
      _impl.awaitSpeakCompletion(awaitCompletion);

  @override
  Future<void> setLanguage(String language) => _impl.setLanguage(language);

  @override
  Future<void> setSpeechRate(double rate) => _impl.setSpeechRate(rate);

  @override
  Future<void> setVolume(double volume) => _impl.setVolume(volume);

  @override
  Future<void> setPitch(double pitch) => _impl.setPitch(pitch);

  @override
  @override
  void setStartHandler(void Function()? handler) =>
      _impl.setStartHandler(handler ?? () {});

  @override
  void setCompletionHandler(void Function()? handler) =>
      _impl.setCompletionHandler(handler ?? () {});

  @override
  void setCancelHandler(void Function()? handler) =>
      _impl.setCancelHandler(handler ?? () {});

  @override
  void setErrorHandler(void Function(dynamic)? handler) =>
      _impl.setErrorHandler(handler ?? (_) {});

  @override
  Future<void> setSharedInstance(bool shared) =>
      _impl.setSharedInstance(shared);

  @override
  Future<void> setIosAudioCategory(
          IosTextToSpeechAudioCategory category,
          List<IosTextToSpeechAudioCategoryOptions> options,
          IosTextToSpeechAudioMode mode) =>
      _impl.setIosAudioCategory(category, options, mode);

  @override
  Future<void> stop() => _impl.stop();

  @override
  Future<dynamic> speak(String text) => _impl.speak(text);
}
