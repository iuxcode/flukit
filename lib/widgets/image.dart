import 'dart:io' as io;
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

/// Display an image
/// By default this will call the image from network.
/// If you want to load image from assets, you can use [FluImage.asset]
class FluImage extends StatelessWidget {
  const FluImage(
    this.image, {
    this.overlayOpacity = 0.0,
    this.overlayColor,
    this.gradientOverlay = false,
    this.gradientOverlayBegin = Alignment.topCenter,
    this.gradientOverlayEnd = Alignment.bottomCenter,
    this.height,
    this.width,
    this.fit = BoxFit.cover,
    this.cornerRadius = 0,
    this.borderRadius,
    super.key,
  });

  /// Image url
  final String image;

  /// OverlayOpacity. If this is upper than 0, an overlay of color specified by [overlayColor] will be display on the
  /// top of the image.
  final double overlayOpacity;

  /// Modify the image overlay color.
  final Color? overlayColor;

  /// Display the overlay as a gradient.
  final bool gradientOverlay;

  /// The offset at which stop 0.0 of the gradient is placed.
  final Alignment gradientOverlayBegin;

  /// The offset at which stop 1.0 of the gradient is placed
  final Alignment gradientOverlayEnd;

  /// Image height
  final double? height;

  /// Image width
  final double? width;

  /// How to inscribe the picture into the space allocated during layout.
  /// The default value is [BoxFit.cover].
  final BoxFit fit;

  /// Round all image corner with the value defined.
  final double cornerRadius;

  /// If non-null, the corners of this box are rounded by this [BorderRadius].
  final BorderRadius? borderRadius;

  /// Display an image from assets
  factory FluImage.asset(String name,
      {double overlayOpacity = 0.0,
      Color? overlayColor,
      bool gradientOverlay = false,
      Alignment gradientOverlayBegin = Alignment.topCenter,
      Alignment gradientOverlayEnd = Alignment.bottomCenter,
      double? height,
      double? width,
      BoxFit fit = BoxFit.cover,
      double cornerRadius = 0.0,
      BorderRadius? borderRadius,
      Key? key}) {
    return _FluImageFrom(
      name,
      overlayOpacity: overlayOpacity,
      overlayColor: overlayColor,
      gradientOverlay: gradientOverlay,
      gradientOverlayBegin: gradientOverlayBegin,
      gradientOverlayEnd: gradientOverlayEnd,
      cornerRadius: cornerRadius,
      borderRadius: borderRadius,
      height: height,
      width: width,
      fit: fit,
      child: Image.asset(
        name,
        fit: fit,
        height: height,
        width: width,
      ),
    );
  }

  /// Display an image file
  factory FluImage.file(String path,
      {double overlayOpacity = 0.0,
      Color? overlayColor,
      bool gradientOverlay = false,
      Alignment gradientOverlayBegin = Alignment.topCenter,
      Alignment gradientOverlayEnd = Alignment.bottomCenter,
      double? height,
      double? width,
      BoxFit fit = BoxFit.cover,
      double cornerRadius = 0.0,
      BorderRadius? borderRadius,
      Key? key}) {
    return _FluImageFrom(
      path,
      overlayOpacity: overlayOpacity,
      overlayColor: overlayColor,
      gradientOverlay: gradientOverlay,
      gradientOverlayBegin: gradientOverlayBegin,
      gradientOverlayEnd: gradientOverlayEnd,
      cornerRadius: cornerRadius,
      borderRadius: borderRadius,
      height: height,
      width: width,
      fit: fit,
      child: Image.file(
        io.File(path),
        fit: fit,
        height: height,
        width: width,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _Image(
      key: key,
      overlayOpacity: overlayOpacity,
      overlayColor: overlayColor,
      gradientOverlay: gradientOverlay,
      gradientOverlayBegin: gradientOverlayBegin,
      gradientOverlayEnd: gradientOverlayEnd,
      cornerRadius: cornerRadius,
      borderRadius: borderRadius,
      child: CachedNetworkImage(
        imageUrl: image,
        fit: fit,
        height: height,
        width: width,
      ),
    );
  }
}

class _FluImageFrom extends FluImage {
  const _FluImageFrom(
    this.image, {
    required this.child,
    super.key,
    super.overlayColor,
    super.overlayOpacity,
    super.gradientOverlay,
    super.gradientOverlayBegin,
    super.gradientOverlayEnd,
    super.height,
    super.width,
    super.fit,
    super.cornerRadius,
    super.borderRadius,
  }) : super(image);

  final String image;
  final Image child;

  @override
  Widget build(BuildContext context) {
    return _Image(
      key: key,
      overlayOpacity: overlayOpacity,
      overlayColor: overlayColor,
      gradientOverlay: gradientOverlay,
      gradientOverlayBegin: gradientOverlayBegin,
      gradientOverlayEnd: gradientOverlayEnd,
      cornerRadius: cornerRadius,
      borderRadius: borderRadius,
      child: child,
    );
  }
}

class _Image extends StatelessWidget {
  const _Image(
      {required this.child,
      this.overlayOpacity = 0.0,
      this.overlayColor,
      this.gradientOverlay = false,
      this.gradientOverlayBegin = Alignment.topCenter,
      this.gradientOverlayEnd = Alignment.bottomCenter,
      this.cornerRadius = 0.0,
      this.borderRadius,
      super.key});

  final Widget child;
  final double overlayOpacity;
  final Color? overlayColor;
  final bool gradientOverlay;
  final Alignment gradientOverlayBegin;
  final Alignment gradientOverlayEnd;
  final double cornerRadius;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    Widget child;

    if (overlayOpacity > 0) {
      child = Stack(children: [
        this.child,
        Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                color: gradientOverlay
                    ? null
                    : (overlayColor ?? Colors.black)
                        .withOpacity(overlayOpacity),
                gradient: gradientOverlay
                    ? LinearGradient(colors: [
                        Colors.transparent,
                        overlayColor ?? Colors.black,
                      ], begin: gradientOverlayBegin, end: gradientOverlayEnd)
                    : null,
              ),
            ))
      ]);
    } else {
      child = this.child;
    }

    if (cornerRadius > 0 || borderRadius != null) {
      return Container(
        decoration: BoxDecoration(
            borderRadius: borderRadius ?? BorderRadius.circular(cornerRadius)),
        clipBehavior: Clip.antiAlias,
        child: child,
      );
    }

    return child;
  }
}
