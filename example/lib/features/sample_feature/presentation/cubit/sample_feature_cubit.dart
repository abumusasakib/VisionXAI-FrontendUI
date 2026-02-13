import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../domain/entity/sample_feature_entity.dart';
import '../../domain/use_case/sample_feature_uc.dart';

part 'sample_feature_cubit.freezed.dart';
part 'sample_feature_state.dart';

class SampleFeatureCubit extends Cubit<SampleFeatureState> {
  SampleFeatureCubit(this.useCase) : super(const SampleFeatureState.initial());
  final SampleFeatureUC useCase;

  Future<void> call(Uint8List imageBytes, String filename, {CancelToken? cancelToken}) async {
    emit(const SampleFeatureState.loading());

    final Either<Exception, dynamic> result = await useCase.call(imageBytes, filename, cancelToken: cancelToken);
    result.fold(
      (failure) => emit(SampleFeatureState.failure(failure)),
      (entityGroup) {
        entityGroup.when(
          success: (entity) => emit(SampleFeatureState.loaded(entity)),
          unKnown: () => emit(const SampleFeatureState.unKnown()),
        );
      },
    );
  }
}
