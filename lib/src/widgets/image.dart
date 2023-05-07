import 'dart:io' as io;
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
    this.package,
    this.circle = false,
    this.square = false,
    this.expand = false,
    this.margin = EdgeInsets.zero,
    super.key,
  });

  const factory FluImage.svg(String svg,
      {Color? color,
      ImageSources source,
      BoxFit fit,
      double? height,
      double? width}) = _FluSvgImage;

  /// If non-null, the corners of this box are rounded by this [BorderRadius].
  final BorderRadius? borderRadius;

  /// Set to true, if you want the image to be a circle
  final bool circle;

  /// Round all image corner with the value defined.
  final double cornerRadius;

  /// Fill
  final bool expand;

  /// How to inscribe the picture into the space allocated during layout.
  /// The default value is [BoxFit.cover].
  final BoxFit fit;

  /// Display the overlay as a gradient.
  final bool gradientOverlay;

  /// The offset at which stop 0.0 of the gradient is placed.
  final Alignment gradientOverlayBegin;

  /// The offset at which stop 1.0 of the gradient is placed
  final Alignment gradientOverlayEnd;

  /// Image height
  final double? height;

  /// Image url
  final String image;

  /// Image source.
  /// Can be from `asset`, `network` or `system`.
  final ImageSources imageSource;

  /// Empty space to surround the avatar and [child].
  final EdgeInsets margin;

  /// Modify the image overlay color.
  final Color? overlayColor;

  /// OverlayOpacity. If this is upper than 0, an overlay of color specified by [overlayColor] will be display on the
  /// top of the image.
  final double overlayOpacity;

  /// The package argument must be non-null when displaying an image from a `package` and null otherwise. See the `Assets in packages` section for details.
  final String? package;

  /// Set to true, if you want the image height to be equal to its width
  final bool square;

  /// Image width
  final double? width;

  @override
  Widget build(BuildContext context) {
    Widget child;
    double? height = expand ? double.infinity : this.height,
        width = expand ? double.infinity : this.width;

    if (square) {
      double? size = _dimensionsToSquare(this.height, this.width);
      height = size;
      width = size;
    }

    switch (imageSource) {
      case ImageSources.network:
        child = CachedNetworkImage(
          imageUrl: image,
          fit: fit,
          height: height,
          width: width,
        );
        break;
      case ImageSources.asset:
        child = Image.asset(
          image,
          fit: fit,
          height: height,
          width: width,
          package: package,
        );
        break;
      case ImageSources.system:
        child = Image.file(
          io.File(image),
          fit: fit,
          height: height,
          width: width,
        );
        break;
    }

    /// Add overlay if the opacity is > 0
    if (overlayOpacity > 0) {
      child = Stack(
        children: [
          child,
          Positioned.fill(
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
                        (overlayColor ?? Colors.black)
                            .withOpacity(overlayOpacity),
                      ], begin: gradientOverlayBegin, end: gradientOverlayEnd)
                    : null,
              ),
            ),
          )
        ],
      );
    }

    /// Add cornerRadius or borderRadius
    if (cornerRadius > 0 || borderRadius != null || margin != EdgeInsets.zero) {
      child = Container(
        margin: margin,
        decoration: BoxDecoration(
          shape: circle ? BoxShape.circle : BoxShape.rectangle,
          borderRadius: !circle
              ? (borderRadius ?? BorderRadius.circular(cornerRadius))
              : null,
        ),
        clipBehavior: Clip.antiAlias,
        child: child,
      );
    }

    return child;
  }
}

class _FluSvgImage extends FluImage {
  const _FluSvgImage(
    super.image, {
    this.color,
    ImageSources source = ImageSources.asset,
    super.fit = BoxFit.contain,
    super.height,
    super.width,
  }) : super(imageSource: source);

  final Color? color;

  @override
  Widget build(BuildContext context) {
    switch (imageSource) {
      case ImageSources.network:
        return SvgPicture.network(
          image,
          height: height,
          width: width,
          fit: fit,
          // headers: httpHeaders,
          // color: color,
        );
      case ImageSources.asset:
      case ImageSources.system:
        return SvgPicture.asset(
          image,
          height: height,
          width: width,
          fit: fit,
          package: package,
          // color: color,
        );
    }
  }
}

enum ImageSources { network, asset, system }

double? _dimensionsToSquare(double? height, double? width) {
  if (height != null && width == null) {
    return height;
  } else if (height == null && width != null) {
    return width;
  } else if (height != null && width != null) {
    return height;
  }

  return null;
}
