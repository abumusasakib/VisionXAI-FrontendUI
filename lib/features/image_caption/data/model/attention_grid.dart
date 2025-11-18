class AttentionGrid {
  final int rows;
  final int cols;

  const AttentionGrid({required this.rows, required this.cols});

  factory AttentionGrid.fromList(List<dynamic> list) {
    if (list.length < 2) throw ArgumentError('List must contain two ints');
    return AttentionGrid(
        rows: (list[0] as num).toInt(), cols: (list[1] as num).toInt());
  }

  factory AttentionGrid.fromMap(Map<String, dynamic> map) {
    return AttentionGrid(
        rows: (map['rows'] as num).toInt(), cols: (map['cols'] as num).toInt());
  }

  List<int> toList() => [rows, cols];

  Map<String, int> toMap() => {'rows': rows, 'cols': cols};
}
