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

  List<dynamic> toList() => [row, col, score];
}
