/* 
  Initial code from @yasirdx777 on github
 */

import 'dart:math' as math;
import 'package:flutter/material.dart';


// Progress bar widget
// ignore: must_be_immutable
class FluSquareProgressBar extends StatefulWidget {
  final double progress;
  double? width;
  double? height;
  double? maxWidth;
  final Color solidBarColor;
  final Color emptyBarColor;
  final double strokeWidth;
  final StrokeCap barStrokeCap;
  LinearGradient? gradientBarColor;
  final bool isAnimation;
  final Duration animationDuration;
  final Curve animationCurve;
  final bool isRtl;
  Widget? child;

  FluSquareProgressBar({
    Key? key,
    required this.progress,
    this.solidBarColor = Colors.blue,
    this.emptyBarColor = Colors.grey,
    this.gradientBarColor,
    this.strokeWidth = 3,
    this.barStrokeCap = StrokeCap.round,
    this.isAnimation = false,
    this.animationDuration = const Duration(seconds: 2),
    this.animationCurve = Curves.linear,
    this.isRtl = false,
    this.width,
    this.height,
    this.maxWidth,
    this.child,
  }) : super(key: key);

  @override
  State<FluSquareProgressBar> createState() => _SquareProgressBarState();
}

class _SquareProgressBarState extends State<FluSquareProgressBar>
    with SingleTickerProviderStateMixin {
  AnimationController? animationController;

  // only initiate the animation controller if isAnimation is true
  @override
  void initState() {
    super.initState();

    if (!widget.isAnimation) return;

    animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );

    animationController?.forward();
  }

  // - if size is not specified the progress bar size will set to biggest size available
  // - if isRtl is true the progres bar will rotate 180°
  // - if isRtl is true the progres bar child widget will rotate 180° which will rotate the child widget to it's original angle
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: widget.height,
      width: widget.width,
      constraints: BoxConstraints(
        maxWidth: widget.maxWidth ?? 0.0,
      ),
      duration: widget.animationDuration,
      curve: widget.animationCurve,
      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationY(widget.isRtl ? math.pi : 0),
        child: CustomPaint(
          painter: _RadialPainter(
            animationController: animationController,
            progress: widget.progress,
            isAnimation: widget.isAnimation,
            solidBarColor: widget.solidBarColor,
            emptyBarColor: widget.emptyBarColor,
            gradientBarColor: widget.gradientBarColor,
            strokeWidth: widget.strokeWidth,
            barStrokeCap: widget.barStrokeCap,
          ),
          child: Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(widget.isRtl ? math.pi : 0),
            child: widget.child,
          ),
        ),
      ),
    );
  }

  // disposing the animation controller for preventing memory leak
  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }
}


// Custom painter to draw the the prgress bar
class _RadialPainter extends CustomPainter {
  // animation controller for controlling progress bar animation start and reset
  final AnimationController? animationController;
  // the animation var is used to hold the continuous value of the animated from 0.0 to max progress value
  late Animation<double> _animation;
  // the max value of the progress
  final double progress;
  // the current progress of the bar
  double _barProgress = 0.0;
  // the color of the main bar
  final Color solidBarColor;
  // the color of the empty space
  final Color emptyBarColor;
  // the gradient color, if it's not null it will be used instead of solid color for main bar
  final LinearGradient? gradientBarColor;
  // for specify the main bar Width
  final double strokeWidth;
  // for specify the main bar head shape either rounded or square
  final StrokeCap barStrokeCap;
  // for enable or disable animate the progress of the main bar
  final bool isAnimation;

  _RadialPainter({
    required this.animationController,
    required this.progress,
    required this.solidBarColor,
    required this.emptyBarColor,
    required this.gradientBarColor,
    required this.strokeWidth,
    required this.barStrokeCap,
    required this.isAnimation,
  }) : super(repaint: animationController);

  // specify the base line shape and color for draw the empty space bar
  Paint paintEmptyBar() {
    final Paint paintBase = Paint()
      ..strokeWidth = strokeWidth
      ..color = emptyBarColor
      ..style = PaintingStyle.stroke
      ..strokeCap = barStrokeCap;

    return paintBase;
  }

  // specify the base line size draw start and end point
  Path createEmptyBarBasePath(Size size) {
    final Path pathBase = Path();

    pathBase.moveTo(0, 0);
    pathBase.quadraticBezierTo(0, 0, size.width, 0);

    pathBase.moveTo(size.width, 0);
    pathBase.quadraticBezierTo(size.width, 0, size.width, size.height);

    pathBase.moveTo(size.width, size.height);
    pathBase.quadraticBezierTo(size.width, size.height, 0, size.height);

    pathBase.moveTo(0, size.height);
    pathBase.quadraticBezierTo(0, (size.height), 0, 0);

    return pathBase;
  }

  // specify the main line shape and color for draw the empty space bar
  Paint paintBar(Size size) {
    final Paint paint = Paint()
      ..strokeWidth = strokeWidth
      ..color = solidBarColor
      ..style = PaintingStyle.stroke
      ..strokeCap = barStrokeCap;

    if (gradientBarColor != null) {
      // apply gradient color if it's not null
      final Rect rect = Rect.fromCircle(
        center: Offset(size.width / 2, size.width / 2),
        radius: size.width,
      );

      paint.shader = gradientBarColor!.createShader(rect);
    }

    return paint;
  }

  // specify the main line size draw start and end point
  // main line have 4 break points that will draw the line in different direction
  // 1: 0.0 - 0.25: The top line
  // 2: 0.25 - 0.5: The right line
  // 3: 0.5 - 0.75: The bottom line
  // 4: 0.75 - 1.0: The left line which will complate the draw of the square when the porgress rech 1.0 (100%)
  Path createBarPath(Size size, double progress) {
    final Path path = Path();

    if (progress >= 0.0 && progress <= 0.25) {
      var k = ((progress / 0.25) * 100) / 100;
      path.moveTo(0, 0);
      path.quadraticBezierTo(0, 0, size.width * k, 0);
    } else if (progress >= 0.25 && progress <= 0.5) {
      path.moveTo(0, 0);
      path.quadraticBezierTo(0, 0, size.width, 0);

      var k = (((progress - 0.25) / 0.25) * 100) / 100;

      path.moveTo(size.width, 0);
      path.quadraticBezierTo(size.width, 0, size.width, size.height * k);
    } else if (progress >= 0.5 && progress <= 0.75) {
      path.moveTo(0, 0);
      path.quadraticBezierTo(0, 0, size.width, 0);

      path.moveTo(size.width, 0);
      path.quadraticBezierTo(size.width, 0, size.width, size.height);

      var k = (((progress - 0.5) / 0.25) * 100) / 100;

      path.moveTo(size.width, size.height);
      path.quadraticBezierTo(
          size.width, size.height, size.width * (1 - k), size.height);
    } else if (progress >= 0.5 && progress <= 1) {
      path.moveTo(0, 0);
      path.quadraticBezierTo(0, 0, size.width, 0);

      path.moveTo(size.width, 0);
      path.quadraticBezierTo(size.width, 0, size.width, size.height);

      path.moveTo(size.width, size.height);
      path.quadraticBezierTo(size.width, size.height, 0, size.height);

      var k = (((progress - 0.75) / 0.25) * 100) / 100;

      path.moveTo(0, size.height);
      path.quadraticBezierTo(0, size.height, 0, (size.height) * (1 - k));
    } else if (progress > 1) {
      path.moveTo(0, 0);
      path.quadraticBezierTo(0, 0, size.width, 0);

      path.moveTo(size.width, 0);
      path.quadraticBezierTo(size.width, 0, size.width, size.height);

      path.moveTo(size.width, size.height);
      path.quadraticBezierTo(size.width, size.height, 0, size.height);

      path.moveTo(0, size.height);
      path.quadraticBezierTo(0, (size.height), 0, 0);
    } else {
      debugPrint("Path Error");
    }

    return path;
  }

  // specify the current progress of the main bar size
  // if it's not animated will set the progress to max value directly
  // if it's animated the progress value will be set over diffrent time perid in range from 0.0 to the max value
  void setBarProgress() {
    if (!isAnimation) {
      _barProgress = progress;
      return;
    }

    _animation = Tween(begin: 0.0, end: progress).animate(animationController!)
      ..addListener(() {
        _barProgress = _animation.value;
      });
  }

  // start drawing the progress bar
  @override
  void paint(Canvas canvas, Size size) {
    final Paint emptyBar = paintEmptyBar();
    final Path emptyBarPath = createEmptyBarBasePath(size);

    canvas.drawPath(emptyBarPath, emptyBar);

    setBarProgress();

    final Paint bar = paintBar(size);
    final Path barPath = createBarPath(size, _barProgress);

    canvas.drawPath(barPath, bar);
  }

  // redrawing the progress bar if needed and restart the animation if it's enabled
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    animationController?.reset();
    animationController?.forward();
    return true;
  }
}