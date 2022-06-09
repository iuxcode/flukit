import 'package:flukit/src/models/flu_models.dart';
import 'package:flukit_icons/flukit_icons.dart';
import 'package:flutter/material.dart';

import '../../flukit.dart';

class FluOptionsList extends StatelessWidget {
  final double? itemHeight, itemRadius, iconSize, iconStrokewidth, outlineStrokewidth, outlineSpacing;
  final double itemSpacing, itemIconMarginSize;
  final bool itemOutlined, shrinkWrap;
  final EdgeInsets padding, itemPadding;
  final ScrollPhysics? physics;
  final TextStyle? titleTextStyle, descTextStyle;
  final BoxShadow? itemBoxShadow, iconBoxShadow;
  final Color? outlineColor, iconBackgroundColor, textColor, iconColor, itemBackgroundColor;
  final Widget? suffixWidget;
  final List<FluScreenOption> options;

  const FluOptionsList({
    Key? key,
    required this.options,
    this.suffixWidget,
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
    this.descTextStyle,
    this.itemBoxShadow,
    this.iconBoxShadow,
    this.outlineColor,
    this.iconBackgroundColor,
    this.textColor,
    this.iconColor,
    this.iconSize,
    this.iconStrokewidth,
    this.outlineStrokewidth = 1,
    this.outlineSpacing = 3,
    this.itemBackgroundColor
  }): assert(options.length > 0), super(key: key);

  @override
  Widget build(BuildContext context) => ListView.builder(
    shrinkWrap: shrinkWrap,
    physics: physics,
    padding: padding,
    itemCount: options.length,
    itemBuilder: (BuildContext context, int index) {
      FluScreenOption option = options[index];

      double size = itemHeight ?? FluConsts.minElSize, radius = itemRadius ?? FluConsts.minElRadius + 5;
      Color color = option.color ?? textColor ?? Flukit.theme.textColor;
      Color backgroundColor = option.backgroundColor ?? Flukit.theme.backgroundColor;

      Widget icon(FluIconModel? _icon, String? label) => Container(
        height: size,
        width: size,
        margin: EdgeInsets.only(right: itemIconMarginSize),
        decoration: BoxDecoration(
          color: option.iconBackgroundColor ?? iconBackgroundColor ?? Flukit.theme.accentBackgroundColor,
          borderRadius: BorderRadius.circular(radius),
          boxShadow: [if(iconBoxShadow != null) iconBoxShadow!]
        ),
        child: _icon != null ? FluIcon(
          icon: _icon,
          color: option.color ?? iconColor ?? color,
          size: iconSize ?? 24,
          strokeWidth: iconStrokewidth ?? 1.5,
        ) : label != null ? Center(
            child: Text(label, style: Flukit.textTheme.bodyText1!.copyWith(
              fontSize: iconSize ?? 24,
          )),
        ) : null,
      );

      Widget titleText = Text(option.title, overflow: TextOverflow.ellipsis, style: Flukit.textTheme.bodyText1?.copyWith(
        color: color,
        fontWeight: FluConsts.textSemibold
      ).merge(titleTextStyle?.copyWith(
        color: option.color
      )));

      Widget optionWidget = Container(
        width: double.infinity,
        padding: itemPadding,
        decoration: BoxDecoration(
          color: itemBackgroundColor ?? backgroundColor,
          borderRadius: BorderRadius.circular(radius),
          boxShadow: [
            if(!itemOutlined && itemBoxShadow != null) itemBoxShadow!
          ]
        ),
        child: Row(
          children: <Widget>[
            if(option.icon != null || option.label != null) icon(option.icon, option.label)
            else if(option.image != null) FluImage(
              image: option.image,
              type: option.imageType,
              height: size,
              width: size,
              margin: EdgeInsets.only(right: itemIconMarginSize),
            ),
            if(option.description != null) Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  titleText,
                  const SizedBox(height: 2),
                  Text(
                    option.description!,
                    overflow: TextOverflow.ellipsis,
                    style: Flukit.textTheme.bodyText1?.merge(descTextStyle)
                  )
                ],
              ),
            )
            else Expanded(
              child: titleText,
            ),
            if(option.hasSuffix) option.suffixWidget ?? suffixWidget ?? Container()
          ],
        )
      );

      if(itemOutlined) {
        optionWidget =  FluOutline(
          radius: radius + 2,
          spacing: outlineSpacing,
          strokeColor: option.outlineColor ?? outlineColor ?? backgroundColor,
          strokeWidth: outlineStrokewidth,
          boxShadow: itemBoxShadow ?? Flukit.boxShadow(
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