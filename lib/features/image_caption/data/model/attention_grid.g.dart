// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attention_grid.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AttentionGrid _$AttentionGridFromJson(Map<String, dynamic> json) =>
    _AttentionGrid(
      rows: (json['rows'] as num).toInt(),
      cols: (json['cols'] as num).toInt(),
    );

Map<String, dynamic> _$AttentionGridToJson(_AttentionGrid instance) =>
    <String, dynamic>{'rows': instance.rows, 'cols': instance.cols};
