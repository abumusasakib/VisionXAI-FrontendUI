import 'package:freezed_annotation/freezed_annotation.dart';

import '{{name.snakeCase()}}_entity.dart';

part '{{name.snakeCase()}}_entity_group.freezed.dart';

@freezed
class {{name.pascalCase()}}EntityGroup with _${{name.pascalCase()}}EntityGroup {
  const factory {{name.pascalCase()}}EntityGroup.success({{name.pascalCase()}}Entity entity
  ) = _Success;
  const factory {{name.pascalCase()}}EntityGroup.unKnown() = _Unknown;
    //TODO write other factory 
}
