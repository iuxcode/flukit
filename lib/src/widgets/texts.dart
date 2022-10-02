import 'package:flutter/material.dart';

import '../utils/flu_utils.dart';

/// Use [AutoSizeText] creates a [Text] widget.
/// If the [style] argument is null, the text will use the style from the closest enclosing [DefaultTextStyle].

class FluText extends StatelessWidget {
  final String? text;
  final List<TextSpan>? entities;

  final FluTextStyle stylePreset;
  final TextStyle? style;

  final FluTextStyleApplicationMethod applicationMethod;

  final int? maxLines;
  final double? minFontSize;
  final double maxFontSize;
  final double stepGranularity;

  final TextOverflow overflow;

  final List<TextSpan> prefixs, suffixs;

  final TextAlign textAlign;

  final bool replaceEmojis, mergestyleBefore;
  // final AutoSizeGroup? group;
  final List<double>? presetFontSizes;

  final Widget? overflowReplacement;

  const FluText({
    super.key,
    this.text,
    this.entities,
    this.stylePreset = FluTextStyle.body,
    this.style,
    this.applicationMethod = FluTextStyleApplicationMethod.merge,
    this.maxLines,
    this.overflow = TextOverflow.clip,
    this.prefixs = const [],
    this.suffixs = const [],
    this.textAlign = TextAlign.start,
    this.replaceEmojis = true,
    this.mergestyleBefore = true,
    this.minFontSize,
    this.maxFontSize = double.infinity,
    // this.group,
    this.stepGranularity = 1,
    this.presetFontSizes,
    this.overflowReplacement,
  });

  /// Default [TextStyle]
  TextStyle get _defaultTextStyle => Flukit.textTheme.bodyText1!;

  /// Return neptune font styling for text
  TextStyle? get _neptuneStyle {
    switch (stylePreset) {
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
      return style ?? _defaultTextStyle;
    } else {
      TextStyle? textStyle;

      switch (stylePreset) {
        case FluTextStyle.small:
        case FluTextStyle.smallBold:
        case FluTextStyle.smallNeptune:
          textStyle = Flukit.textTheme.bodyText1
              ?.copyWith(fontSize: Flukit.appSettings.smallFs);
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
              fontSize: Flukit.appSettings.headlineFs,
              fontWeight: Flukit.appSettings.textBold,
              color: Flukit.theme.accentTextColor);
          break;
      }

      if (stylePreset == FluTextStyle.smallNeptune ||
          stylePreset == FluTextStyle.bodyNeptune) {
        textStyle = textStyle?.merge(_neptuneStyle);
      }

      if (stylePreset == FluTextStyle.smallBold ||
          stylePreset == FluTextStyle.bodyBold ||
          stylePreset == FluTextStyle.headlineBold) {
        textStyle = textStyle?.merge(TextStyle(
            fontWeight: Flukit.appSettings.textBold,
            color: Flukit.theme.accentTextColor));
      }

      return textStyle ?? _defaultTextStyle;
    }
  }

  @override
  Widget build(BuildContext context) {
    bool hasText = text?.isNotEmpty ?? false;

    List<TextSpan> textSpans = entities != null
        ? entities!.map((e) {
            return TextSpan(
              text: e.text,
              recognizer: e.recognizer,
              style: _style
                  .merge(mergestyleBefore ? style : e.style)
                  .merge(mergestyleBefore ? e.style : style),
            );
          }).toList()
        : [
            TextSpan(
              text: hasText ? text : 'You have to add text or entities !',
              style: _style
                  .merge(style)
                  .copyWith(color: hasText ? null : Flukit.theme.dangerColor),
            )
          ];

    return RichText(
      text: TextSpan(
        children: prefixs +
            (replaceEmojis
                ? textSpans.map((span) => Flukit.replaceEmojis(span)).toList()
                : textSpans) +
            suffixs,
      ),
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
      /* minFontSize: minFontSize ?? Flukit.appSettings.smallFs,
      maxFontSize: maxFontSize,
      group: group,
      stepGranularity: stepGranularity,
      presetFontSizes: presetFontSizes,
      overflowReplacement: overflowReplacement, */
    );
  }
}

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
  headlineBold,
}

enum FluTextStyleApplicationMethod {
  override,
  merge,
}
