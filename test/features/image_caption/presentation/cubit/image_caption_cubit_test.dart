import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';

import 'package:vision_xai/features/image_caption/domain/use_case/image_caption_uc.dart';
import 'package:dio/dio.dart';
import 'package:vision_xai/features/image_caption/presentation/cubit/image_caption/image_caption_cubit.dart';
import 'package:vision_xai/features/image_caption/domain/entity/image_caption_entity.dart';
import 'package:vision_xai/features/image_caption/domain/entity/image_caption_entity_group.dart';
import 'package:vision_xai/features/image_caption/domain/repository/image_caption_repo.dart';

class FakeRepoSuccess implements ImageCaptionRepo {
  @override
  Future<Either<Exception, ImageCaptionEntityGroup>> call(
      Uint8List imageBytes, String filename,
      {CancelToken? cancelToken}) async {
    return const Right(ImageCaptionEntityGroup.success(
        ImageCaptionEntity(id: '1', attributes: {'caption': 'ok'})));
  }
}

class FakeRepoFailure implements ImageCaptionRepo {
  @override
  Future<Either<Exception, ImageCaptionEntityGroup>> call(
      Uint8List imageBytes, String filename,
      {CancelToken? cancelToken}) async {
    return Left(Exception('failure'));
  }
}

class _FailingRepo implements ImageCaptionRepo {
  final Exception exception;
  _FailingRepo(this.exception);

  @override
  Future<Either<Exception, ImageCaptionEntityGroup>> call(
      Uint8List imageBytes, String filename,
      {CancelToken? cancelToken}) async {
    return Future.value(Left(exception));
  }
}

class _UnknownRepo implements ImageCaptionRepo {
  @override
  Future<Either<Exception, ImageCaptionEntityGroup>> call(
      Uint8List imageBytes, String filename,
      {CancelToken? cancelToken}) async {
    return Future.value(const Right(ImageCaptionEntityGroup.unKnown()));
  }
}

class _FakeRepo implements ImageCaptionRepo {
  final ImageCaptionEntityGroup result;
  _FakeRepo(this.result);

  @override
  Future<Either<Exception, ImageCaptionEntityGroup>> call(
      Uint8List imageBytes, String filename,
      {CancelToken? cancelToken}) async {
    // Return synchronously resolved future
    return Future.value(Right(result));
  }
}

void main() {
  test('cubit emits loading then loaded on success', () async {
    final useCase = ImageCaptionUC(FakeRepoSuccess());
    final cubit = ImageCaptionCubit(useCase);

    final bytes = Uint8List.fromList([1]);
    final expectLaterFuture = expectLater(
      cubit.stream,
      emitsInOrder([
        isA<ImageCaptionState>(), // loading
        isA<ImageCaptionState>(), // loaded
      ]),
    );

    await cubit.call(bytes, 'img.png');
    await expectLaterFuture;
  });

  test('cubit emits loading then failure on repo failure', () async {
    final useCase = ImageCaptionUC(FakeRepoFailure());
    final cubit = ImageCaptionCubit(useCase);

    final bytes = Uint8List.fromList([1]);
    final expectLaterFuture = expectLater(
      cubit.stream,
      emitsInOrder([
        isA<ImageCaptionState>(), // loading
        isA<ImageCaptionState>(), // failure
      ]),
    );

    await cubit.call(bytes, 'img.png');
    await expectLaterFuture;
  });

  test('ImageCaptionCubit.call returns failure state when repo fails',
      () async {
    final repo = _FailingRepo(Exception('network failure'));
    final uc = ImageCaptionUC(repo);
    final cubit = ImageCaptionCubit(uc);

    final bytes = Uint8List.fromList([0]);

    final terminal = await cubit.call(bytes, 'file.jpg');

    expect(
        terminal.maybeWhen(failure: (e) => e, orElse: () => null), isNotNull);
    final failureObj =
        terminal.maybeWhen(failure: (e) => e, orElse: () => null);
    expect(failureObj.toString(), contains('network failure'));
    expect(cubit.state.maybeWhen(failure: (e) => e, orElse: () => null),
        isNotNull);
  });

  test('ImageCaptionCubit.call returns unknown state when repo yields unknown',
      () async {
    final repo = _UnknownRepo();
    final uc = ImageCaptionUC(repo);
    final cubit = ImageCaptionCubit(uc);

    final bytes = Uint8List.fromList([0]);

    final terminal = await cubit.call(bytes, 'file.jpg');

    expect(
        terminal.maybeWhen(unKnown: () => true, orElse: () => false), isTrue);
    expect(cubit.state.maybeWhen(unKnown: () => true, orElse: () => false),
        isTrue);
  });

  test('ImageCaptionCubit.call returns terminal loaded state synchronously',
      () async {
    const entity =
        ImageCaptionEntity(id: '1', attributes: {'caption': 'hello'});
    final repo = _FakeRepo(const ImageCaptionEntityGroup.success(entity));
    final uc = ImageCaptionUC(repo);
    final cubit = ImageCaptionCubit(uc);

    final bytes = Uint8List.fromList([1, 2, 3]);

    final terminal = await cubit.call(bytes, 'file.jpg');

    expect(terminal.maybeWhen(loaded: (e) => e, orElse: () => null), isNotNull);
    expect(
        cubit.state.maybeWhen(loaded: (e) => e, orElse: () => null), isNotNull);
    final loadedEntity =
        terminal.maybeWhen(loaded: (e) => e, orElse: () => null);
    expect(loadedEntity?.attributes['caption'], equals('hello'));
  });
}
