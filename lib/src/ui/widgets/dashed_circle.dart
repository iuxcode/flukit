import 'dart:math';

import 'package:flukit/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// Draw an arc
class FluArc extends StatelessWidget {
  const FluArc({
    super.key,
    this.color,
    this.disabledDashColor,
    this.strokeWidth = 3,
    this.numberOfDashes = 0,
    this.gapSize = 5,
    this.angle = 360,
    this.disableDashStart = -1,
    this.startOfArc = 0,
    this.strokeCap = StrokeCap.square,
    this.size = 62,
    this.child,
  });

  final Widget? child;

  /// Arc angle. Eg: 360 for full circle
  final int angle;

  /// Arc color
  final Color? color;

  /// Index at which some dashes will look disabled
  /// Eg. you're building a story circle and
  /// you want to highlight viewed stories
  final int disableDashStart;

  /// If [numberOfDashes] > 0 and [disableDashStart] != -1,
  /// this color specify the color
  /// of dashes that index will be under [disableDashStart]
  final Color? disabledDashColor;

  /// Space between dashes
  final int gapSize;

  /// Number of dashes
  /// If > 0, the arc will sliced into [numberOfDashes] parts.
  final int numberOfDashes;

  /// size
  final double size;

  /// Where the arc start in degree
  final double startOfArc;

  /// The kind of finish to place on the end of lines
  /// drawn when `style` is set to [PaintingStyle.stroke].
  /// Defaults to [StrokeCap.square]
  final StrokeCap strokeCap;

  /// Arc strokeWidth
  final double strokeWidth;

  @override
  Widget build(BuildContext context) => CustomPaint(
        painter: _ArcPainter(
          color: color ?? context.colorScheme.primary,
          disabledDashColor:
              disabledDashColor ?? context.colorScheme.surfaceVariant,
          strokeWidth: strokeWidth,
          numberOfDashes: numberOfDashes,
          gapSize: gapSize,
          angle: angle,
          disableDashStart: disableDashStart,
          dashed: numberOfDashes > 0,
          startOfArc: startOfArc,
          strokeCap: strokeCap,
        ),
        child: child ??
            SizedBox(
              width: size,
              height: size,
            ),
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(IntProperty('angle', angle))
      ..add(ColorProperty('color', color))
      ..add(IntProperty('disableDashStart', disableDashStart))
      ..add(ColorProperty('disabledDashColor', disabledDashColor))
      ..add(IntProperty('gapSize', gapSize))
      ..add(IntProperty('numberOfDashes', numberOfDashes))
      ..add(DoubleProperty('size', size))
      ..add(DoubleProperty('startOfArc', startOfArc))
      ..add(EnumProperty<StrokeCap>('strokeCap', strokeCap))
      ..add(DoubleProperty('strokeWidth', strokeWidth))
      ..add(ColorProperty('color', color))
      ..add(IntProperty('disableDashStart', disableDashStart))
      ..add(ColorProperty('disabledDashColor', disabledDashColor))
      ..add(IntProperty('gapSize', gapSize))
      ..add(IntProperty('numberOfDashes', numberOfDashes))
      ..add(DoubleProperty('size', size))
      ..add(DoubleProperty('startOfArc', startOfArc))
      ..add(EnumProperty<StrokeCap>('strokeCap', strokeCap))
      ..add(DoubleProperty('strokeWidth', strokeWidth))
      ..add(ColorProperty('color', color))
      ..add(IntProperty('disableDashStart', disableDashStart))
      ..add(ColorProperty('disabledDashColor', disabledDashColor))
      ..add(IntProperty('gapSize', gapSize))
      ..add(IntProperty('numberOfDashes', numberOfDashes))
      ..add(DoubleProperty('size', size))
      ..add(DoubleProperty('startOfArc', startOfArc))
      ..add(EnumProperty<StrokeCap>('strokeCap', strokeCap))
      ..add(DoubleProperty('strokeWidth', strokeWidth))
      ..add(ColorProperty('color', color))
      ..add(IntProperty('disableDashStart', disableDashStart))
      ..add(ColorProperty('disabledDashColor', disabledDashColor))
      ..add(IntProperty('gapSize', gapSize))
      ..add(IntProperty('numberOfDashes', numberOfDashes))
      ..add(DoubleProperty('size', size))
      ..add(DoubleProperty('startOfArc', startOfArc))
      ..add(EnumProperty<StrokeCap>('strokeCap', strokeCap))
      ..add(DoubleProperty('strokeWidth', strokeWidth));
  }
}

class _ArcPainter extends CustomPainter {
  _ArcPainter({
    required this.color,
    required this.disabledDashColor,
    required this.strokeWidth,
    required this.dashed,
    required this.numberOfDashes,
    required this.gapSize,
    required this.angle,
    required this.disableDashStart,
    required this.startOfArc,
    required this.strokeCap,
  });

  final int angle;
  final Color color;
  final bool dashed;
  final int disableDashStart;
  final Color disabledDashColor;
  final int gapSize;
  final int numberOfDashes;
  final double startOfArc;
  final StrokeCap strokeCap;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);

    if (!dashed) {
      canvas.drawArc(
        rect,
        inRads(startOfArc),
        inRads(angle.toDouble()),
        false,
        Paint()
          ..strokeCap = strokeCap
          ..strokeWidth = strokeWidth
          ..style = PaintingStyle.stroke
          ..color = color,
      );
    } else {
      var startOfArc = this.startOfArc;

      // circle angle is 360, remove all space arcs between the main story
      // arc (the number of spaces(stories) times the  space length
      // then subtract the number from 360 to get ALL arcs length
      // then divide the ALL arcs length by number of Arc (number of stories)
      // to get the exact length of one arc
      var arcLength = (angle - (numberOfDashes * gapSize)) / numberOfDashes;

      // be careful here when arc is a negative number
      // that happens when the number of spaces is more than 360
      // feel free to use what logic you want to take care of that
      // note that numberOfDashes should be limited too here
      if (arcLength <= 0) {
        arcLength = angle / gapSize - 1;
      }

      //looping for number of stories to draw every story arc
      for (var i = 0; i < numberOfDashes; i++) {
        //printing the arc
        canvas.drawArc(
          rect,
          inRads(startOfArc),
          //be careful here is:  "double sweepAngle", not "end"
          inRads(arcLength),
          false,
          Paint()
            // here you can compare your SEEN story index with
            //the arc index to make it grey
            ..color = (i >= disableDashStart) ? color : disabledDashColor
            ..strokeWidth = strokeWidth
            ..style = PaintingStyle.stroke,
        );

        // the logic of spaces between the arcs is to start the next arc
        //after jumping the length of space
        startOfArc += arcLength + gapSize;
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;

  //drawArc deals with rads, easier for me to use degrees
  //so this takes a degree and change it to rad
  double inRads(double degree) => (degree * pi) / 180;
}
