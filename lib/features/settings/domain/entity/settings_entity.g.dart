// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SettingsEntity _$SettingsEntityFromJson(Map<String, dynamic> json) =>
    _SettingsEntity(
      ip: json['ip'] as String,
      port: json['port'] as String,
      locale: json['locale'] as String,
    );

Map<String, dynamic> _$SettingsEntityToJson(_SettingsEntity instance) =>
    <String, dynamic>{
      'ip': instance.ip,
      'port': instance.port,
      'locale': instance.locale,
    };
