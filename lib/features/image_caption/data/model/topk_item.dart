class TopKItem {
  final int row;
  final int col;
  final double score;

  const TopKItem({required this.row, required this.col, required this.score});

  factory TopKItem.fromList(List<dynamic> list) {
    if (list.length < 3) throw ArgumentError('TopK item must have 3 elements');
    final r = list[0] as int;
    final c = list[1] as int;
    final s = (list[2] as num).toDouble();
    return TopKItem(row: r, col: c, score: s);
  }

  factory TopKItem.fromMap(Map<String, dynamic> map) {
    final r = map['row'] as int;
    final c = map['col'] as int;
    final s = (map['score'] as num).toDouble();
    return TopKItem(row: r, col: c, score: s);
  }

  List<dynamic> toList() => [row, col, score];

  Map<String, dynamic> toMap() => {'row': row, 'col': col, 'score': score};
}
