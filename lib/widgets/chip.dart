import 'package:flutter/material.dart';
import '../utils/flu_utils.dart';
import 'image.dart';

const double _defaultChipHeight = 62;
const Clip _defaultChipClipBehavior = Clip.hardEdge;
const EdgeInsets _defaultChipPadding = EdgeInsets.symmetric(horizontal: 20);

class FluChips extends StatefulWidget {
  const FluChips({
    super.key,
    required this.chips,
    this.rows = 3,
    this.isScrollable = true,
    this.chipClipBehavior = _defaultChipClipBehavior,
    this.padding,
    this.spacing = 8,
    this.runSpacing = 8,
    this.crossAxisAlignment = WrapCrossAlignment.start,
    this.verticalDirection = VerticalDirection.down,
    this.shuffle = false,
    this.scrollController,
    this.initialScrollOffset = 0.0,
    this.animationCurve = Curves.decelerate,
    this.animationDuration = const Duration(milliseconds: 300),
  });

  final Curve animationCurve;
  final Duration animationDuration;
  final Clip chipClipBehavior;
  final List<FluChip> chips;
  final WrapCrossAlignment crossAxisAlignment;
  final double initialScrollOffset;
  final EdgeInsets? padding;
  final double spacing, runSpacing;
  final ScrollController? scrollController;
  final bool shuffle;
  final VerticalDirection verticalDirection;

  /// Can chips be scrolled horizontally
  /// If false they are just wrapped in parent container.
  final bool isScrollable;

  /// Number of rows to have if this is scrollable
  final int rows;

  @override
  State<FluChips> createState() => _FluChipsState();
}

class _FluChipsState extends State<FluChips> {
  late EdgeInsets padding;
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
        padding: padding,
        child: Wrap(
          spacing: widget.spacing,
          runSpacing: widget.runSpacing,
          crossAxisAlignment: widget.crossAxisAlignment,
          verticalDirection: widget.verticalDirection,
          children: widget.chips,
        ),
      );
    } else {
      final int chipsPerRow = (widget.chips.length / widget.rows).round();
      int chipsRest = widget.chips.length;
      List<List<Widget>> chipsRows = [];

      for (var i = 0; i < widget.rows; i++) {
        if (widget.chips.length > chipsPerRow) {
          List<Widget> row = [];
          int rangeStart = i * chipsPerRow, rangeLimit = (i + 1) * chipsPerRow;

          bool mustTakeTheRest = (chipsRest - chipsPerRow) <= 1;
          rangeLimit = mustTakeTheRest || (rangeLimit > widget.chips.length)
              ? widget.chips.length
              : rangeLimit;

          List<Widget> range =
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
        padding: padding,
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
                    child: Row(children: row),
                  ))
              .toList(),
        ),
      );
    }
  }
}

class FluChip extends StatelessWidget {
  const FluChip({
    super.key,
    this.height,
    this.textStyle,
    this.clipBehavior = _defaultChipClipBehavior,
    this.padding = _defaultChipPadding,
    this.margin = EdgeInsets.zero,
    this.text,
    this.image,
    required this.imageSource,
    required this.outlined,
    required this.strokeWidth,
    this.width,
    this.color,
  }) : assert(text != null || image != null);

  final Clip clipBehavior;
  final Color? color;
  final double? height;
  final EdgeInsets margin;
  final bool outlined;
  final EdgeInsets padding;
  final double strokeWidth;
  final TextStyle? textStyle;
  final double? width;

  /// Chip image
  final String? image;

  /// where to get image from.
  /// Default is set to network.
  final ImageSources imageSource;

  /// Text to display in the
  final String? text;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Flu.getColorSchemeOf(context);
    final double? width =
        (image != null && text == null) ? _defaultChipHeight * 2 : null;
    late final Widget child;

    child = image != null
        ? FluImage(
            image!,
            imageSource: imageSource,
            height: double.infinity,
            width: double.infinity,
          )
        : Text(
            text!,
            style: textStyle?.merge(textStyle) ?? textStyle,
          );

    return UnconstrainedBox(
      child: Container(
        height: height ?? _defaultChipHeight,
        width: width ?? width,
        alignment: Alignment.center,
        clipBehavior: clipBehavior,
        padding: image == null
            ? padding.copyWith(
                top: 0,
                bottom: 0,
              )
            : EdgeInsets.zero,
        margin: margin,
        decoration: BoxDecoration(
          color: outlined
              ? Colors.transparent
              : color ?? colorScheme.surfaceVariant,
          border: outlined
              ? Border.all(
                  width: strokeWidth,
                  color: color ?? colorScheme.surfaceVariant,
                )
              : null,
          borderRadius:
              BorderRadius.circular((height ?? _defaultChipHeight) * 2),
        ),
        child: child,
      ),
    );
  }
}
