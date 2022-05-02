import 'package:flukit/src/models/flu_models.dart';
import 'package:flukit_icons/flukit_icons.dart';
import 'package:flutter/material.dart';

import '../../flukit.dart';

class FluOptionsList extends StatelessWidget {
  final double? itemHeight, itemRadius, suffixIconSize, iconSize, iconStrokewidth;
  final double itemSpacing, itemIconMarginSize;
  final bool itemOutlined, shrinkWrap;
  final EdgeInsets padding, itemPadding;
  final ScrollPhysics? physics;
  final TextStyle? titleTextStyle;
  final BoxShadow? itemBoxshadow;
  final Color? outlineColor, iconBackgroundColor, textColor, iconColor, suffixIconColor;
  final FluIconModel? suffixIcon;
  final List<FluScreenOptionModel> options;

  const FluOptionsList({
    Key? key,
    required this.options,
    this.shrinkWrap = true,
    this.itemHeight,
    this.itemRadius,
    this.itemOutlined = false,
    this.itemSpacing = 10,
    this.itemIconMarginSize = 10,
    this.padding = EdgeInsets.zero,
    this.itemPadding = EdgeInsets.zero,
    this.physics = const NeverScrollableScrollPhysics(),
    this.titleTextStyle,
    this.itemBoxshadow,
    this.outlineColor,
    this.iconBackgroundColor,
    this.textColor,
    this.iconColor,
    this.suffixIcon,
    this.suffixIconColor,
    this.suffixIconSize,
    this.iconSize,
    this.iconStrokewidth
  }): assert(options.length > 0), super(key: key);

  @override
  Widget build(BuildContext context) => ListView.builder(
    shrinkWrap: shrinkWrap,
    physics: physics,
    padding: padding,
    itemCount: options.length,
    itemBuilder: (BuildContext context, int index) {
      FluScreenOptionModel option = options[index];

      double size = itemHeight ?? FluConsts.minElSize, radius = itemRadius ?? FluConsts.minElRadius + 5;
      Color color = option.color ?? textColor ?? Flukit.theme.textColor;
      Color backgroundColor = option.backgroundColor ?? Flukit.theme.backgroundColor;

      Widget icon(FluIconModel _icon) => Container(
        height: size,
        width: size,
        margin: EdgeInsets.only(right: itemIconMarginSize),
        decoration: BoxDecoration(
          color: option.iconBackgroundColor ?? iconBackgroundColor ?? Flukit.theme.accentBackgroundColor,
          borderRadius: BorderRadius.circular(radius)
        ),
        child: FluIcon(
          icon: _icon,
          color: option.color ?? iconColor ?? color,
          size: iconSize ?? 24,
          strokeWidth: iconStrokewidth ?? 1.5,
        )
      );

      Widget titleText = Text(option.title, style: Flukit.textTheme.bodyText1!.copyWith(
        color: color,
        fontWeight: FluConsts.textSemibold
      ).merge(titleTextStyle));

      Widget optionWidget = Container(
        width: double.infinity,
        padding: itemPadding,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(radius),
          boxShadow: [
            if(!itemOutlined && itemBoxshadow != null) itemBoxshadow!
          ]
        ),
        child: Row(
          children: <Widget>[
            if(option.icon != null) icon(option.icon!),
            if(option.description != null) Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  titleText,
                  Text(option.description!)
                ],
              ),
            )
            else Expanded(
              child: titleText,
            ),
            if(option.suffixIcon != null || suffixIcon != null) FluIcon(
              icon: option.suffixIcon ?? suffixIcon!,
              color: suffixIconColor,
              size: suffixIconSize ?? 18
            )
          ],
        )
      );

      if(itemOutlined) {
        optionWidget =  FluOutline(
          radius: radius + 2,
          strokeColor: option.outlineColor ?? outlineColor ?? backgroundColor,
          boxShadow: itemBoxshadow ?? Flukit.boxShadow(
            opacity: .065,
            offset: const Offset(0, 0)
          ),
          child: optionWidget
        ) ;
      }

      return FluButton(
        onPressed: option.onPressed,
        backgroundColor: Colors.transparent,
        margin: EdgeInsets.only(top: index == 0 ? 0 : itemSpacing),
        padding: EdgeInsets.zero,
        child: optionWidget
      );
    }
  );
}