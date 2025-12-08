import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings_entity.freezed.dart';
part 'settings_entity.g.dart';

@freezed
class SettingsEntity with _$SettingsEntity {
  const factory SettingsEntity(
      {required String ip,
      required String port,
      required String locale}) = _SettingsEntity;

  const SettingsEntity._();

  @override
  Map<String, dynamic> toJson() => {'ip': ip, 'port': port, 'locale': locale};

  factory SettingsEntity.fromJson(Map<String, dynamic> json) =>
      _$SettingsEntityFromJson(json);
}
