import 'package:flukit/src/models/chip.dart';
import 'package:flukit/src/utils/flu_utils.dart';
import 'package:flutter/material.dart';

import 'texts.dart';
import 'image.dart';

const Clip _defaultChipClipBehavior = Clip.hardEdge;
const EdgeInsets _defaultChipPadding = EdgeInsets.symmetric(horizontal: 20);

class FluChips extends StatefulWidget {
  /// Chips
  final List<FluChipModel> chips;

  /// Number of rows to have if this is scrollable
  final int rows;

  /// Can chips be scrolled horizontally
  /// If false they are just wrapped in parent container.
  final bool isScrollable;
  final EdgeInsets? padding;
  final double? chipHeight;
  final EdgeInsets chipPadding;
  final Clip chipClipBehavior;
  final TextStyle? chipTextStyle;
  final double spacing, runSpacing;
  final WrapCrossAlignment crossAxisAlignment;
  final VerticalDirection verticalDirection;
  final bool shuffle;
  final ScrollController? scrollController;
  final double initialScrollOffset;

  FluChips({
    super.key,
    required this.chips,
    this.rows = 3,
    this.isScrollable = true,
    this.chipHeight,
    this.chipPadding = _defaultChipPadding,
    this.chipClipBehavior = _defaultChipClipBehavior,
    this.chipTextStyle,
    this.padding,
    this.spacing = 8,
    this.runSpacing = 8,
    this.crossAxisAlignment = WrapCrossAlignment.start,
    this.verticalDirection = VerticalDirection.down,
    this.shuffle = false,
    this.scrollController,
    this.initialScrollOffset = 0.0,
  }) {
    if (shuffle) chips.shuffle();
  }

  @override
  State<FluChips> createState() => _FluChipsState();
}

class _FluChipsState extends State<FluChips> {
  late EdgeInsets padding;
  late ScrollController scrollController;

  void initScroll() => scrollController.animateTo(widget.initialScrollOffset,
      duration: Flukit.appConsts.defaultAnimationDuration,
      curve: Flukit.appConsts.defaultAnimationCurve);

  @override
  void initState() {
    padding = widget.padding ??
        EdgeInsets.symmetric(horizontal: Flukit.appConsts.defaultPaddingSize);
    scrollController = widget.scrollController ?? ScrollController();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => initScroll());
  }

  @override
  void didUpdateWidget(covariant FluChips oldWidget) {
    initScroll();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isScrollable) {
      return Padding(
        padding: padding,
        child: Wrap(
          spacing: widget.spacing,
          runSpacing: widget.runSpacing,
          crossAxisAlignment: widget.crossAxisAlignment,
          verticalDirection: widget.verticalDirection,
          children: widget.chips
              .map(
                (e) => FluChip(
                  chip: e,
                  padding: widget.chipPadding,
                  clipBehavior: widget.chipClipBehavior,
                  textStyle: widget.chipTextStyle,
                  height: widget.chipHeight,
                ),
              )
              .toList(),
        ),
      );
    } else {
      final int chipsPerRow = (widget.chips.length / widget.rows).round();
      List<List<FluChipModel>> chipsRows = [];

      int chipsRest = widget.chips.length;

      for (var i = 0; i < widget.rows; i++) {
        if (widget.chips.length > chipsPerRow) {
          List<FluChipModel> row = [];
          int rangeStart = i * chipsPerRow, rangelimit = (i + 1) * chipsPerRow;

          bool mustTaketherest = (chipsRest - chipsPerRow) <= 1;
          rangelimit = mustTaketherest || (rangelimit > widget.chips.length)
              ? widget.chips.length
              : rangelimit;

          List<FluChipModel> range =
              widget.chips.getRange(rangeStart, rangelimit).toList();

          for (var j = 0; j < range.length; j++) {
            row.add(range[j]);
          }

          chipsRows.add(row);
          chipsRest -= range.length;
          if (mustTaketherest) break;
        }
      }

      return SingleChildScrollView(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        padding: padding,
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: chipsRows
              .map((row) => Padding(
                    padding: EdgeInsets.only(
                        top: chipsRows.indexOf(row) == 0 ? 0 : widget.runSpacing),
                    child: Row(
                      children: row
                          .map((chip) => FluChip(
                                chip: chip,
                                padding: widget.chipPadding,
                                clipBehavior: widget.chipClipBehavior,
                                textStyle: widget.chipTextStyle,
                                height: widget.chipHeight,
                                margin: EdgeInsets.only(
                                    left:
                                        row.indexOf(chip) == 0 ? 0 : widget.spacing),
                              ))
                          .toList(),
                    ),
                  ))
              .toList(),
        ),
      );
    }
  }
}

class FluChip extends StatelessWidget {
  final FluChipModel chip;
  final double? height;
  final EdgeInsets padding, margin;
  final Clip clipBehavior;
  final TextStyle? textStyle;

  const FluChip({
    required this.chip,
    super.key,
    this.height,
    this.textStyle,
    this.clipBehavior = _defaultChipClipBehavior,
    this.padding = _defaultChipPadding,
    this.margin = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    Widget child;
    double? _width = (chip.image != null && chip.text == null)
        ? Flukit.appConsts.defaultChipHeight * 2
        : null;

    child = chip.image != null
        ? FluImage(
            image: chip.image!,
            source: chip.imageSource,
            height: double.infinity,
            width: double.infinity,
          )
        : FluText(
            text: chip.text,
            customStyle: textStyle?.merge(chip.textStyle) ?? chip.textStyle,
          );

    return UnconstrainedBox(
      child: Container(
        height: height ?? Flukit.appConsts.defaultChipHeight,
        width: chip.width ?? _width,
        alignment: Alignment.center,
        clipBehavior: clipBehavior,
        padding: chip.image == null
            ? padding.copyWith(
                top: 0,
                bottom: 0,
              )
            : EdgeInsets.zero,
        margin: margin,
        decoration: BoxDecoration(
          color: chip.outlined
              ? Colors.transparent
              : chip.color ?? Flukit.theme.secondaryColor.withOpacity(.25),
          border: chip.outlined
              ? Border.all(
                  width: chip.strokeWidth,
                  color: chip.color ?? Flukit.theme.secondaryColor.withOpacity(.5),
                )
              : null,
          borderRadius: BorderRadius.circular(
              (height ?? Flukit.appConsts.defaultChipHeight) * 2),
        ),
        child: child,
      ),
    );
  }
}
