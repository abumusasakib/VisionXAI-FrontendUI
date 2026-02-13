// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topk_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TopKItem _$TopKItemFromJson(Map<String, dynamic> json) => _TopKItem(
  row: (json['row'] as num).toInt(),
  col: (json['col'] as num).toInt(),
  score: (json['score'] as num).toDouble(),
);

Map<String, dynamic> _$TopKItemToJson(_TopKItem instance) => <String, dynamic>{
  'row': instance.row,
  'col': instance.col,
  'score': instance.score,
};
