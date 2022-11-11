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

  /// Build styles
  TextStyle get _style {
    TextStyle defaultTextStyle = Flu.textTheme.bodyText1!;

    if (applicationMethod == FluTextStyleApplicationMethod.override) {
      return style ?? defaultTextStyle;
    } else {
      TextStyle neptuneStyle =
          TextStyle(fontFamily: FluFonts.neptune.name, package: 'flukit');

      if (stylePreset == FluTextStyle.smallNeptune ||
          stylePreset == FluTextStyle.bodyNeptune) {
        return stylePreset.style.merge(neptuneStyle);
      }

      if (stylePreset == FluTextStyle.smallBold ||
          stylePreset == FluTextStyle.bodyBold ||
          stylePreset == FluTextStyle.headlineBold) {
        return stylePreset.style.merge(TextStyle(
            fontWeight: Flu.appSettings.textBold,
            color: Flu.theme().accentText));
      }

      return defaultTextStyle;
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
                  .copyWith(color: hasText ? null : Flu.theme().danger),
            )
          ];

    return RichText(
      text: TextSpan(
        children: prefixs +
            (replaceEmojis
                ? textSpans.map((span) => Flu.replaceEmojis(span)).toList()
                : textSpans) +
            suffixs,
      ),
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
      /* minFontSize: minFontSize ?? Flu.appSettings.smallFs,
      maxFontSize: maxFontSize,
      group: group,
      stepGranularity: stepGranularity,
      presetFontSizes: presetFontSizes,
      overflowReplacement: overflowReplacement, */
    );
  }
}

enum FluTextStyleApplicationMethod {
  override,
  merge,
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

extension FluTextStyleExt on FluTextStyle {
  TextStyle get style {
    switch (this) {
      case FluTextStyle.small:
      case FluTextStyle.smallBold:
      case FluTextStyle.smallNeptune:
        return Flu.textTheme.bodyText1!
            .copyWith(fontSize: Flu.appSettings.smallFs);
      case FluTextStyle.body:
      case FluTextStyle.bodyBold:
      case FluTextStyle.bodyNeptune:
        return Flu.textTheme.bodyText1!;
      case FluTextStyle.headline:
      case FluTextStyle.headlineBold:
      case FluTextStyle.headlineSemibold:
        return Flu.textTheme.headline1!
            .copyWith(fontSize: Flu.appSettings.headlineFs);
    }
  }
}
