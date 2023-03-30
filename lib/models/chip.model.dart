import 'package:flutter/material.dart';

import '../widgets/image.dart';

class FluChipModel {
  FluChipModel({
    this.text,
    this.image,
    this.imageSource = ImageSources.network,
    this.type = FluChipType.base,
    this.textStyle,
    this.outlined = false,
    this.strokeWidth = 1.5,
    this.color,
    this.width,
    this.padding,
  }) : assert(image != null || text != null);

  final Color? color;
  final bool outlined;
  final EdgeInsets? padding;
  final double strokeWidth;
  final TextStyle? textStyle;
  final double? width;

  /// Chip image
  /// Can be user avatar, if [FluChipType]
  final String? image;

  /// where to get image from.
  /// Default is set to network.
  final ImageSources imageSource;

  /// Text to display in the chip.
  final String? text;

  /// Chip type
  final FluChipType type;
}

enum FluChipType {
  base,
  avatar,
}
