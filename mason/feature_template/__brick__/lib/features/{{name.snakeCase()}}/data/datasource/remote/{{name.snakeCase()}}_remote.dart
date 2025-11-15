// This template emits a Retrofit interface that the consuming app can generate
// with `build_runner` + `retrofit_generator`.
// The generated implementation will be `_{{name.pascalCase()}}Remote`.
import 'package:dio/dio.dart';

import '../../model/{{name.snakeCase()}}_response_dto.dart';

/// A small Dio-backed remote implementation used by the generated repository.
/// This avoids relying on code generation for the HTTP client while keeping
/// the API surface stable: `captionImage` accepts a `MultipartFile` uploaded
/// under the `image` key and forwards the request via `Dio`.
class {{name.pascalCase()}}Remote {
  final Dio dio;
  final String? baseUrl;

  {{name.pascalCase()}}Remote(this.dio, {this.baseUrl});

  Future<{{name.pascalCase()}}ResponseDto> captionImage(MultipartFile image, {CancelToken? cancelToken}) async {
    final form = FormData.fromMap({'image': image});
    final uri = (baseUrl ?? '') + '/caption';
    final response = await dio.post(uri, data: form, cancelToken: cancelToken);
    return {{name.pascalCase()}}ResponseDto.fromJson(response.data as Map<String, dynamic>);
  }
}
