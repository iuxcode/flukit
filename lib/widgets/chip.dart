import 'package:flutter/material.dart';
import '../models/chip.model.dart';
import '../utils/flu_utils.dart';
import 'image.dart';

const double _defaultChipHeight = 62;
const Clip _defaultChipClipBehavior = Clip.hardEdge;
const EdgeInsets _defaultChipPadding = EdgeInsets.symmetric(horizontal: 20);

class FluChips extends StatefulWidget {
  FluChips({
    super.key,
    required this.chips,
    this.rows = 3,
    this.isScrollable = true,
    this.chipHeight = _defaultChipHeight,
    this.chipPadding = _defaultChipPadding,
    this.chipClipBehavior = _defaultChipClipBehavior,
    this.chipTextStyle,
    this.padding = EdgeInsets.zero,
    this.spacing = 8,
    this.runSpacing = 8,
    this.crossAxisAlignment = WrapCrossAlignment.start,
    this.verticalDirection = VerticalDirection.down,
    this.shuffle = false,
    this.scrollController,
    this.initialScrollOffset = 0.0,
    this.animationCurve = Curves.decelerate,
    this.animationDuration = const Duration(milliseconds: 300),
  }) {
    if (shuffle) chips.shuffle();
  }

  final Curve animationCurve;
  final Duration animationDuration;
  final Clip chipClipBehavior;
  final double chipHeight;
  final EdgeInsets chipPadding;
  final TextStyle? chipTextStyle;
  final WrapCrossAlignment crossAxisAlignment;
  final double initialScrollOffset;
  final EdgeInsets padding;
  final double spacing, runSpacing;
  final ScrollController? scrollController;
  final bool shuffle;
  final VerticalDirection verticalDirection;

  /// Chips
  final List<FluChipModel> chips;

  /// Can chips be scrolled horizontally
  /// If false they are just wrapped in parent container.
  final bool isScrollable;

  /// Number of rows to have if this is scrollable
  final int rows;

  @override
  State<FluChips> createState() => _FluChipsState();
}

class _FluChipsState extends State<FluChips> {
  late ScrollController scrollController;

  @override
  void didUpdateWidget(covariant FluChips oldWidget) {
    initScroll();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    scrollController = widget.scrollController ?? ScrollController();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => initScroll());
  }

  void initScroll() => scrollController.animateTo(widget.initialScrollOffset,
      duration: widget.animationDuration, curve: widget.animationCurve);

  @override
  Widget build(BuildContext context) {
    if (!widget.isScrollable) {
      return Padding(
        padding: widget.padding,
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
          int rangeStart = i * chipsPerRow, rangeLimit = (i + 1) * chipsPerRow;

          bool mustTakeTheRest = (chipsRest - chipsPerRow) <= 1;
          rangeLimit = mustTakeTheRest || (rangeLimit > widget.chips.length)
              ? widget.chips.length
              : rangeLimit;

          List<FluChipModel> range =
              widget.chips.getRange(rangeStart, rangeLimit).toList();

          for (var j = 0; j < range.length; j++) {
            row.add(range[j]);
          }

          chipsRows.add(row);
          chipsRest -= range.length;
          if (mustTakeTheRest) break;
        }
      }

      return SingleChildScrollView(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        padding: widget.padding,
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: chipsRows
              .map((row) => Padding(
                    padding: EdgeInsets.only(
                        top: chipsRows.indexOf(row) == 0
                            ? 0
                            : widget.runSpacing),
                    child: Row(
                      children: row
                          .map((chip) => FluChip(
                                chip: chip,
                                padding: widget.chipPadding,
                                clipBehavior: widget.chipClipBehavior,
                                textStyle: widget.chipTextStyle,
                                height: widget.chipHeight,
                                margin: EdgeInsets.only(
                                    left: row.indexOf(chip) == 0
                                        ? 0
                                        : widget.spacing),
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
  const FluChip({
    required this.chip,
    super.key,
    this.height = _defaultChipHeight,
    this.textStyle,
    this.clipBehavior = _defaultChipClipBehavior,
    this.padding = _defaultChipPadding,
    this.margin = EdgeInsets.zero,
  });

  final FluChipModel chip;
  final Clip clipBehavior;
  final double height;
  final EdgeInsets padding, margin;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final double? width =
        (chip.image != null && chip.text == null) ? height * 2 : null;
    late final Widget child;

    child = chip.image != null
        ? FluImage(
            chip.image!,
            imageSource: chip.imageSource,
            height: double.infinity,
            width: double.infinity,
          )
        : Text(
            chip.text!,
            style: textStyle?.merge(chip.textStyle) ?? chip.textStyle,
          );

    return UnconstrainedBox(
      child: Container(
        height: height,
        width: chip.width ?? width,
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
              : chip.color ??
                  context.colorScheme.surfaceVariant.withOpacity(.65),
          border: chip.outlined
              ? Border.all(
                  width: chip.strokeWidth,
                  color: chip.color ??
                      context.colorScheme.surfaceVariant.withOpacity(.65),
                )
              : null,
          borderRadius: BorderRadius.circular(height * 2),
        ),
        child: child,
      ),
    );
  }
}
