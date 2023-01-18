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
  const FluBottomNavBar({
    Key? key,
    required this.onItemTap,
    required this.items,
    this.selectedIndex = 0,
    this.style,
  }) : super(key: key);

  final List<FluBottomNavBarItem> items;
  final Function(int) onItemTap;

  /// Active item index.
  final double selectedIndex;

  final FluBottomNavBarStyle? style;

  @override
  State<FluBottomNavBar> createState() => FluBottomNavBarState();
}

class FluBottomNavBarState extends State<FluBottomNavBar>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  final GlobalKey itemKey = GlobalKey();
  double itemWidth = 0;
  int previousIndex = 0;
  late FluBottomNavBarStyle style;

  @override
  void didUpdateWidget(covariant FluBottomNavBar oldWidget) {
    if (widget.style != null && widget.style != style) {
      style = widget.style!;
    }
    getItemWidth();
    super.didUpdateWidget(oldWidget);
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

  void getItemWidth() {
    final RenderBox box =
        itemKey.currentContext?.findRenderObject() as RenderBox;
    final double width = box.size.width;
    setState(() => itemWidth = width);
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Container(
      height: style.height,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
          color: style.background ?? Flu.theme.dark,
          borderRadius: style.borderTop
              ? null
              : (style.borderRadius ?? BorderRadius.circular(style.radius)),
          border: style.borderTop
              ? Border(
                  top: BorderSide(
                      color: style.borderColor ?? Flu.theme.text, width: 1))
              : null),
      child: Stack(
        alignment:
            style.indicatorPosition == FluBottomNavBarIndicatorPosition.top
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
                if (i == itemCount / 2 &&
                    style.type == FluBottomNavBarType.curved) {
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
                  color: style.color ?? Flu.theme.text,
                  activeColor: style.activeColor ?? Flu.theme.primary,
                  animationDuration: style.animationDuration,
                  animationCurve: style.animationCurve,
                  showLabel: style.showItemLabelOnSelected,
                  iconStyle: style.iconStyle,
                  activeIconStyle: style.activeIconStyle,
                  iconSize: style.iconSize,
                  alwayShowLabel: style.alwayShowItemLabel,
                  labelStyle: style.itemLabelStyle,
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
            color:
                style.indicatorColor ?? style.activeColor ?? Flu.theme.primary,
            activeColor: style.activeColor ?? Flu.theme.primary,
            style: style.indicatorStyle,
            position: style.indicatorPosition,
            gapWidth: style.gapWidth,
            bottomNavBarType: style.type,
          )
        ],
      ),
    );

    if (style.type == FluBottomNavBarType.curved) {
      content = PhysicalShape(
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
            margin: style.floating ? style.margin.left : 0,
          ),
        ),
        child: content,
      );
    }

    if (style.glass) {
      content = FluGlass(
        child: content,
      );
    }

    content = Padding(
      padding: style.floating ? style.margin : EdgeInsets.zero,
      child: content,
    );

    return style.glass
        ? content
        : Stack(
            alignment: Alignment.center,
            children: [
              /// Hide visible parts of the page if bottom
              /// safeArea is disabled
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: (style.height *
                          (style.type == FluBottomNavBarType.curved ? .5 : 1)) +
                      (style.floating ? style.margin.bottom : 0),
                  decoration: BoxDecoration(
                    color: Flu.theme.background,
                  ),
                ),
              ),
              content,
            ],
          );
  }
}

class _Item extends StatelessWidget {
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
    this.alwayShowLabel = false,
    this.labelStyle,
  }) : super(key: key);

  final Color color, activeColor;
  final FluIconStyles? activeIconStyle;
  final bool isSelected, showLabel, alwayShowLabel;
  final Curve animationCurve;
  final Duration animationDuration;
  final FluBottomNavBarItem data;
  final double iconSize;
  final FluIconStyles iconStyle;
  final TextStyle? labelStyle;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    Widget icon = FluIcon(
          isSelected && data.activeIcon != null ? data.activeIcon! : data.icon,
          color: isSelected ? activeColor : color,
          strokewidth: 1.6,
          size: iconSize, // isSelected && data.activeIcon != null ? 26 : 24
          style: isSelected && activeIconStyle != null
              ? activeIconStyle!
              : iconStyle,
        ),
        label = Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: FittedBox(
                child: FluText(
              text: data.label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: Flu.appSettings.smallFs - 2,
                fontWeight: isSelected ? FontWeight.bold : null,
                color: isSelected ? activeColor : color,
              ).merge(labelStyle),
            ))),
        content;

    if (alwayShowLabel) {
      content = Column(
        children: [
          Flexible(
            child: Center(child: icon),
          ),
          label
        ],
      );
    } else if (showLabel) {
      content = Center(
        child: AnimatedSwitcher(
          duration: animationDuration,
          switchInCurve: animationCurve,
          switchOutCurve: animationCurve,
          child: isSelected && showLabel ? label : icon,
        ),
      );
    } else {
      content = Center(child: icon);
    }

    return Expanded(
      child: FluButton(
        onPressed: () => onTap(),
        style: const FluButtonStyle(
          height: double.infinity,
          width: double.infinity,
          background: Colors.transparent,
          cornerRadius: 0,
          padding: EdgeInsets.symmetric(horizontal: 30),
        ),
        child: content,
      ),
    );
  }
}
