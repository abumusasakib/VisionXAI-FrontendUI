import 'package:dio/dio.dart';

import '../../model/image_caption_response_dto.dart';

class ImageCaptionRemote {
  final Dio dio;
  final String? baseUrl;

  ImageCaptionRemote(this.dio, {this.baseUrl});

  Future<ImageCaptionResponseDto> captionImage(MultipartFile image,
      {CancelToken? cancelToken}) async {
    final form = FormData.fromMap({'image': image});
    final uri = '${baseUrl ?? ''}/caption';
    final response = await dio.post(uri, data: form, cancelToken: cancelToken);
    final body = response.data as Map<String, dynamic>;
    return ImageCaptionResponseDto.fromMap(body);
  }
}
