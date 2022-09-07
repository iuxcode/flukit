import 'package:flutter/material.dart';

import '../utils/flu_utils.dart';
import 'line.dart';

/// TODO add more styles
enum FluTextStyle {
  small,
  smallBold,
  smallNeptune,
  body,
  bodyBold,
  bodyNeptune,
  headline,
  headlineSemibold,
  headlineBold
}

enum FluTextStyleApplicationMethod { override, merge }

class FluText extends StatelessWidget {
  final String? text;
  final List<TextSpan>? entities;
  final FluTextStyle style;
  final TextStyle? customStyle;
  final FluTextStyleApplicationMethod applicationMethod;
  final int? maxLines;
  final TextOverflow overflow;
  final List<TextSpan> prefixs, suffixs;
  final TextAlign textAlign;
  final bool replaceEmojis;

  const FluText({
    super.key,
    this.text,
    this.entities,
    this.style = FluTextStyle.body,
    this.customStyle,
    this.applicationMethod = FluTextStyleApplicationMethod.merge,
    this.maxLines,
    this.overflow = TextOverflow.clip,
    this.prefixs = const [],
    this.suffixs = const [],
    this.textAlign = TextAlign.start,
    this.replaceEmojis = true,
  });

  /// Default [TextStyle]
  TextStyle get _defaultTextStyle => Flukit.textTheme.bodyText1!;

  /// Return neptune font styling for text
  TextStyle? get _neptuneStyle {
    switch (style) {
      case FluTextStyle.body:
      case FluTextStyle.small:
      case FluTextStyle.headline:
      case FluTextStyle.smallBold:
      case FluTextStyle.bodyBold:
      case FluTextStyle.headlineSemibold:
      case FluTextStyle.headlineBold:
        return null;
      case FluTextStyle.smallNeptune:
      case FluTextStyle.bodyNeptune:
        return TextStyle(fontFamily: Flukit.fonts.neptune, package: 'flukit');
    }
  }

  /// Build styles
  TextStyle get _style {
    if (applicationMethod == FluTextStyleApplicationMethod.override) {
      return customStyle ?? _defaultTextStyle;
    } else {
      TextStyle? textStyle;

      switch (style) {
        case FluTextStyle.small:
        case FluTextStyle.smallBold:
        case FluTextStyle.smallNeptune:
          textStyle = Flukit.textTheme.bodyText1
              ?.copyWith(fontSize: Flukit.appConsts.smallFs);
          break;
        case FluTextStyle.body:
        case FluTextStyle.bodyBold:
        case FluTextStyle.bodyNeptune:
          textStyle = Flukit.textTheme.bodyText1;
          break;
        case FluTextStyle.headline:
        case FluTextStyle.headlineBold:
          textStyle = Flukit.textTheme.headline1;
          break;
        case FluTextStyle.headlineSemibold:
          textStyle = Flukit.textTheme.bodyText1?.copyWith(
              fontSize: Flukit.appConsts.headlineFs,
              fontWeight: Flukit.appConsts.textBold,
              color: Flukit.theme.accentTextColor);
          break;
      }

      if (style == FluTextStyle.smallNeptune || style == FluTextStyle.bodyNeptune) {
        textStyle = textStyle?.merge(_neptuneStyle);
      }

      if (style == FluTextStyle.smallBold ||
          style == FluTextStyle.bodyBold ||
          style == FluTextStyle.headlineBold) {
        textStyle = textStyle?.merge(TextStyle(
            fontWeight: Flukit.appConsts.textBold,
            color: Flukit.theme.accentTextColor));
      }

      return textStyle ?? _defaultTextStyle;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<TextSpan> textSpans;

    if (entities != null) {
      textSpans = entities!
          .map((e) => TextSpan(
                text: e.text,
                recognizer: e.recognizer,
                style: _style.merge(customStyle).merge(e.style),
              ))
          .toList();
    } else {
      bool hasText = text?.isNotEmpty ?? false;

      textSpans = [
        TextSpan(
          text: hasText ? text : 'You have to add text or entities !',
          style: _style
              .merge(customStyle)
              .copyWith(color: hasText ? null : Flukit.theme.dangerColor),
        )
      ];
    }

    return RichText(
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
      text: TextSpan(
        children: prefixs +
            (replaceEmojis
                ? textSpans.map((span) => Flukit.replaceEmojis(span)).toList()
                : textSpans) +
            suffixs,
      ),
    );
  }
}

class FluTextWithLine extends StatelessWidget {
  final String text1, text2;
  final double lineHeight, lineWidth;
  final double? fontsize;

  const FluTextWithLine({
    Key? key,
    required this.text1,
    required this.text2,
    this.lineHeight = 2,
    this.lineWidth = 50,
    this.fontsize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Hero(
        tag: Flukit.appConsts.titleTextHeroTag,
        child: Text(text1,
            style: Flukit.textTheme.bodyText1!.copyWith(
                fontSize: fontsize ?? Flukit.appConsts.headlineFs,
                fontWeight: Flukit.appConsts.textSemibold,
                color: Flukit.theme.accentTextColor)),
      ),
      Row(
        children: [
          Hero(
            tag: Flukit.appConsts.title2TextHeroTag,
            child: Text(text2,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Flukit.textTheme.bodyText1!.copyWith(
                    fontSize: fontsize ?? Flukit.appConsts.headlineFs,
                    fontWeight: Flukit.appConsts.textSemibold,
                    color: Flukit.theme.accentTextColor)),
          ),
          FluLine(
            height: lineHeight,
            width: lineWidth,
            margin: const EdgeInsets.only(left: 10),
          )
        ],
      ),
    ]);
  }
}
