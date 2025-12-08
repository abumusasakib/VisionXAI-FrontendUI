// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topk_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TopKItemImpl _$$TopKItemImplFromJson(Map<String, dynamic> json) =>
    _$TopKItemImpl(
      row: (json['row'] as num).toInt(),
      col: (json['col'] as num).toInt(),
      score: (json['score'] as num).toDouble(),
    );

Map<String, dynamic> _$$TopKItemImplToJson(_$TopKItemImpl instance) =>
    <String, dynamic>{
      'row': instance.row,
      'col': instance.col,
      'score': instance.score,
    };
