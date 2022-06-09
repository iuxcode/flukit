import 'package:flutter/material.dart';

import '../configs/theme/tweaks.dart';
import '../utils/flu_utils.dart';
import 'line.dart';

class FluTextWithLine extends StatelessWidget {
  final String text1, text2;
  final double lineHeight, lineWidth;

  const FluTextWithLine({
    Key? key,
    required this.text1,
    required this.text2,
    this.lineHeight = 2,
    this.lineWidth = 50
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Hero(
          tag: '<title>',
          child: Text(text1, style: Flukit.textTheme.bodyText1!.copyWith(
            fontSize: FluConsts.headlineFs,
            fontWeight: FluConsts.textSemibold,
            color: Flukit.theme.accentTextColor
          )),
        ),
        Row(
          children: [
            Hero(
              tag: '<title2>',
              child: Text(text2, maxLines: 1, overflow: TextOverflow.ellipsis, style: Flukit.textTheme.bodyText1!.copyWith(
                fontSize: FluConsts.headlineFs,
                fontWeight: FluConsts.textSemibold,
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