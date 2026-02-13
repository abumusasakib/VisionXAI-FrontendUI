import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:vision_xai/features/image_caption/core/utils/attention_utils.dart';
import 'package:vision_xai/features/image_caption/presentation/screen/alert/preview_dialog.dart';
import '../../../data/model/topk_item.dart';

import 'markers_widget.dart';

import 'dart:ui' as ui;

class ImageWithMarkers extends StatefulWidget {
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
  State<ImageWithMarkers> createState() => _ImageWithMarkersState();
}

class _ImageWithMarkersState extends State<ImageWithMarkers> {
  Future<ui.Image?>? _imageFuture;
  ui.Image? _lastDecodedImage;
  int _decodeRequestId = 0;

  @override
  void initState() {
    super.initState();
    _imageFuture = _decodeImage(widget.imageBytes);
  }

  @override
  void didUpdateWidget(covariant ImageWithMarkers oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.imageBytes != widget.imageBytes) {
      _lastDecodedImage?.dispose();
      _lastDecodedImage = null;
      _imageFuture = _decodeImage(widget.imageBytes);
    }
  }

  Future<ui.Image?> _decodeImage(Uint8List bytes) async {
    final requestId = ++_decodeRequestId;
    try {
      final codec = await ui.instantiateImageCodec(bytes);
      final frame = await codec.getNextFrame();
      if (requestId == _decodeRequestId) {
        _lastDecodedImage = frame.image;
        return frame.image;
      } else {
        frame.image.dispose();
        return null;
      }
    } catch (_) {
      return null;
    }
  }

  @override
  void dispose() {
    _lastDecodedImage?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ui.Image?>(
      future: _imageFuture,
      builder: (context, snapshot) {
        final decodedImage = snapshot.data;

        return LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;
            final height = constraints.maxHeight;

            // compute marker color for the selected token (if any)
            Color? selectedTokenColor;
            int? selectedIdx;
            if (widget.topk != null && widget.selectedIndex != null) {
              selectedIdx = widget.selectedIndex!;
              final token = widget.tokens.length > selectedIdx
                  ? widget.tokens[selectedIdx]
                  : null;
              if (widget.colorMap is Map && token != null) {
                selectedTokenColor = parseHexColor(
                  widget.colorMap[token] as String?,
                );
              }
              if (selectedTokenColor == null) {
                if (widget.colorsList is List &&
                    widget.colorsList.length > selectedIdx) {
                  selectedTokenColor = parseHexColor(
                    widget.colorsList[selectedIdx] as String?,
                  );
                }
              }
            }

            // If we have decoded the image intrinsic size, compute the displayed rect
            double imgW = decodedImage?.width.toDouble() ?? 0.0;
            double imgH = decodedImage?.height.toDouble() ?? 0.0;

            double imageDisplayWidth = width;
            double imageDisplayHeight = height;
            double originLeft = 0.0;
            double originTop = 0.0;

            if (imgW > 0 && imgH > 0) {
              final imgAspect = imgW / imgH;
              final containerAspect = width / height;
              if (containerAspect > imgAspect) {
                // container is wider -> image height fills container, width smaller
                imageDisplayHeight = height;
                imageDisplayWidth = height * imgAspect;
                originLeft = (width - imageDisplayWidth) / 2.0;
              } else {
                // container is taller or equal -> image width fills container
                imageDisplayWidth = width;
                imageDisplayHeight = width / imgAspect;
                originTop = (height - imageDisplayHeight) / 2.0;
              }
            }

            return GestureDetector(
              onLongPress: () =>
                  previewDialogFromBytes(context, widget.imageBytes),
              child: Stack(
                children: [
                  // Center the image; when we have intrinsic size we constrain its box so it fits exactly
                  Positioned.fill(
                    child: Center(
                      child: Image.memory(
                        widget.imageBytes,
                        width: imgW > 0 ? imageDisplayWidth : double.infinity,
                        height: imgH > 0 ? imageDisplayHeight : double.infinity,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  if (widget.topk != null && selectedIdx != null)
                    ...markersWidget(
                      context,
                      widget.topk!,
                      selectedIdx,
                      imageDisplayWidth,
                      imageDisplayHeight,
                      gridRows: widget.gridRows,
                      gridCols: widget.gridCols,
                      color: selectedTokenColor,
                      originLeft: originLeft,
                      originTop: originTop,
                      containerWidth: width,
                      containerHeight: height,
                    ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
