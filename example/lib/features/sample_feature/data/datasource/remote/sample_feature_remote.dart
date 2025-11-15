// This template emits a Retrofit interface that the consuming app can generate
// with `build_runner` + `retrofit_generator`.
// The generated implementation will be `_SampleFeatureRemote`.
import 'package:dio/dio.dart';

import '../../model/sample_feature_response_dto.dart';

class SampleFeatureRemote {
  final Dio dio;
  final String? baseUrl;

  SampleFeatureRemote(this.dio, {this.baseUrl});

  Future<SampleFeatureResponseDto> captionImage(MultipartFile image,
      {CancelToken? cancelToken}) async {
    final form = FormData.fromMap({'image': image});
    final uri = (baseUrl ?? '') + '/caption';
    final response = await dio.post(uri, data: form, cancelToken: cancelToken);
    return SampleFeatureResponseDto.fromJson(
        response.data as Map<String, dynamic>);
  }
}
