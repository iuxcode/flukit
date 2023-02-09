import 'dart:io' as io;
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

/// Display an image
/// By default this will call the image from network.
/// If you want to load image from assets, you can use [FluImage.asset]
class FluImage extends StatelessWidget {
  const FluImage(
    this.image, {
    this.imageSource = ImageSources.network,
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

  /// Image source.
  /// Can be from `asset`, `network` or `system`.
  final ImageSources imageSource;

  @override
  Widget build(BuildContext context) {
    Widget child;

    switch (imageSource) {
      case ImageSources.network:
        child = CachedNetworkImage(
          imageUrl: this.image,
          fit: fit,
          height: height,
          width: width,
        );
        break;
      case ImageSources.asset:
        child = Image.asset(
          this.image,
          fit: fit,
          height: height,
          width: width,
        );
        break;
      case ImageSources.system:
        child = Image.file(
          io.File(this.image),
          fit: fit,
          height: height,
          width: width,
        );
        break;
    }

    /// Add overlay if the opacity is > 0
    if (overlayOpacity > 0) {
      child = Stack(children: [
        child,
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
    }

    /// Add cornerRadius or borderRadius
    if (cornerRadius > 0 || borderRadius != null) {
      child = Container(
        decoration: BoxDecoration(
            borderRadius: borderRadius ?? BorderRadius.circular(cornerRadius)),
        clipBehavior: Clip.antiAlias,
        child: child,
      );
    }

    return child;
  }
}

enum ImageSources { network, asset, system }
