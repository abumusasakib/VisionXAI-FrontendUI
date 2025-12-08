import 'package:freezed_annotation/freezed_annotation.dart';

part 'about_entity.freezed.dart';
part 'about_entity.g.dart';

@freezed
class AboutEntity with _$AboutEntity {
  const factory AboutEntity(
      {required String appVersion, required String platform}) = _AboutEntity;

  const AboutEntity._();

  factory AboutEntity.fromJson(Map<String, dynamic> json) =>
      _$AboutEntityFromJson(json);
}
