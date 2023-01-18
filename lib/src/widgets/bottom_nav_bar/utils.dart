import 'dart:math' as math;

import 'package:flukit/src/utils/flu_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'style.dart';

class FluBottomNavBarIndicator extends StatelessWidget {
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

  const FluBottomNavBarIndicator({
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
    this.radius = 18,
    this.style = FluBottomNavBarIndicatorStyle.drop,
    this.position = FluBottomNavBarIndicatorPosition.top,
    this.gapWidth = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget indicator;

    if (style == FluBottomNavBarIndicatorStyle.normal) {
      /// Default indicator
      indicator = Container(
        height: height,
        width: maxWidth,
        alignment: Alignment.bottomCenter,
        child: Container(
          height: double.infinity,
          width: height * 3,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(
                  position == FluBottomNavBarIndicatorPosition.bottom
                      ? radius
                      : 0),
              topRight: Radius.circular(
                  position == FluBottomNavBarIndicatorPosition.bottom
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
              Flu.boxShadow(
                  blurRadius: 30,
                  offset: const Offset(0, -4),
                  color: color.withOpacity(.5))
            ],
          ),
        ),
      );
    } else {
      /// Water drop effect indicator
      /// by [@watery-desert] on Github
      /// Original code is from him, i just changed it to fit my needs
      /// Bottom position is not supported yet
      /// TODO add bottom position
      indicator = AnimatedBuilder(
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
                    curve: const Interval(0.40, 1, curve: Curves.fastOutSlowIn),
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
      );
    }

    return AnimatedPositioned(
      left: (selectedIndex * maxWidth) +
          (selectedIndex > 1 && (bottomNavBarType == FluBottomNavBarType.curved)
              ? gapWidth
              : 0),
      duration: duration,
      curve: curve,
      child: indicator,
    );
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
          painter: _WaterPainter(color ?? Flu.theme.primary),
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
