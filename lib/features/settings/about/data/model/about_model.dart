import 'package:freezed_annotation/freezed_annotation.dart';

part 'about_model.freezed.dart';
part 'about_model.g.dart';

@freezed
class AboutModel with _$AboutModel {
  const factory AboutModel(
      {required String appVersion, required String platform}) = _AboutModel;

  const AboutModel._();

  factory AboutModel.fromJson(Map<String, dynamic> json) =>
      _$AboutModelFromJson(json);

  Map<String, Object?> toJsonMap() =>
      {'appVersion': appVersion, 'platform': platform};
}
