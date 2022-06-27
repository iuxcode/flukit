import 'package:flutter/material.dart';

import '../utils/flu_utils.dart';
import 'line.dart';

/// TODO add more styles
enum FluTextStyle {
  small,
  smallNeptune,
  body,
  bodyNeptune,
  headline,
}

class FluText extends StatelessWidget {
  final String text;
  final TextStyle? customStyle;
  final FluTextStyle style;

  const FluText(this.text, {
    Key? key,
    this.customStyle,
    this.style = FluTextStyle.body,
  }) : super(key: key);

  double get fontSize {
    switch (style) {
      case FluTextStyle.small:
      case FluTextStyle.smallNeptune:
        return Flukit.appConsts.smallFs;
      case FluTextStyle.body:
      case FluTextStyle.bodyNeptune:
        return Flukit.appConsts.bodyFs;
      case FluTextStyle.headline:
        return Flukit.appConsts.headlineFs;
    }
  }

  FontWeight get fontWeight {
    switch (style) {
      case FluTextStyle.small:
      case FluTextStyle.smallNeptune:
      case FluTextStyle.body:
      case FluTextStyle.bodyNeptune:
        return Flukit.appConsts.textNormal;
      case FluTextStyle.headline:
        return Flukit.appConsts.textBold;
    }
  }

  Color get color {
    switch (style) {
      case FluTextStyle.small:
      case FluTextStyle.smallNeptune:
      case FluTextStyle.body:
      case FluTextStyle.bodyNeptune:
        return Flukit.theme.textColor;
      case FluTextStyle.headline:
        return Flukit.theme.accentTextColor;
    }
  }

  @override
  Widget build(BuildContext context) => Text(
    text,
    style: Flukit.textTheme.bodyText1!.copyWith(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    ).merge(customStyle),
  );
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Hero(
          tag: Flukit.appConsts.titleTextHeroTag,
          child: Text(text1, style: Flukit.textTheme.bodyText1!.copyWith(
            fontSize: fontsize ?? Flukit.appConsts.headlineFs,
            fontWeight: Flukit.appConsts.textSemibold,
            color: Flukit.theme.accentTextColor
          )),
        ),
        Row(
          children: [
            Hero(
              tag: Flukit.appConsts.title2TextHeroTag,
              child: Text(text2, maxLines: 1, overflow: TextOverflow.ellipsis, style: Flukit.textTheme.bodyText1!.copyWith(
                fontSize: fontsize ?? Flukit.appConsts.headlineFs,
                fontWeight: Flukit.appConsts.textSemibold,
                color: Flukit.theme.accentTextColor
              )),
            ),
            FluLine(
              height: lineHeight,
              width: lineWidth,
              margin: const EdgeInsets.only(left: 10),
            )
          ],
        ),
      ]
    );
  }
}