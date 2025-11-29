import 'dart:io';
import 'dart:typed_data';
import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vision_xai/features/image_caption/presentation/cubit/home/home_cubit.dart';
import 'package:vision_xai/features/image_caption/presentation/cubit/image_caption/image_caption_cubit.dart';
import 'package:vision_xai/features/image_caption/domain/use_case/image_caption_uc.dart';
import 'package:vision_xai/features/image_caption/domain/repository/image_caption_repo.dart';
import 'package:vision_xai/features/image_caption/domain/entity/image_caption_entity_group.dart';
import 'package:dio/dio.dart';
import 'package:vision_xai/l10n/app_localizations.dart';
import 'package:vision_xai/core/services/notification_service.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:vision_xai/core/common/client/tts_client.dart';

class _FakeRepo implements ImageCaptionRepo {
  @override
  Future<Either<Exception, ImageCaptionEntityGroup>> call(
      Uint8List imageBytes, String filename,
      {cancelToken}) async {
    return left(const SocketException('No route to host'));
  }
}

class _CapturingNotificationService implements NotificationService {
  String? lastMessage;

  @override
  void showSnackBar(String message,
      {BuildContext? context,
      Color? backgroundColor,
      Duration? duration,
      TextStyle? textStyle}) {
    lastMessage = message;
  }
}

class _NoOpTtsClient implements TtsClient {
  @override
  Future<void> awaitSpeakCompletion(bool awaitCompletion) async {}

  @override
  Future<void> setLanguage(String language) async {}

  @override
  Future<void> setSpeechRate(double rate) async {}

  @override
  Future<void> setVolume(double volume) async {}

  @override
  Future<void> setPitch(double pitch) async {}

  @override
  void setStartHandler(void Function()? handler) {}

  @override
  void setCompletionHandler(void Function()? handler) {}

  @override
  void setCancelHandler(void Function()? handler) {}

  @override
  void setErrorHandler(void Function(dynamic)? handler) {}

  @override
  Future<void> setSharedInstance(bool shared) async {}

  @override
  Future<void> setIosAudioCategory(
      IosTextToSpeechAudioCategory category,
      List<IosTextToSpeechAudioCategoryOptions> options,
      IosTextToSpeechAudioMode mode) async {}

  @override
  Future<void> stop() async {}

  @override
  Future speak(String text) async {}
}

void main() {
  testWidgets('uploadAndGenerateCaption shows localized message on SocketException',
      (tester) async {
    final repo = _FakeRepo();
    final uc = ImageCaptionUC(repo);
    final imgCapCubit = ImageCaptionCubit(uc);
    final notification = _CapturingNotificationService();
    final homeCubit = HomeCubit(imgCapCubit,
        notificationService: notification, ttsClient: _NoOpTtsClient());

    // Provide a dummy image file
    final xfile = XFile.fromData(Uint8List.fromList([0]), name: 'test.jpg');
    await homeCubit.selectImage(xfile);

    // Pump an app with Bengali locale so context.tr resolves to bn
    await tester.pumpWidget(const MaterialApp(
      locale: Locale('bn'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(body: SizedBox()),
    ));

    final ctx = tester.element(find.byType(Scaffold));

    await homeCubit.uploadAndGenerateCaption(ctx);

    // Expect the captured notification to be the Bengali translation
    final expected = lookupAppLocalizations(const Locale('bn'))
        .noInternetOrServerUnreachable;
    expect(notification.lastMessage, expected);

    await homeCubit.close();
    await imgCapCubit.close();
  });

  testWidgets('uploadAndGenerateCaption shows localized message on TimeoutException',
      (tester) async {
    // Fake repo that returns TimeoutException
    final repo = _FakeRepoTimeout();
    final uc = ImageCaptionUC(repo);
    final imgCapCubit = ImageCaptionCubit(uc);
    final notification = _CapturingNotificationService();
    final homeCubit = HomeCubit(imgCapCubit,
        notificationService: notification, ttsClient: _NoOpTtsClient());

    final xfile = XFile.fromData(Uint8List.fromList([0]), name: 'test.jpg');
    await homeCubit.selectImage(xfile);

    await tester.pumpWidget(const MaterialApp(
      locale: Locale('bn'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(body: SizedBox()),
    ));
    final ctx = tester.element(find.byType(Scaffold));

    await homeCubit.uploadAndGenerateCaption(ctx);

    final expected = lookupAppLocalizations(const Locale('bn')).connectionTimeout;
    expect(notification.lastMessage, expected);

    await homeCubit.close();
    await imgCapCubit.close();
  });

  testWidgets('uploadAndGenerateCaption shows localized message on Dio badResponse',
      (tester) async {
    final repo = _FakeRepoBadResponse(500);
    final uc = ImageCaptionUC(repo);
    final imgCapCubit = ImageCaptionCubit(uc);
    final notification = _CapturingNotificationService();
    final homeCubit = HomeCubit(imgCapCubit,
        notificationService: notification, ttsClient: _NoOpTtsClient());

    final xfile = XFile.fromData(Uint8List.fromList([0]), name: 'test.jpg');
    await homeCubit.selectImage(xfile);

    await tester.pumpWidget(const MaterialApp(
      locale: Locale('bn'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(body: SizedBox()),
    ));
    final ctx = tester.element(find.byType(Scaffold));

    await homeCubit.uploadAndGenerateCaption(ctx);

    final expected = lookupAppLocalizations(const Locale('bn')).badResponse('500');
    expect(notification.lastMessage, expected);

    await homeCubit.close();
    await imgCapCubit.close();
  });

  testWidgets('uploadAndGenerateCaption shows localized message on Dio cancel',
      (tester) async {
    final repo = _FakeRepoCancel();
    final uc = ImageCaptionUC(repo);
    final imgCapCubit = ImageCaptionCubit(uc);
    final notification = _CapturingNotificationService();
    final homeCubit = HomeCubit(imgCapCubit,
        notificationService: notification, ttsClient: _NoOpTtsClient());

    final xfile = XFile.fromData(Uint8List.fromList([0]), name: 'test.jpg');
    await homeCubit.selectImage(xfile);

    await tester.pumpWidget(const MaterialApp(
      locale: Locale('bn'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(body: SizedBox()),
    ));
    final ctx = tester.element(find.byType(Scaffold));

    await homeCubit.uploadAndGenerateCaption(ctx);

    final expected = lookupAppLocalizations(const Locale('bn')).requestCancelled;
    expect(notification.lastMessage, expected);

    await homeCubit.close();
    await imgCapCubit.close();
  });
}

// Additional fake repos to return specific exception kinds
class _FakeRepoTimeout implements ImageCaptionRepo {
  @override
  Future<Either<Exception, ImageCaptionEntityGroup>> call(
      Uint8List imageBytes, String filename,
      {cancelToken}) async {
    return left(TimeoutException('timed out'));
  }
}

class _FakeRepoBadResponse implements ImageCaptionRepo {
  final int statusCode;
  _FakeRepoBadResponse(this.statusCode);

  @override
  Future<Either<Exception, ImageCaptionEntityGroup>> call(
      Uint8List imageBytes, String filename,
      {cancelToken}) async {
    final resp = Response(statusCode: statusCode, requestOptions: RequestOptions(path: ''));
    return left(DioException(requestOptions: RequestOptions(path: ''), type: DioExceptionType.badResponse, response: resp));
  }
}

class _FakeRepoCancel implements ImageCaptionRepo {
  @override
  Future<Either<Exception, ImageCaptionEntityGroup>> call(
      Uint8List imageBytes, String filename,
      {cancelToken}) async {
    return left(DioException(requestOptions: RequestOptions(path: ''), type: DioExceptionType.cancel));
  }
}
