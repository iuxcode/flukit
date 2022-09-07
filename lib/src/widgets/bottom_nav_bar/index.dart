import 'package:flukit/flukit.dart';
import 'package:flukit_icons/flukit_icons.dart';
import 'package:flutter/material.dart';

import 'utils.dart';

export 'style.dart';
export 'item.dart';

class FluBottomNavBar extends StatefulWidget {
  final double selectedIndex;
  final List<FluBottomNavBarItem> items;
  final Function(int) onItemTap;
  final FluBottomNavBarStyle? style;

  const FluBottomNavBar(
      {Key? key,
      required this.onItemTap,
      required this.items,
      this.selectedIndex = 0,
      this.style})
      : super(key: key);

  @override
  State<FluBottomNavBar> createState() => FluBottomNavBarState();
}

class FluBottomNavBarState extends State<FluBottomNavBar>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  final GlobalKey itemKey = GlobalKey();

  int previousIndex = 0;
  double itemWidth = 0;

  FluBottomNavBarStyle get style => widget.style ?? FluBottomNavBarStyle.defaultt;

  void getItemWidth() {
    final RenderBox box = itemKey.currentContext?.findRenderObject() as RenderBox;
    final double width = box.size.width;
    setState(() => itemWidth = width);
  }

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: style.animationDuration,
    )..forward(from: 0.0);
    WidgetsBinding.instance.addPostFrameCallback((_) => getItemWidth());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget navbar = Container(
      height: style.height,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: style.background ?? Flukit.themePalette.dark,
        borderRadius: style.borderRadius ?? BorderRadius.circular(style.radius),
      ),
      child: Stack(
        alignment: style.indicatorPosition == FluBottomNavBarIndicatorPosition.top
            ? Alignment.topLeft
            : Alignment.bottomLeft,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>() {
              final int itemCount = widget.items.length;
              List<Widget> items = <Widget>[];

              for (var i = 0; i < itemCount; i++) {
                if (i == itemCount / 2 && style.type == FluBottomNavBarType.curved) {
                  items.add(SizedBox(width: style.gapWidth) as Widget);
                }
                items.add(_Item(
                  key: i == 0 ? itemKey : null,
                  isSelected: widget.selectedIndex.round() == i,
                  onTap: () {
                    setState(() => previousIndex = i);
                    widget.onItemTap(i);
                    Future.delayed(style.animationDuration,
                        () => animationController.forward(from: 0.0));
                  },
                  data: widget.items[i],
                  color: style.color ?? Flukit.theme.textColor,
                  activeColor: style.activeColor ?? Flukit.theme.primaryColor,
                  animationDuration: style.animationDuration,
                  animationCurve: style.animationCurve,
                  showLabel: style.showItemLabelOnSelected,
                  iconStyle: style.iconStyle,
                ) as Widget);
              }

              return items;
            }.call(),
          ),
          FluBottomNavBarIndicator(
            controller: animationController,
            selectedIndex: widget.selectedIndex,
            previousIndex: previousIndex,
            height: style.indicatorHeight,
            maxWidth: itemWidth,
            duration: style.animationDuration,
            curve: style.animationCurve,
            color: style.indicatorColor ??
                style.activeColor ??
                Flukit.theme.primaryColor,
            activeColor: style.activeColor ?? Flukit.theme.primaryColor,
            style: style.indicatorStyle,
            position: style.indicatorPosition,
            gapWidth: style.gapWidth,
            bottomNavBarType: style.type,
          )
        ],
      ),
    );

    return Container(
      margin: style.floating ? style.margin : EdgeInsets.zero,
      decoration: BoxDecoration(
        color: Flukit.theme.backgroundColor,
        borderRadius: (style.borderRadius ?? BorderRadius.circular(style.radius))
            .copyWith(
                bottomLeft: const Radius.circular(0),
                bottomRight: const Radius.circular(0)),
      ),
      child: style.type == FluBottomNavBarType.curved
          ? PhysicalShape(
              clipBehavior: Clip.antiAlias,
              color: Colors.transparent,
              clipper: CircularNotchedAndCorneredRectangleClipper(
                notchMargin: style.notchMargin,
                geometry: Scaffold.geometryOf(context),
                shape: CircularNotchedAndCorneredRectangle(
                    gapLocation: style.gapLocation,
                    notchSmoothness: style.notchSmoothness,
                    radius: style.radius,
                    borderRadius: style.borderRadius,
                    margin: style.floating ? style.margin.left : 0),
              ),
              child: navbar,
            )
          : navbar,
    );
  }
}

class _Item extends StatelessWidget {
  final FluBottomNavBarItem data;
  final Color color, activeColor;
  final void Function() onTap;
  final bool isSelected, showLabel;
  final Duration animationDuration;
  final Curve animationCurve;
  final FluIconStyles iconStyle;

  const _Item({
    Key? key,
    required this.data,
    required this.color,
    required this.activeColor,
    required this.onTap,
    required this.animationDuration,
    required this.animationCurve,
    this.isSelected = false,
    this.showLabel = false,
    required this.iconStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Expanded(
        child: FluButton(
          onPressed: () => onTap(),
          style: FluButtonStyle(
            height: double.infinity,
            width: double.infinity,
            backgroundColor: Colors.transparent,
            radius: 0,
            padding: const EdgeInsets.symmetric(horizontal: 30),
          ),
          child: Center(
            child: AnimatedSwitcher(
              duration: animationDuration,
              switchInCurve: animationCurve,
              switchOutCurve: animationCurve,
              child: isSelected && showLabel
                  ? Text(
                      data.label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: Flukit.textTheme.bodyText1!.copyWith(
                          fontSize: Flukit.appConsts.smallFs,
                          color: Flukit.theme.primaryColor),
                    )
                  : FluIcon(
                      isSelected && data.activeIcon != null
                          ? data.activeIcon!
                          : data.icon,
                      color: isSelected ? activeColor : color,
                      strokewidth: 2,
                      size: isSelected && data.activeIcon != null ? 26 : 24,
                      style: iconStyle,
                    ),
            ),
          ),
        ),
      );
}
