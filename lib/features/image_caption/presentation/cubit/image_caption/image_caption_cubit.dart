import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../domain/entity/image_caption_entity.dart';
import '../../../domain/use_case/image_caption_uc.dart';

part 'image_caption_cubit.freezed.dart';
part 'image_caption_state.dart';

class ImageCaptionCubit extends Cubit<ImageCaptionState> {
  ImageCaptionCubit(this.useCase) : super(const ImageCaptionState.initial());
  ImageCaptionUC useCase;

  /// Replace the underlying use case at runtime (e.g., when DI changes).
  void updateUseCase(ImageCaptionUC newUseCase) {
    useCase = newUseCase;
  }

  Future<ImageCaptionState> call(Uint8List imageBytes, String filename,
      {CancelToken? cancelToken}) async {
    emit(const ImageCaptionState.loading());

    final Either<Exception, dynamic> result =
        await useCase.call(imageBytes, filename, cancelToken: cancelToken);

    ImageCaptionState terminal = const ImageCaptionState.unKnown();
    result.fold(
      (failure) {
        terminal = ImageCaptionState.failure(failure);
        emit(terminal);
      },
      (entityGroup) {
        entityGroup.when(
          success: (entity) {
            terminal = ImageCaptionState.loaded(entity);
            emit(terminal);
          },
          unKnown: () {
            terminal = const ImageCaptionState.unKnown();
            emit(terminal);
          },
        );
      },
    );

    return terminal;
  }
}
