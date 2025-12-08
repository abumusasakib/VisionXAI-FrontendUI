import 'package:freezed_annotation/freezed_annotation.dart';

part 'topk_item.freezed.dart';
part 'topk_item.g.dart';

@freezed
class TopKItem with _$TopKItem {
  const factory TopKItem(
      {required int row, required int col, required double score}) = _TopKItem;

  const TopKItem._();

  factory TopKItem.fromList(List<dynamic> list) {
    if (list.length < 3) throw ArgumentError('TopK item must have 3 elements');
    final r = (list[0] as num).toInt();
    final c = (list[1] as num).toInt();
    final s = (list[2] as num).toDouble();
    return TopKItem(row: r, col: c, score: s);
  }

  factory TopKItem.fromMap(Map<String, dynamic> map) {
    final r = (map['row'] as num).toInt();
    final c = (map['col'] as num).toInt();
    final s = (map['score'] as num).toDouble();
    return TopKItem(row: r, col: c, score: s);
  }

  List<dynamic> toList() => [row, col, score];

  Map<String, dynamic> toMap() => {'row': row, 'col': col, 'score': score};

  factory TopKItem.fromJson(Map<String, dynamic> json) =>
      _$TopKItemFromJson(json);
}
