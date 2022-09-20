import 'package:flukit/src/models/chip.dart';
import 'package:flukit/src/utils/flu_utils.dart';
import 'package:flutter/material.dart';

import 'texts.dart';
import 'image.dart';

const Clip _defaultChipClipBehavior = Clip.hardEdge;
const EdgeInsets _defaultChipPadding = const EdgeInsets.symmetric(horizontal: 20);

class FluChips extends StatelessWidget {
  /// Chips
  final List<FluChipModel> chips;

  /// Number of rows to have if this is scrollable
  final int rows;

  /// Can chips be scrolled horizontally
  /// If false they are just wrapped in parent container.
  final bool isScrollable;
  final double? chipHeight;
  final EdgeInsets chipPadding;
  final Clip chipClipBehavior;
  final TextStyle? chipTextStyle;

  const FluChips({
    super.key,
    required this.chips,
    this.rows = 3,
    this.isScrollable = true,
    this.chipHeight,
    this.chipPadding = _defaultChipPadding,
    this.chipClipBehavior = _defaultChipClipBehavior,
    this.chipTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    if (!isScrollable) {
      return Wrap(
        children: chips
            .map((e) => FluChip(
                  chip: e,
                  padding: chipPadding,
                  clipBehavior: chipClipBehavior,
                  textStyle: chipTextStyle,
                  height: chipHeight,
                ))
            .toList(),
      );
    } else {
      final int chipsPerRow = (chips.length / rows).round();
      int chipsRest = chips.length;
      List<List<FluChipModel>> chipsRows = [];

      for (var i = 0; i < rows; i++) {
        if (chipsRest > chipsPerRow) {
          List<FluChipModel> row = [];

          for (var i = 0; i < chipsPerRow; i++) {
            row.add(chips[i]);
          }
        }
      }

      print(chipsRows);

      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [],
        ),
      );
    }
  }
}

class FluChip extends StatelessWidget {
  final FluChipModel chip;
  final double? height;
  final EdgeInsets padding;
  final Clip clipBehavior;
  final TextStyle? textStyle;

  const FluChip({
    required this.chip,
    super.key,
    this.height,
    this.textStyle,
    this.clipBehavior = _defaultChipClipBehavior,
    this.padding = _defaultChipPadding,
  });

  @override
  Widget build(BuildContext context) {
    Widget child;

    child = chip.image != null
        ? FluImage(
            image: chip.image!,
            height: double.infinity,
            width: double.infinity,
          )
        : FluText(
            text: chip.text,
            customStyle: textStyle,
          );

    return Container(
      height: height ?? Flukit.appConsts.defaultChipHeight,
      width: chip.width,
      alignment: Alignment.center,
      clipBehavior: clipBehavior,
      padding: padding.copyWith(
        top: 0,
        bottom: 0,
      ),
      decoration: BoxDecoration(
        color: chip.outlined
            ? Colors.transparent
            : chip.color ?? Flukit.theme.secondaryColor.withOpacity(.25),
        border: chip.outlined
            ? Border.all(
                width: chip.strokeWidth,
                color: chip.color ?? Flukit.theme.primaryColor,
              )
            : null,
        borderRadius: BorderRadius.circular(
            (height ?? Flukit.appConsts.defaultChipHeight) * 2),
      ),
      child: child,
    );
  }
}
