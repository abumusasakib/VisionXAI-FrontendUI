import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../domain/entity/{{name.snakeCase()}}_entity.dart';
import '../../domain/use_case/{{name.snakeCase()}}_uc.dart';

part '{{name.snakeCase()}}_cubit.freezed.dart';
part '{{name.snakeCase()}}_state.dart';

class {{name.pascalCase()}}Cubit extends Cubit<{{name.pascalCase()}}State> {
  {{name.pascalCase()}}Cubit(this.useCase) : super(const {{name.pascalCase()}}State.initial());
  final {{name.pascalCase()}}UC useCase;

  Future<void> call(Uint8List imageBytes, String filename, {CancelToken? cancelToken}) async {
    emit(const {{name.pascalCase()}}State.loading());

    final Either<Exception, dynamic> result = await useCase.call(imageBytes, filename, cancelToken: cancelToken);
    result.fold(
      (failure) => emit({{name.pascalCase()}}State.failure(failure)),
      (entityGroup) {
        entityGroup.when(
          success: (entity) => emit({{name.pascalCase()}}State.loaded(entity)),
          unKnown: () => emit(const {{name.pascalCase()}}State.unKnown()),
        );
      },
    );
  }
}
