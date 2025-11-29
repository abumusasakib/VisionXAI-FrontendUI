import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:vision_xai/features/image_caption/core/utils/attention_utils.dart';
import '../../../data/model/topk_item.dart';
import 'image_display.dart';
import 'markers_widget.dart';

class ImageWithMarkers extends StatelessWidget {
  final Uint8List imageBytes;
  final List<List<TopKItem>>? topk;
  final int? selectedIndex;
  final List<String> tokens;
  final dynamic colorMap;
  final dynamic colorsList;
  final int? gridRows;
  final int? gridCols;

  const ImageWithMarkers({
    super.key,
    required this.imageBytes,
    required this.topk,
    required this.selectedIndex,
    required this.tokens,
    this.colorMap,
    this.colorsList,
    this.gridRows,
    this.gridCols,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: LayoutBuilder(builder: (context, constraints) {
        final width = constraints.maxWidth;
        final height = constraints.maxHeight;

        // compute marker color for the selected token (if any)
        Color? selectedTokenColor;
        int? selectedIdx;
        if (topk != null && selectedIndex != null) {
          selectedIdx = selectedIndex!;
          final token =
              tokens.length > selectedIdx ? tokens[selectedIdx] : null;
          if (colorMap is Map && token != null) {
            selectedTokenColor = parseHexColor(colorMap[token] as String?);
          }
          if (selectedTokenColor == null) {
            if (colorsList is List && colorsList.length > selectedIdx) {
              selectedTokenColor =
                  parseHexColor(colorsList[selectedIdx] as String?);
            }
          }
        }

        return Stack(
          children: [
            Positioned.fill(child: imageWidgetFromBytes(context, imageBytes)),
            if (topk != null && selectedIdx != null)
              ...markersWidget(context, topk!, selectedIdx, width, height,
                  gridRows: gridRows,
                  gridCols: gridCols,
                  color: selectedTokenColor),
          ],
        );
      }),
    );
  }
}
