import 'dart:math' as math;

import 'package:flukit/src/ui/widgets/button.dart';
import 'package:flukit/utils.dart';
import 'package:flukit_icons/flukit_icons.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Creates an item that is used with [FluBottomNavBar.items].
class FluBottomNavBarItem {
  FluBottomNavBarItem(this.icon, this.label);

  final FluIcons icon;
  final String label;
}

/// Define a style for [FluBottomNavBar]
class FluBottomNavBarStyle {
  const FluBottomNavBarStyle({
    this.foregroundColor,
    this.backgroundColor,
    this.height,
    this.indicatorSize = 5,
    this.iconSize = 22,
    this.iconStrokeWidth = 1.8,
    this.padding,
    this.type = FluBottomNavBarTypes.flat,
    this.unSelectedForegroundColor,
    this.border,
    this.iconStyle = FluIconStyles.twotone,
    this.selectedIconStyle,
  });

  final Color? backgroundColor;
  final BoxBorder? border;
  final Color? foregroundColor;
  final double? height;
  final double iconSize;
  final double iconStrokeWidth;
  final double indicatorSize;
  final EdgeInsets? padding;
  final FluBottomNavBarTypes type;
  final Color? unSelectedForegroundColor;
  final FluIconStyles? selectedIconStyle;
  final FluIconStyles iconStyle;
}

/// Creates a bottom navigation bar which is typically
/// used as a [Scaffold]'s Scaffold.bottomNavigationBar argument.
/// The length of [items] must be at least two and each
/// item's icon and label must not be null.
class FluBottomNavBar extends StatefulWidget {
  const FluBottomNavBar({
    required this.items,
    super.key,
    this.onItemTap,
    this.style = const FluBottomNavBarStyle(),
    this.animationDuration = const Duration(milliseconds: 400),
    this.animationCurve = Curves.fastOutSlowIn,
    this.index = 0,
  });

  final void Function(int)? onItemTap;
  final Curve animationCurve;
  final Duration animationDuration;
  final int index;
  final List<FluBottomNavBarItem> items;
  final FluBottomNavBarStyle style;

  @override
  State<FluBottomNavBar> createState() => _FluBottomNavBarState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(
        ObjectFlagProperty<void Function(int p1)?>.has('onItemTap', onItemTap),
      )
      ..add(DiagnosticsProperty<Curve>('animationCurve', animationCurve))
      ..add(
        DiagnosticsProperty<Duration>('animationDuration', animationDuration),
      )
      ..add(IterableProperty<FluBottomNavBarItem>('items', items))
      ..add(IntProperty('index', index))
      ..add(DiagnosticsProperty<FluBottomNavBarStyle>('style', style))
      ..add(DiagnosticsProperty<Curve>('animationCurve', animationCurve))
      ..add(
        DiagnosticsProperty<Duration>('animationDuration', animationDuration),
      )
      ..add(IterableProperty<FluBottomNavBarItem>('items', items))
      ..add(IntProperty('index', index))
      ..add(DiagnosticsProperty<FluBottomNavBarStyle>('style', style))
      ..add(DiagnosticsProperty<Curve>('animationCurve', animationCurve))
      ..add(
        DiagnosticsProperty<Duration>('animationDuration', animationDuration),
      )
      ..add(IterableProperty<FluBottomNavBarItem>('items', items))
      ..add(IntProperty('index', index))
      ..add(DiagnosticsProperty<FluBottomNavBarStyle>('style', style))
      ..add(DiagnosticsProperty<Curve>('animationCurve', animationCurve))
      ..add(
        DiagnosticsProperty<Duration>('animationDuration', animationDuration),
      )
      ..add(IterableProperty<FluBottomNavBarItem>('items', items))
      ..add(IntProperty('index', index))
      ..add(DiagnosticsProperty<FluBottomNavBarStyle>('style', style));
  }
}

class _FluBottomNavBarState extends State<FluBottomNavBar> {
  final GlobalKey _itemKey = GlobalKey();

  late int _currentIndex;
  double _itemWidth = 0;

  @override
  void didUpdateWidget(covariant FluBottomNavBar oldWidget) {
    getItemWidth();
    _currentIndex = widget.index;
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    _currentIndex = widget.index;
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => getItemWidth());
  }

  void getItemWidth() => setState(
        () => _itemWidth =
            (_itemKey.currentContext!.findRenderObject()! as RenderBox)
                .size
                .width,
      );

  @override
  Widget build(BuildContext context) {
    final foregroundColor =
            widget.style.foregroundColor ?? context.colorScheme.primary,
        unSelectedForegroundColor = widget.style.unSelectedForegroundColor ??
            context.colorScheme.onBackground;
    final height = widget.style.height ?? context.height * .1;

    Widget bottomNav = Container(
      height: height,
      width: double.infinity,
      padding: widget.style.padding,
      decoration: BoxDecoration(
        color: widget.style.backgroundColor,
        border: widget.style.border,
      ),
      child: Row(
        children: widget.items.map((item) {
          final index = widget.items.indexOf(item);
          final isSelected = index == _currentIndex;

          return _NavItem(
            key: widget.items.indexOf(item) == 0 ? _itemKey : null,
            item,
            onTap: () {
              setState(() => _currentIndex = index);
              widget.onItemTap?.call(index);
            },
            color: isSelected ? foregroundColor : unSelectedForegroundColor,
            iconSize: widget.style.iconSize,
            iconStrokeWidth: widget.style.iconStrokeWidth,
            iconStyle: isSelected && widget.style.selectedIconStyle != null
                ? widget.style.selectedIconStyle!
                : widget.style.iconStyle,
          );
        }).toList(),
      ),
    );

    bottomNav = Stack(
      children: [
        bottomNav,
        NavIndicator(
          animationDuration: widget.animationDuration,
          animationCurve: widget.animationCurve,
          size: widget.style.indicatorSize,
          itemWidth: _itemWidth,
          position: (_currentIndex * _itemWidth) +
              (widget.style.padding?.horizontal ?? 0) / 2,
          color: foregroundColor,
        ),
      ],
    );

    switch (widget.style.type) {
      case FluBottomNavBarTypes.curved:
        return CurvedBottomNav(child: bottomNav);
      case FluBottomNavBarTypes.flat:
        return bottomNav;
    }
  }
}

/// Create a Bottom navigation bar with a notch
class CurvedBottomNav extends StatelessWidget {
  const CurvedBottomNav({
    required this.child,
    super.key,
    this.notchMargin = 8.0,
    this.gapLocation = GapLocation.center,
    this.notchSmoothness = NotchSmoothness.softEdge,
    this.borderRadius = BorderRadius.zero,
  });

  final BorderRadius borderRadius;
  final Widget child;
  final GapLocation gapLocation;
  final double notchMargin;
  final NotchSmoothness notchSmoothness;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<BorderRadius>('borderRadius', borderRadius))
      ..add(EnumProperty<GapLocation>('gapLocation', gapLocation))
      ..add(DoubleProperty('notchMargin', notchMargin))
      ..add(EnumProperty<NotchSmoothness>('notchSmoothness', notchSmoothness))
      ..add(EnumProperty<GapLocation>('gapLocation', gapLocation))
      ..add(DoubleProperty('notchMargin', notchMargin))
      ..add(EnumProperty<NotchSmoothness>('notchSmoothness', notchSmoothness))
      ..add(EnumProperty<GapLocation>('gapLocation', gapLocation))
      ..add(DoubleProperty('notchMargin', notchMargin))
      ..add(EnumProperty<NotchSmoothness>('notchSmoothness', notchSmoothness))
      ..add(EnumProperty<GapLocation>('gapLocation', gapLocation))
      ..add(DoubleProperty('notchMargin', notchMargin))
      ..add(EnumProperty<NotchSmoothness>('notchSmoothness', notchSmoothness));
  }

  @override
  Widget build(BuildContext context) => PhysicalShape(
        clipBehavior: Clip.antiAlias,
        color: Colors.transparent,
        clipper: _CircularNotchedAndCorneredRectangleClipper(
          notchMargin: notchMargin,
          geometry: Scaffold.geometryOf(context),
          shape: _CircularNotchedAndCorneredRectangle(
            gapLocation: gapLocation,
            notchSmoothness: notchSmoothness,
            borderRadius: BorderRadius.zero,
          ),
        ),
        child: child,
      );
}

/// [FluBottomNavBar] item.
class _NavItem extends StatelessWidget {
  const _NavItem(
    this.item, {
    required this.onTap,
    required this.color,
    required this.iconSize,
    required this.iconStyle,
    required this.iconStrokeWidth,
    super.key,
  });

  final Color color;
  final double iconSize;
  final FluIconStyles iconStyle;
  final double iconStrokeWidth;
  final FluBottomNavBarItem item;
  final VoidCallback onTap;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ColorProperty('color', color))
      ..add(DoubleProperty('iconSize', iconSize))
      ..add(DoubleProperty('iconStrokeWidth', iconStrokeWidth))
      ..add(DiagnosticsProperty<FluBottomNavBarItem>('item', item))
      ..add(ObjectFlagProperty<VoidCallback>.has('onTap', onTap))
      ..add(DoubleProperty('iconSize', iconSize))
      ..add(DoubleProperty('iconStrokeWidth', iconStrokeWidth))
      ..add(DiagnosticsProperty<FluBottomNavBarItem>('item', item))
      ..add(ObjectFlagProperty<VoidCallback>.has('onTap', onTap))
      ..add(DoubleProperty('iconSize', iconSize))
      ..add(DoubleProperty('iconStrokeWidth', iconStrokeWidth))
      ..add(DiagnosticsProperty<FluBottomNavBarItem>('item', item))
      ..add(ObjectFlagProperty<VoidCallback>.has('onTap', onTap))
      ..add(DoubleProperty('iconSize', iconSize))
      ..add(DoubleProperty('iconStrokeWidth', iconStrokeWidth))
      ..add(DiagnosticsProperty<FluBottomNavBarItem>('item', item))
      ..add(ObjectFlagProperty<VoidCallback>.has('onTap', onTap))
      ..add(EnumProperty<FluIconStyles>('iconStyle', iconStyle));
  }

  @override
  Widget build(BuildContext context) => Expanded(
        child: FluButton.icon(
          item.icon,
          onPressed: onTap,
          iconSize: iconSize,
          iconStyle: iconStyle,
          iconStrokeWidth: iconStrokeWidth,
          backgroundColor: Colors.transparent,
          foregroundColor: color,
          size: double.infinity,
        ),
      );
}

/// [FluBottomNavBar] indicator.
class NavIndicator extends StatelessWidget {
  const NavIndicator({
    required this.size,
    required this.itemWidth,
    required this.position,
    required this.animationDuration,
    required this.animationCurve,
    required this.color,
    super.key,
  });

  final Curve animationCurve;
  final Duration animationDuration;
  final Color color;
  final double itemWidth;
  final double position;
  final double size;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<Curve>('animationCurve', animationCurve))
      ..add(
        DiagnosticsProperty<Duration>('animationDuration', animationDuration),
      )
      ..add(ColorProperty('color', color))
      ..add(DoubleProperty('itemWidth', itemWidth))
      ..add(DoubleProperty('position', position))
      ..add(DoubleProperty('size', size))
      ..add(
        DiagnosticsProperty<Duration>('animationDuration', animationDuration),
      )
      ..add(ColorProperty('color', color))
      ..add(DoubleProperty('itemWidth', itemWidth))
      ..add(DoubleProperty('position', position))
      ..add(DoubleProperty('size', size))
      ..add(
        DiagnosticsProperty<Duration>('animationDuration', animationDuration),
      )
      ..add(ColorProperty('color', color))
      ..add(DoubleProperty('itemWidth', itemWidth))
      ..add(DoubleProperty('position', position))
      ..add(DoubleProperty('size', size))
      ..add(
        DiagnosticsProperty<Duration>('animationDuration', animationDuration),
      )
      ..add(ColorProperty('color', color))
      ..add(DoubleProperty('itemWidth', itemWidth))
      ..add(DoubleProperty('position', position))
      ..add(DoubleProperty('size', size));
  }

  @override
  Widget build(BuildContext context) => AnimatedPositioned(
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
              ),
            ),
          ),
        ),
      );
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
    final button = geometry.value.floatingActionButtonArea
        ?.translate(0, geometry.value.bottomNavigationBarTop! * -1.0);

    return shape.getOuterPath(Offset.zero & size, button?.inflate(notchMargin));
  }

  @override
  bool shouldReclip(_CircularNotchedAndCorneredRectangleClipper oldClipper) =>
      oldClipper.geometry != geometry ||
      oldClipper.shape != shape ||
      oldClipper.notchMargin != notchMargin;
}

/// A rectangle with a smooth circular notch and rounded corners.
class _CircularNotchedAndCorneredRectangle extends NotchedShape {
  _CircularNotchedAndCorneredRectangle({
    required this.notchSmoothness,
    required this.gapLocation,
    required this.borderRadius,
    // ignore: unused_element
    this.margin = 0,
  });

  final BorderRadius borderRadius;
  final GapLocation gapLocation;
  final double margin;
  final NotchSmoothness notchSmoothness;

  @override
  Path getOuterPath(Rect host, Rect? guest) {
    if (guest == null || !host.overlaps(guest)) return Path()..addRect(host);

    final notchRadius = guest.width / 2;

    final s1 = notchSmoothness.s1;
    final s2 = notchSmoothness.s2;

    final r = notchRadius;
    final a = -1.0 * r - s2;
    final b = host.top - guest.center.dy;

    final n2 = math.sqrt(b * b * r * r * (a * a + b * b - r * r));
    final p2xA = ((a * r * r) - n2) / (a * a + b * b);
    final p2xB = ((a * r * r) + n2) / (a * a + b * b);
    final p2yA = math.sqrt(r * r - p2xA * p2xA);
    final p2yB = math.sqrt(r * r - p2xB * p2xB);

    final p = List<Offset>.filled(6, Offset.zero, growable: true);

    // p0, p1, and p2 are the control points for segment A.
    p[0] = Offset(a - s1, b);
    p[1] = Offset(a, b);
    final cmp = b < 0 ? -1.0 : 1.0;
    p[2] = cmp * p2yA > cmp * p2yB ? Offset(p2xA, p2yA) : Offset(p2xB, p2yB);

    // p3, p4, and p5 are the control points for segment B, which is a mirror
    // of segment A around the y axis.
    p[3] = Offset(-1.0 * p[2].dx, p[2].dy);
    p[4] = Offset(-1.0 * p[1].dx, p[1].dy);
    p[5] = Offset(-1.0 * p[0].dx, p[0].dy);

    // translate all points back to the absolute coordinate system.
    for (var i = 0; i < p.length; i += 1) {
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
      )
      // ..lineTo(host.right, host.bottom)
      ..arcToPoint(
        Offset(host.right, host.bottom),
        radius: borderRadius.bottomRight,
      )
      // ..lineTo(host.left, host.bottom)
      ..arcToPoint(
        Offset(host.left, host.bottom),
        radius: borderRadius.bottomLeft,
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
