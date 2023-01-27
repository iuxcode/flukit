import 'package:flukit/src/utils/flu_utils.dart';
import 'package:flukit_icons/flukit_icons.dart';
import 'package:flutter/material.dart';

import '../widgets/line.dart';

class FluAppbarAction {
  final String? label, heroTag;
  final FluIcons icon;
  final VoidCallback? onPressed;
  final bool requireAttention;
  final double iconSize, iconStrokeWidth;
  final FluIconStyles? iconStyle;
  final Offset? badgePosition;

  const FluAppbarAction({
    required this.icon,
    this.onPressed,
    this.label,
    this.heroTag,
    this.requireAttention = false,
    this.iconSize = 24,
    this.iconStrokeWidth = 1.55,
    this.iconStyle,
    this.badgePosition,
  });

  static Widget get separationLine => FluLine(
        height: 8,
        width: 1,
        color: Flu.theme.text.withOpacity(.65),
      );

  static List<Widget> build(List<FluAppbarAction> actions,
      {bool lineBetween = true,
      double? spaceBetween,
      Color? actionIndicatorColor}) {
    List<Widget> widgets = [];

    for (FluAppbarAction action in actions) {
      int index = actions.indexOf(action);
      bool isFirst = index == 0, isLast = index == (actions.length - 1);
      double spacing = spaceBetween ?? (actions.length > 2 ? 10 : 12);

      widgets.add(Hero(
        tag: action.heroTag ?? 'header_button_$index',
        child: GestureDetector(
          onTap: () {
            action.onPressed?.call();
            Flu.physicFeedback();
          },
          child: Padding(
            padding: EdgeInsets.only(
              left: !isFirst ? spacing * (lineBetween ? 1 : 2) : 0,
              right: !isLast && lineBetween ? spacing : 0,
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                FluIcon(
                  action.icon,
                  color: Flu.theme.text,
                  size: action.iconSize,
                  strokewidth: action.iconStrokeWidth,
                  style: action.iconStyle ?? FluIconStyles.twotone,
                ),

                /// TODO animate this
                if (action.requireAttention)
                  Positioned(
                    top: action.badgePosition?.dy != null &&
                            action.badgePosition?.dy != 0
                        ? action.badgePosition?.dy
                        : null,
                    left: action.badgePosition?.dx ?? 0,
                    child: Container(
                      height: 8,
                      width: 8,
                      decoration: BoxDecoration(
                          color: actionIndicatorColor ?? Flu.theme.primary,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Flu.theme.background.withOpacity(.8),
                            width: 1.5,
                          ),
                          boxShadow: [
                            Flu.boxShadow(
                              blurRadius: 12,
                              offset: const Offset(0, 0),
                              opacity: 1,
                              color: actionIndicatorColor ?? Flu.theme.primary,
                            )
                          ]),
                    ),
                  )
              ],
            ),
          ),
        ),
      ));

      if (!isLast && lineBetween) {
        widgets.add(separationLine);
      }
    }

    return widgets;
  }
}
