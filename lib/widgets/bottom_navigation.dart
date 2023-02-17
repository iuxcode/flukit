import 'dart:math' as math;
import 'package:flukit/flukit.dart';
import 'package:flukit_icons/flukit_icons.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'button.dart';

/// Creates an item that is used with [FluBottomNavBar.items].
class FluBottomNavBarItem {
  FluBottomNavBarItem(this.icon, this.label);

  final FluIcons icon;
  final String label;
}

/// Creates a bottom navigation bar which is typically used as a [Scaffold]'s [Scaffold.bottomNavigationBar] argument.
/// The length of [items] must be at least two and each item's icon and label must not be null.
class FluBottomNavBar extends StatefulWidget {
  const FluBottomNavBar({
    super.key,
    required this.items,
    this.type = FluBottomNavBarTypes.flat,
    this.onItemTap,
    this.padding,
    this.height,
    this.animationDuration = const Duration(milliseconds: 400),
    this.animationCurve = Curves.fastOutSlowIn,
    this.foregroundColor,
    this.unSelectedForegroundColor,
    this.indicatorSize = 5,
    this.iconSize = 22,
    this.iconStrokeWidth = 1.8,
  });

  final void Function(int)? onItemTap;
  final double? height;
  final double indicatorSize;
  final List<FluBottomNavBarItem> items;
  final EdgeInsets? padding;
  final FluBottomNavBarTypes type;
  final Duration animationDuration;
  final Curve animationCurve;
  final Color? foregroundColor;
  final Color? unSelectedForegroundColor;
  final double iconSize;
  final double iconStrokeWidth;

  @override
  State<FluBottomNavBar> createState() => _FluBottomNavBarState();
}

class _FluBottomNavBarState extends State<FluBottomNavBar> {
  final GlobalKey _itemKey = GlobalKey();

  double _itemWidth = 0.0;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => getItemWidth());
  }

  @override
  void didUpdateWidget(covariant FluBottomNavBar oldWidget) {
    getItemWidth();
    super.didUpdateWidget(oldWidget);
  }

  void getItemWidth() => setState(() => _itemWidth =
      (_itemKey.currentContext?.findRenderObject() as RenderBox).size.width);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Flu.getColorSchemeOf(context);
    final Color foregroundColor = widget.foregroundColor ?? colorScheme.primary,
        unSelectedForegroundColor =
            widget.unSelectedForegroundColor ?? colorScheme.onBackground;

    Widget bottomNav = Container(
      height: widget.height,
      width: double.infinity,
      padding: widget.padding,
      child: Row(
        children: widget.items.map((item) {
          final index = widget.items.indexOf(item);
          final bool isSelected = index == _currentIndex;

          return _NavItem(
            key: widget.items.indexOf(item) == 0 ? _itemKey : null,
            item,
            onTap: () {
              setState(() => _currentIndex = index);
              widget.onItemTap?.call(index);
            },
            color: isSelected ? foregroundColor : unSelectedForegroundColor,
            iconSize: widget.iconSize,
            iconStrokeWidth: widget.iconStrokeWidth,
          );
        }).toList(),
      ),
    );

    bottomNav = Stack(
      children: [
        bottomNav,
        _NavIndicator(
          animationDuration: widget.animationDuration,
          animationCurve: widget.animationCurve,
          size: widget.indicatorSize,
          itemWidth: _itemWidth,
          position: (_currentIndex * _itemWidth) +
              (widget.padding?.horizontal ?? 0) / 2,
          color: foregroundColor,
        ),
      ],
    );

    switch (widget.type) {
      case FluBottomNavBarTypes.curved:
        return _CurvedBottomNav(child: bottomNav);
      default:
        return bottomNav;
    }
  }
}

/// Create a Bottom navigation bar with a notch
class _CurvedBottomNav extends StatelessWidget {
  const _CurvedBottomNav({
    super.key,
    this.notchMargin = 8.0,
    this.gapLocation = GapLocation.center,
    this.notchSmoothness = NotchSmoothness.softEdge,
    this.borderRadius = BorderRadius.zero,
    required this.child,
  });

  final BorderRadius borderRadius;
  final Widget child;
  final GapLocation gapLocation;
  final double notchMargin;
  final NotchSmoothness notchSmoothness;

  @override
  Widget build(BuildContext context) {
    return PhysicalShape(
      clipBehavior: Clip.antiAlias,
      color: Colors.transparent,
      clipper: _CircularNotchedAndCorneredRectangleClipper(
        notchMargin: notchMargin,
        geometry: Scaffold.geometryOf(context),
        shape: _CircularNotchedAndCorneredRectangle(
          gapLocation: gapLocation,
          notchSmoothness: notchSmoothness,
          borderRadius: BorderRadius.zero,
          margin: 0,
        ),
      ),
      child: child,
    );
  }
}

/// [FluBottomNavBar] item.
class _NavItem extends StatelessWidget {
  const _NavItem(
    this.item, {
    required this.onTap,
    super.key,
    required this.color,
    required this.iconSize,
    required this.iconStrokeWidth,
  });

  final FluBottomNavBarItem item;
  final VoidCallback onTap;
  final Color color;
  final double iconSize;
  final double iconStrokeWidth;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: FluButton.icon(
      item.icon,
      onPressed: onTap,
      iconSize: iconSize,
      iconStrokeWidth: iconStrokeWidth,
      backgroundColor: Colors.transparent,
      foregroundColor: color,
      size: double.infinity,
    ));
  }
}

/// [FluBottomNavBar] indicator.
class _NavIndicator extends StatelessWidget {
  const _NavIndicator({
    super.key,
    required this.size,
    required this.itemWidth,
    required this.position,
    required this.animationDuration,
    required this.animationCurve,
    required this.color,
  });

  final double position;
  final double size;
  final double itemWidth;
  final Duration animationDuration;
  final Curve animationCurve;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      left: position,
      bottom: 0,
      duration: animationDuration,
      curve: animationCurve,
      child: Container(
        height: size,
        width: itemWidth,
        alignment: Alignment.center,
        child: Container(
          height: size,
          width: size * 3,
          decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(size),
                topRight: Radius.circular(size),
              )),
        ),
      ),
    );
  }
}

/// [FluBottomNavBarTypes.curved] clipper
class _CircularNotchedAndCorneredRectangleClipper extends CustomClipper<Path> {
  _CircularNotchedAndCorneredRectangleClipper({
    required this.geometry,
    required this.shape,
    required this.notchMargin,
  }) : super(reclip: geometry);

  final ValueListenable<ScaffoldGeometry> geometry;
  final double notchMargin;
  final NotchedShape shape;

  @override
  Path getClip(Size size) {
    final Rect? button = geometry.value.floatingActionButtonArea
        ?.translate(0.0, geometry.value.bottomNavigationBarTop! * -1.0);

    return shape.getOuterPath(Offset.zero & size, button?.inflate(notchMargin));
  }

  @override
  bool shouldReclip(_CircularNotchedAndCorneredRectangleClipper oldClipper) {
    return oldClipper.geometry != geometry ||
        oldClipper.shape != shape ||
        oldClipper.notchMargin != notchMargin;
  }
}

/// A rectangle with a smooth circular notch and rounded corners.
class _CircularNotchedAndCorneredRectangle extends NotchedShape {
  _CircularNotchedAndCorneredRectangle({
    required this.notchSmoothness,
    required this.gapLocation,
    required this.borderRadius,
    this.margin = 0,
  });

  final BorderRadius borderRadius;
  final GapLocation gapLocation;
  final double margin;
  final NotchSmoothness notchSmoothness;

  @override
  Path getOuterPath(Rect host, Rect? guest) {
    if (guest == null || !host.overlaps(guest)) return Path()..addRect(host);

    double notchRadius = guest.width / 2;

    final double s1 = notchSmoothness.s1;
    final double s2 = notchSmoothness.s2;

    double r = notchRadius;
    double a = -1.0 * r - s2;
    double b = host.top - guest.center.dy;

    double n2 = math.sqrt(b * b * r * r * (a * a + b * b - r * r));
    double p2xA = ((a * r * r) - n2) / (a * a + b * b);
    double p2xB = ((a * r * r) + n2) / (a * a + b * b);
    double p2yA = math.sqrt(r * r - p2xA * p2xA);
    double p2yB = math.sqrt(r * r - p2xB * p2xB);

    List<Offset> p = List.filled(6, Offset.zero, growable: true);

    // p0, p1, and p2 are the control points for segment A.
    p[0] = Offset(a - s1, b);
    p[1] = Offset(a, b);
    double cmp = b < 0 ? -1.0 : 1.0;
    p[2] = cmp * p2yA > cmp * p2yB ? Offset(p2xA, p2yA) : Offset(p2xB, p2yB);

    // p3, p4, and p5 are the control points for segment B, which is a mirror
    // of segment A around the y axis.
    p[3] = Offset(-1.0 * p[2].dx, p[2].dy);
    p[4] = Offset(-1.0 * p[1].dx, p[1].dy);
    p[5] = Offset(-1.0 * p[0].dx, p[0].dy);

    // translate all points back to the absolute coordinate system.
    for (int i = 0; i < p.length; i += 1) {
      p[i] += margin > 0
          ? Offset(guest.center.dx - margin, guest.center.dy)
          : guest.center;
    }

    return Path()
      ..moveTo(host.left, host.bottom)
      ..lineTo(host.left, host.top)
      ..arcToPoint(
        Offset(host.left, host.top),
        radius: borderRadius.topLeft,
        clockwise: true,
      )
      ..lineTo(p[0].dx, p[0].dy)
      ..quadraticBezierTo(p[1].dx, p[1].dy, p[2].dx, p[2].dy)
      ..arcToPoint(
        p[3],
        radius: Radius.circular(notchRadius),
        clockwise: false,
      )
      ..quadraticBezierTo(p[4].dx, p[4].dy, p[5].dx, p[5].dy)
      ..lineTo(host.right, host.top)
      ..arcToPoint(
        Offset(host.right, host.top),
        radius: borderRadius.topRight,
        clockwise: true,
      )
      // ..lineTo(host.right, host.bottom)
      ..arcToPoint(
        Offset(host.right, host.bottom),
        radius: borderRadius.bottomRight,
        clockwise: true,
      )
      // ..lineTo(host.left, host.bottom)
      ..arcToPoint(
        Offset(host.left, host.bottom),
        radius: borderRadius.bottomLeft,
        clockwise: true,
      )
      ..close();
  }
}

/// [FluBottomNavBar] types.
enum FluBottomNavBarTypes { flat, curved }

/// Where to position the [FluBottomNavBarTypes.curved] gap
enum GapLocation { none, center, end }

/// [FluBottomNavBarTypes.curved] notch corner smooth
enum NotchSmoothness {
  sharpEdge,
  defaultEdge,
  softEdge,
  smoothEdge,
  verySmoothEdge
}

extension on NotchSmoothness {
  static const curveS1 = {
    NotchSmoothness.sharpEdge: 0.0,
    NotchSmoothness.defaultEdge: 15.0,
    NotchSmoothness.softEdge: 20.0,
    NotchSmoothness.smoothEdge: 30.0,
    NotchSmoothness.verySmoothEdge: 40.0,
  };

  static const curveS2 = {
    NotchSmoothness.sharpEdge: 0.1,
    NotchSmoothness.defaultEdge: 1.0,
    NotchSmoothness.softEdge: 5.0,
    NotchSmoothness.smoothEdge: 10.0,
    NotchSmoothness.verySmoothEdge: 20.0,
  };

  double get s1 => curveS1[this] ?? 15.0;

  double get s2 => curveS2[this] ?? 1.0;
}
