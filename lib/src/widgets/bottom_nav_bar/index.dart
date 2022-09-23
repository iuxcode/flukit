import 'package:flukit/flukit.dart';
import 'package:flukit_icons/flukit_icons.dart';
import 'package:flutter/material.dart';

import 'utils.dart';

export 'style.dart';
export 'item.dart';

/// A material widget that's displayed at the bottom of an app for selecting
/// among a small number of views, typically between three and five.
///
/// The bottom navigation bar consists of multiple items in the form of
/// text labels, icons, or both, laid out on top of a piece of material. It
/// provides quick navigation between the top-level views of an app. For larger
/// screens, side navigation may be a better fit.
///
/// A bottom navigation bar is usually used in conjunction with a [Scaffold], or [FluScreen],
/// where it is provided as the [Scaffold.bottomNavigationBar]  or [FluScreen.bottomNavigationBar] argument.
///
/// With the bottom navigation bar's [style], you can customize the [FluBottomNavBar].
/// If not specified, then it's automatically set to [FluBottomNavBarStyle.defaultt].
/// Check the [FluBottomNavBarStyle] class for more details about the default applied style.
///
/// The length of [items] must be at least two and each item's icon must not be null.
///
class FluBottomNavBar extends StatefulWidget {
  /// Active item index.
  final double selectedIndex;
  final List<FluBottomNavBarItem> items;
  final Function(int) onItemTap;
  final FluBottomNavBarStyle? style;

  const FluBottomNavBar({
    Key? key,
    required this.onItemTap,
    required this.items,
    this.selectedIndex = 0,
    this.style,
  }) : super(key: key);

  @override
  State<FluBottomNavBar> createState() => FluBottomNavBarState();
}

class FluBottomNavBarState extends State<FluBottomNavBar>
    with SingleTickerProviderStateMixin {
  late FluBottomNavBarStyle style;
  late AnimationController animationController;
  final GlobalKey itemKey = GlobalKey();

  int previousIndex = 0;
  double itemWidth = 0;

  void getItemWidth() {
    final RenderBox box = itemKey.currentContext?.findRenderObject() as RenderBox;
    final double width = box.size.width;
    setState(() => itemWidth = width);
  }

  @override
  void initState() {
    style = widget.style ?? FluBottomNavBarStyle.defaultt;
    animationController = AnimationController(
      vsync: this,
      duration: style.animationDuration,
    )..forward(from: 0.0);
    WidgetsBinding.instance.addPostFrameCallback((_) => getItemWidth());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Container(
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
                  activeIconStyle: style.activeIconStyle,
                  iconSize: style.iconSize,
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
              child: content,
            )
          : content,
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
  final FluIconStyles? activeIconStyle;
  final double iconSize;

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
    required this.iconSize,
    this.activeIconStyle,
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
                      size:
                          iconSize, // isSelected && data.activeIcon != null ? 26 : 24
                      style: isSelected && activeIconStyle != null
                          ? activeIconStyle!
                          : iconStyle,
                    ),
            ),
          ),
        ),
      );
}
