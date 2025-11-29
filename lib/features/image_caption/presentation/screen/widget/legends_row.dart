import 'package:flutter/material.dart';
import 'package:vision_xai/features/image_caption/core/utils/attention_utils.dart';

class LegendRow extends StatelessWidget {
  final List<String> tokens;
  final dynamic colorsList;
  final dynamic colorMap;

  const LegendRow(
      {super.key, required this.tokens, this.colorsList, this.colorMap});

  @override
  Widget build(BuildContext context) {
    if ((colorsList is List && colorsList.isNotEmpty) ||
        (colorMap is Map && colorMap.isNotEmpty)) {
      return Padding(
        key: const Key('attention-legend'),
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List<Widget>.generate(tokens.length, (i) {
              final tok = tokens.length > i ? tokens[i] : null;
              Color? col;
              if (colorMap is Map && tok != null) {
                col = parseHexColor(colorMap[tok] as String?);
              }
              if (col == null && colorsList is List && colorsList.length > i) {
                col = parseHexColor(colorsList[i] as String?);
              }
              col ??= Colors.grey;
              return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Row(
                  children: [
                    Container(
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                            color: col,
                            borderRadius: BorderRadius.circular(3.0),
                            border: Border.all(color: Colors.black12))),
                    const SizedBox(width: 6),
                    Text(tok ?? '—'),
                  ],
                ),
              );
            }),
          ),
        ),
      );
    }
    return const SizedBox.shrink();
  }
}
