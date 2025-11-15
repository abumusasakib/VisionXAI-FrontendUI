part of '{{name.snakeCase()}}_cubit.dart';


@freezed
class {{name.pascalCase()}}State with _${{name.pascalCase()}}State {
  const factory {{name.pascalCase()}}State.initial() = _Initial;
  const factory {{name.pascalCase()}}State.loading() = _Loading;
  const factory {{name.pascalCase()}}State.loaded({{name.pascalCase()}}Entity entity) = _Loaded;
  const factory {{name.pascalCase()}}State.failure(Object error) = _Failure;
  const factory {{name.pascalCase()}}State.unKnown() = _Unknown;
}
