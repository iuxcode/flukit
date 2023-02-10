import 'dart:math';
import 'package:flutter/material.dart';

/// Draw an arc
class FluArc extends StatelessWidget {
  const FluArc({
    super.key,
    required this.child,
    this.color,
    this.disabledDashColor,
    this.strokeWidth = 4,
    this.numberOfDashes = 0,
    this.gapSize = 5,
    this.angle = 360,
    this.disableDashStart = -1,
  });

  final Widget child;

  /// Arc color
  final Color? color;

  /// If [numberOfDashes] > 0 and [disableDashStart] != -1, this color specify the color
  /// of dashes that index will be under [disableDashStart]
  final Color? disabledDashColor;

  /// Arc strokeWidth
  final double strokeWidth;

  /// Number of dashes
  /// If > 0, the arc will sliced into [numberOfDashes] parts.
  final int numberOfDashes;

  /// Space between dashes
  final int gapSize;

  /// Arc angle. Eg: 360 for full circle
  final int angle;

  /// Index at which some dashes will look disabled
  /// Eg. you're building a story circle and you want to highlight viewed stories
  final int disableDashStart;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return CustomPaint(
      painter: _ArcPainter(
          color: color ?? colorScheme.primary,
          disabledDashColor: disabledDashColor ?? colorScheme.surfaceVariant,
          strokeWidth: strokeWidth,
          numberOfDashes: numberOfDashes,
          gapSize: gapSize,
          angle: angle,
          disableDashStart: disableDashStart,
          dashed: numberOfDashes > 0),
      child: child,
    );
  }
}

class _ArcPainter extends CustomPainter {
  final Color color;
  final Color disabledDashColor;
  final double strokeWidth;
  final bool dashed;
  final int numberOfDashes;
  final int gapSize;
  final int angle;
  final int disableDashStart;
  double startOfArcInDegree = 0;

  _ArcPainter({
    required this.color,
    required this.disabledDashColor,
    this.strokeWidth = 4.0,
    this.dashed = false,
    this.numberOfDashes = 5,
    this.gapSize = 10,
    this.angle = 180,
    this.disableDashStart = -1,
  });

  //drawArc deals with rads, easier for me to use degrees
  //so this takes a degree and change it to rad
  double inRads(double degree) {
    return (degree * pi) / 180;
  }

  @override
  void paint(Canvas canvas, Size size) {
    const double baseAngle = 0, radius = 65;

    if (!dashed) {
      Rect rect = Rect.fromCircle(
          center: Offset(size.width / 2, size.height / 2), radius: radius);
      canvas.drawArc(
          rect,
          baseAngle,
          pi,
          false,
          Paint()
            ..strokeCap = StrokeCap.round
            ..strokeWidth = strokeWidth
            ..style = PaintingStyle.stroke
            ..color = color);
    } else {
      //circle angle is 360, remove all space arcs between the main story arc (the number of spaces(stories) times the  space length
      //then subtract the number from 360 to get ALL arcs length
      //then divide the ALL arcs length by number of Arc (number of stories) to get the exact length of one arc
      double arcLength = (angle - (numberOfDashes * gapSize)) / numberOfDashes;

      //be careful here when arc is a negative number
      //that happens when the number of spaces is more than 360
      //feel free to use what logic you want to take care of that
      //note that numberOfDashes should be limited too here
      if (arcLength <= 0) {
        arcLength = angle / gapSize - 1;
      }

      Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);

      //looping for number of stories to draw every story arc
      for (int i = 0; i < numberOfDashes; i++) {
        //printing the arc
        canvas.drawArc(
          rect,
          inRads(startOfArcInDegree),
          //be careful here is:  "double sweepAngle", not "end"
          inRads(arcLength),
          false,
          Paint()
            //here you can compare your SEEN story index with the arc index to make it grey
            ..color = (i >= disableDashStart) ? color : disabledDashColor
            ..strokeWidth = strokeWidth
            ..style = PaintingStyle.stroke,
        );

        //the logic of spaces between the arcs is to start the next arc after jumping the length of space
        startOfArcInDegree += arcLength + gapSize;
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
