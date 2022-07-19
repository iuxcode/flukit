import 'dart:math' as math;
import 'package:flukit/flukit.dart';
import 'package:flukit_icons/flukit_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

enum FluBottomNavBarType { normal, curved }

enum FluBottomNavBarIndicatorPosition { top, bottom }

enum FluBottomNavBarIndicatorStyle { normal, drop }

enum NotchSmoothness {
  sharpEdge,
  defaultEdge,
  softEdge,
  smoothEdge,
  verySmoothEdge
}

enum GapLocation { none, center, end }

extension on NotchSmoothness? {
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

class FluBottomNavBarItem {
  final FluIconModel icon;
  final FluIconModel? filledIcon;
  final String label;

  FluBottomNavBarItem(
      {required this.icon, required this.label, this.filledIcon});
}

class FluBottomNavBarStyle {
  final double height, indicatorHeight;
  final double radius;
  final double notchMargin;
  final double gapWidth;
  final EdgeInsets margin;
  final Color? background, color, activeColor, indicatorColor;
  final bool showItemLabelOnSelected, floating;
  final Duration animationDuration;
  final Curve animationCurve;
  final FluBottomNavBarIndicatorStyle indicatorStyle;
  final FluBottomNavBarIndicatorPosition indicatorPosition;
  final NotchSmoothness notchSmoothness;
  final GapLocation gapLocation;
  final FluBottomNavBarType type;
  final BorderRadius? borderRadius;

  FluBottomNavBarStyle(
      {this.background,
      this.color,
      this.activeColor,
      this.indicatorColor,
      this.height = 85.0,
      this.radius = 25.0,
      this.indicatorHeight = 8,
      this.notchMargin = 8.0,
      this.gapWidth = 45,
      this.margin = const EdgeInsets.symmetric(horizontal: 15),
      this.showItemLabelOnSelected = false,
      this.indicatorStyle = FluBottomNavBarIndicatorStyle.normal,
      this.indicatorPosition = FluBottomNavBarIndicatorPosition.bottom,
      this.animationDuration = const Duration(milliseconds: 350),
      this.animationCurve = Curves.fastOutSlowIn,
      this.notchSmoothness = NotchSmoothness.smoothEdge,
      this.gapLocation = GapLocation.center,
      this.floating = true,
      this.type = FluBottomNavBarType.normal,
      this.borderRadius});

  FluBottomNavBarStyle merge(FluBottomNavBarStyle? newStyle) =>
      FluBottomNavBarStyle(
          height: newStyle?.height ?? height,
          radius: newStyle?.radius ?? radius,
          notchMargin: newStyle?.notchMargin ?? notchMargin,
          gapWidth: newStyle?.gapWidth ?? gapWidth,
          background: newStyle?.background ?? background,
          color: newStyle?.color ?? color,
          activeColor: newStyle?.activeColor ?? activeColor,
          indicatorColor: newStyle?.indicatorColor ?? indicatorColor,
          showItemLabelOnSelected:
              newStyle?.showItemLabelOnSelected ?? showItemLabelOnSelected,
          indicatorStyle: newStyle?.indicatorStyle ?? indicatorStyle,
          indicatorPosition: newStyle?.indicatorPosition ?? indicatorPosition,
          animationDuration: newStyle?.animationDuration ?? animationDuration,
          animationCurve: newStyle?.animationCurve ?? animationCurve,
          notchSmoothness: newStyle?.notchSmoothness ?? notchSmoothness,
          gapLocation: newStyle?.gapLocation ?? gapLocation,
          floating: newStyle?.floating ?? floating,
          type: newStyle?.type ?? type,
          borderRadius: newStyle?.borderRadius ?? borderRadius,
          indicatorHeight: newStyle?.indicatorHeight ?? indicatorHeight);

  static FluBottomNavBarStyle defaultt = FluBottomNavBarStyle(
      background: Flukit.themePalette.dark,
      color: Flukit.theme.textColor,
      activeColor: Flukit.theme.primaryColor);

  static FluBottomNavBarStyle secondary = FluBottomNavBarStyle(
      background: Flukit.theme.secondaryColor,
      color: Flukit.theme.textColor,
      activeColor: Flukit.theme.primaryColor);
}

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
  State<FluBottomNavBar> createState() => BottomNavBarState();
}

class BottomNavBarState extends State<FluBottomNavBar>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  final GlobalKey itemKey = GlobalKey();

  int previousIndex = 0;
  double itemWidth = 0;

  FluBottomNavBarStyle get style =>
      widget.style ?? FluBottomNavBarStyle.defaultt;

  void getItemWidth() {
    final RenderBox box =
        itemKey.currentContext?.findRenderObject() as RenderBox;
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
            borderRadius:
                style.borderRadius ?? BorderRadius.circular(style.radius)),
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
                    items.add(_BottomNavBarItem(
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
                      activeColor:
                          style.activeColor ?? Flukit.theme.primaryColor,
                      animationDuration: style.animationDuration,
                      animationCurve: style.animationCurve,
                      showLabel: style.showItemLabelOnSelected,
                    ) as Widget);
                  }

                  return items;
                }.call()),
            _Indicator(
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
        ));

    return Container(
      margin: style.floating ? style.margin : EdgeInsets.zero,
      decoration: BoxDecoration(
        color: style.background ?? Flukit.theme.backgroundColor,
        borderRadius:
            (style.borderRadius ?? BorderRadius.circular(style.radius))
                .copyWith(
          bottomLeft: const Radius.circular(0),
          bottomRight: const Radius.circular(0),
        ),
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
                      margin: style.floating ? style.margin.left : 0)),
              child: navbar)
          : navbar,
    );
  }
}

class _BottomNavBarItem extends StatelessWidget {
  final FluBottomNavBarItem data;
  final Color color, activeColor;
  final void Function() onTap;
  final bool isSelected, showLabel;
  final Duration animationDuration;
  final Curve animationCurve;

  const _BottomNavBarItem({
    Key? key,
    required this.data,
    required this.color,
    required this.activeColor,
    required this.onTap,
    required this.animationDuration,
    required this.animationCurve,
    this.isSelected = false,
    this.showLabel = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
                    icon: isSelected && data.filledIcon != null
                        ? data.filledIcon!
                        : data.icon,
                    style: FluIconStyle(
                        color: isSelected ? activeColor : color,
                        strokeWidth: 2,
                        size: isSelected && data.filledIcon != null ? 26 : 24),
                  ),
          ),
        ),
      ),
    );
  }
}

class _Indicator extends StatelessWidget {
  final AnimationController controller;
  final double selectedIndex;
  final double gapWidth;
  final int previousIndex;
  final double height, maxWidth, radius;
  final Color color, activeColor;
  final Duration duration;
  final Curve curve;
  final FluBottomNavBarIndicatorStyle? style;
  final FluBottomNavBarIndicatorPosition position;
  final FluBottomNavBarType bottomNavBarType;

  const _Indicator({
    Key? key,
    required this.controller,
    required this.selectedIndex,
    required this.previousIndex,
    required this.height,
    required this.maxWidth,
    required this.color,
    required this.activeColor,
    required this.duration,
    required this.curve,
    required this.bottomNavBarType,
    // ignore: unused_element
    this.radius = 8,
    this.style = FluBottomNavBarIndicatorStyle.drop,
    this.position = FluBottomNavBarIndicatorPosition.top,
    this.gapWidth = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
        left: (selectedIndex * maxWidth) +
            (selectedIndex > 1 &&
                    (bottomNavBarType == FluBottomNavBarType.curved)
                ? gapWidth
                : 0),
        duration: duration,
        curve: curve,
        child: style == FluBottomNavBarIndicatorStyle.normal
            ?

            /// normal indicator
            Container(
                height: height,
                width: maxWidth,
                alignment: Alignment.bottomCenter,
                child: Container(
                    height: double.infinity,
                    width: height * 3,
                    decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(position ==
                                  FluBottomNavBarIndicatorPosition.bottom
                              ? radius
                              : 0),
                          topRight: Radius.circular(position ==
                                  FluBottomNavBarIndicatorPosition.bottom
                              ? radius
                              : 0),
                          bottomLeft: Radius.circular(
                              position == FluBottomNavBarIndicatorPosition.top
                                  ? radius
                                  : 0),
                          bottomRight: Radius.circular(
                              position == FluBottomNavBarIndicatorPosition.top
                                  ? radius
                                  : 0),
                        ),
                        boxShadow: [
                          Flukit.boxShadow(
                              blurRadius: 30,
                              offset: const Offset(0, -4),
                              color: color.withOpacity(.5))
                        ])))
            :

            /// Water drop effect indicator
            /// by [@watery-desert] on Github
            /// Original code is from him, i just changed it to fit my needs
            /// Bottom position is not supported yet
            /// TODO add bottom position
            AnimatedBuilder(
                animation: controller,
                builder: (_, __) => Stack(
                  alignment: Alignment.topCenter,
                  children: <Widget>[
                    Transform.translate(
                      offset: Tween<Offset>(
                        begin: const Offset(0, 5.0),
                        end: const Offset(0, 40),
                      )
                          .animate(CurvedAnimation(
                            parent: controller,
                            // 46
                            curve: const Interval(0.40, 1,
                                curve: Curves.fastOutSlowIn),
                          ))
                          .value,
                      child: Container(
                        width: 6.0,
                        height: 6.0,
                        decoration: BoxDecoration(
                          color: controller.value > 0.65
                              ? Colors.transparent
                              : activeColor,
                          // color: Colors.amber,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Opacity(
                      opacity: controller.value <= 0.45 ? 1.0 : 0.0,
                      child: _FallingDrop(
                        itemWidth: maxWidth,
                        color: color,
                        width: Tween<double>(begin: 56, end: 40)
                            .animate(
                              CurvedAnimation(
                                parent: controller,
                                curve: const Interval(0.45, 0.55),
                              ),
                            )
                            .value,
                        height: Tween<double>(begin: 16, end: 24)
                            .animate(
                              CurvedAnimation(
                                parent: controller,
                                curve: const Interval(0.45, 0.55),
                              ),
                            )
                            .value,
                      ),
                    ),
                    Opacity(
                      opacity: controller.value >= 0.45 ? 1.0 : 0.0,
                      child: _FallingDrop(
                        itemWidth: maxWidth,
                        color: color,
                        width: Tween<double>(begin: 40, end: 56)
                            .animate(
                              CurvedAnimation(
                                parent: controller,
                                curve: const Interval(0.45, 0.60),
                              ),
                            )
                            .value,
                        height: Tween<double>(begin: 24, end: 16)
                            .animate(
                              CurvedAnimation(
                                parent: controller,
                                curve: const Interval(0.45, 0.60),
                              ),
                            )
                            .value,
                      ),
                    ),
                  ],
                ),
              ));
  }
}

/// Initial code from [@watery-desert] on Github
/// i just updated it to fit my needs
class _FallingDrop extends StatelessWidget {
  final double width;
  final double height;
  final Color? color;
  final double itemWidth;

  const _FallingDrop({
    required this.width,
    required this.height,
    this.color,
    required this.itemWidth,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: itemWidth,
      child: UnconstrainedBox(
          child: SizedBox(
        width: width,
        height: height,
        child: CustomPaint(
          size: Size.zero,
          painter: _WaterPainter(color ?? Flukit.theme.primaryColor),
        ),
      )),
    );
  }
}

class _WaterPainter extends CustomPainter {
  final Color color;

  _WaterPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path()
      ..cubicTo(
        size.width * 0.239841,
        size.height * 0.06489535,
        size.width * 0.285956,
        size.height * 0.4886860,
        size.width * 0.42016,
        size.height * 0.8271512,
      )
      ..cubicTo(
        size.width * 0.467771,
        size.height * 0.9466628,
        size.width * 0.530574,
        size.height * 0.9472209,
        size.width * 0.578344,
        size.height * 0.8285814,
      )
      ..cubicTo(
          size.width * 0.7185669,
          size.height * 0.4786744,
          size.width * 0.757325,
          size.height * 0.06629070,
          size.width * 0.999682,
          0)
      ..lineTo(0, 0);
    path.close();

    Paint fillColor = Paint()..style = PaintingStyle.fill;

    fillColor.color = color;
    canvas.drawPath(path, fillColor);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class CircularNotchedAndCorneredRectangleClipper extends CustomClipper<Path> {
  final ValueListenable<ScaffoldGeometry> geometry;
  final NotchedShape shape;
  final double notchMargin;

  CircularNotchedAndCorneredRectangleClipper({
    required this.geometry,
    required this.shape,
    required this.notchMargin,
  }) : super(reclip: geometry);

  @override
  Path getClip(Size size) {
    final Rect? button = geometry.value.floatingActionButtonArea
        ?.translate(0.0, geometry.value.bottomNavigationBarTop! * -1.0);

    return shape.getOuterPath(Offset.zero & size, button?.inflate(notchMargin));
  }

  @override
  bool shouldReclip(CircularNotchedAndCorneredRectangleClipper oldClipper) {
    return oldClipper.geometry != geometry ||
        oldClipper.shape != shape ||
        oldClipper.notchMargin != notchMargin;
  }
}

class CircularNotchedAndCorneredRectangle extends NotchedShape {
  final NotchSmoothness notchSmoothness;
  final GapLocation gapLocation;
  final double radius;
  final BorderRadius? borderRadius;
  final double margin;

  CircularNotchedAndCorneredRectangle(
      {required this.notchSmoothness,
      required this.gapLocation,
      required this.radius,
      this.borderRadius,
      this.margin = 0});

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
        radius: borderRadius?.topLeft ?? Radius.circular(radius),
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
        radius: borderRadius?.topRight ?? Radius.circular(radius),
        clockwise: true,
      )
      // ..lineTo(host.right, host.bottom)
      ..arcToPoint(
        Offset(host.right, host.bottom),
        radius: borderRadius?.bottomRight ?? Radius.circular(radius),
        clockwise: true,
      )
      // ..lineTo(host.left, host.bottom)
      ..arcToPoint(
        Offset(host.left, host.bottom),
        radius: borderRadius?.bottomLeft ?? Radius.circular(radius),
        clockwise: true,
      )
      ..close();
  }
}
