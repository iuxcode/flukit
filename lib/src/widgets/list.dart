import 'package:flukit/src/models/flu_models.dart';
import 'package:flukit/src/utils/flu_utils.dart';
import 'package:flukit_icons/flukit_icons.dart';
import 'package:flutter/material.dart';

import 'flu_widgets.dart';

class FluOptionsList extends StatelessWidget {
  const FluOptionsList(
      {Key? key,
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
      this.iconbackground,
      this.textColor,
      this.iconColor,
      this.iconSize,
      this.iconStrokewidth,
      this.outlineStrokewidth = 1,
      this.outlineSpacing = 3,
      this.itembackground})
      : assert(options.length > 0),
        super(key: key);

  final TextStyle? titleTextStyle, descTextStyle;
  final BoxShadow? itemBoxShadow, iconBoxShadow;
  final double itemSpacing, itemIconMarginSize;
  final EdgeInsets padding, itemPadding;
  final Color? outlineColor,
      iconbackground,
      textColor,
      iconColor,
      itembackground;

  final List<FluOption> options;
  final double? itemHeight,
      itemRadius,
      iconSize,
      iconStrokewidth,
      outlineStrokewidth,
      outlineSpacing;

  final ScrollPhysics? physics;
  final bool itemOutlined, shrinkWrap;
  final Widget? suffixWidget;

  @override
  Widget build(BuildContext context) => ListView.builder(
      shrinkWrap: shrinkWrap,
      physics: physics,
      padding: padding,
      itemCount: options.length,
      itemBuilder: (BuildContext context, int index) {
        FluOption option = options[index];

        double size = itemHeight ?? Flu.appSettings.minElSize,
            radius = itemRadius ?? Flu.appSettings.minElRadius + 5;
        Color color = option.color ?? textColor ?? Flu.theme().text;
        Color background = option.background ?? Flu.theme().background;

        Widget iconWidget(FluIcons? icon, String? label) => Container(
              height: size,
              width: size,
              margin: EdgeInsets.only(right: itemIconMarginSize),
              decoration: BoxDecoration(
                  color: option.iconbackground ??
                      iconbackground ??
                      Flu.theme().surfaceBackground,
                  borderRadius: BorderRadius.circular(radius),
                  boxShadow: [if (iconBoxShadow != null) iconBoxShadow!]),
              child: icon != null
                  ? FluIcon(
                      icon,
                      color: option.color ?? iconColor ?? color,
                      size: iconSize ?? 24,
                      strokewidth: iconStrokewidth ?? 1.5,
                    )
                  : label != null
                      ? Center(
                          child: Text(label,
                              style: Flu.textTheme.bodyText1!.copyWith(
                                fontSize: iconSize ?? 24,
                              )),
                        )
                      : null,
            );

        Widget titleText = Text(option.title,
            overflow: TextOverflow.ellipsis,
            style: Flu.textTheme.bodyText1
                ?.copyWith(color: color, fontWeight: FontWeight.w600)
                .merge(titleTextStyle?.copyWith(color: option.color)));

        Widget optionWidget = Container(
            width: double.infinity,
            padding: itemPadding,
            decoration: BoxDecoration(
                color: itembackground ?? background,
                borderRadius: BorderRadius.circular(radius),
                boxShadow: [
                  if (!itemOutlined && itemBoxShadow != null) itemBoxShadow!
                ]),
            child: Row(
              children: <Widget>[
                if (option.icon != null || option.label != null)
                  iconWidget(option.icon, option.label)
                else if (option.image != null)
                  FluImage(
                    option.image!,
                    source: option.imageType,
                    height: size,
                    width: size,
                    margin: EdgeInsets.only(right: itemIconMarginSize),
                  ),
                if (option.description != null)
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        titleText,
                        const SizedBox(height: 2),
                        Text(option.description!,
                            overflow: TextOverflow.ellipsis,
                            style:
                                Flu.textTheme.bodyText1?.merge(descTextStyle))
                      ],
                    ),
                  )
                else
                  Expanded(
                    child: titleText,
                  ),
                if (option.hasSuffix)
                  option.suffixWidget ?? suffixWidget ?? Container()
              ],
            ));

        if (itemOutlined) {
          optionWidget = FluOutline(
              radius: radius + 2,
              spacing: outlineSpacing,
              color: option.outlineColor ?? outlineColor ?? background,
              thickness: outlineStrokewidth,
              boxShadow: itemBoxShadow ??
                  Flu.boxShadow(opacity: .065, offset: const Offset(0, 0)),
              child: optionWidget);
        }

        return FluButton(
          onPressed: option.onPressed,
          style: FluButtonStyle(
            background: Colors.transparent,
            margin: EdgeInsets.only(top: index == 0 ? 0 : itemSpacing),
            padding: EdgeInsets.zero,
          ),
          child: optionWidget,
        );
      });
}
