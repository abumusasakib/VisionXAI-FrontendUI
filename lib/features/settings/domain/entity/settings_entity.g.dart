// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SettingsEntityImpl _$$SettingsEntityImplFromJson(Map<String, dynamic> json) =>
    _$SettingsEntityImpl(
      ip: json['ip'] as String,
      port: json['port'] as String,
      locale: json['locale'] as String,
    );

Map<String, dynamic> _$$SettingsEntityImplToJson(
        _$SettingsEntityImpl instance) =>
    <String, dynamic>{
      'ip': instance.ip,
      'port': instance.port,
      'locale': instance.locale,
    };
