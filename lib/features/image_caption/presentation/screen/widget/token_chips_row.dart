import 'package:flutter/material.dart';
import 'package:vision_xai/features/image_caption/core/utils/attention_utils.dart';

typedef TokenSelectCallback = void Function(int index, bool wasSelected);

class TokenChipsRow extends StatelessWidget {
  final List<String> tokens;
  final List<double> tokenScores;
  final int? selectedIndex;
  final dynamic colorMap;
  final dynamic colorsList;
  final TokenSelectCallback onSelected;

  const TokenChipsRow({
    super.key,
    required this.tokens,
    required this.tokenScores,
    required this.selectedIndex,
    this.colorMap,
    this.colorsList,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        itemBuilder: (context, index) {
          final token = tokens.length > index ? tokens[index] : '—';
          final score = tokenScores.length > index ? tokenScores[index] : null;
          final selected = selectedIndex == index;
          Color? tokenColor;
          if (colorMap is Map) {
            final hex = colorMap[token] as String?;
            tokenColor = parseHexColor(hex);
          }
          if (tokenColor == null) {
            if (colorsList is List && colorsList.length > index) {
              tokenColor = parseHexColor(colorsList[index] as String?);
            }
          }

          return ChoiceChip(
            label: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(token),
                if (score != null) ...[
                  const SizedBox(width: 6),
                  Text(score.toStringAsFixed(3),
                      style: const TextStyle(fontSize: 12)),
                ]
              ],
            ),
            selected: selected,
            backgroundColor: tokenColor,
            selectedColor: tokenColor?.withOpacity(0.9),
            onSelected: (_) => onSelected(index, selected),
          );
        },
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemCount: tokens.length,
      ),
    );
  }
}
