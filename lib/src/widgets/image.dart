import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum FluImageSource { asset, network, system }

/// A widget that displays an image.
/// unlike flutter [Image] widget, you don't have to use different constructor
/// such as [Image.network] to specify the which type of image you want to load.
/// Instead you have to provide the source with the [src] parameter and everything is done.
/// The [image] parameter can be the url, asset path or file path.
/// You can also load svg file by switching [isSvg] to true.
class FluImage extends StatelessWidget {
  const FluImage(
    this.image, {
    super.key,
    this.height,
    this.width,
    this.cornerRadius,
    this.source = FluImageSource.network,
    this.boxShadow,
    this.provider,
    this.frameBuilder,
    this.errorBuilder,
    this.placeholder,
    this.progressIndicatorBuilder,
    this.httpHeaders,
    this.fit,
    this.margin = EdgeInsets.zero,
    this.overlayOpacity = .05,
    this.cache = true,
    this.package,
    this.gradientOverlay = false,
    this.overlayGradientBegin,
    this.overlayGradientEnd,
    this.constraints,
    this.isSvg = false,
    this.color,
  });

  final Widget Function(BuildContext, Widget, int?, bool)? frameBuilder;
  final Widget Function(BuildContext, Object, StackTrace?)? errorBuilder;
  final Widget Function(BuildContext, String)? placeholder;
  final Widget Function(BuildContext, String, DownloadProgress)?
      progressIndicatorBuilder;

  /// If non-null, it define a shadow cast by this image behind the image.
  final BoxShadow? boxShadow;

  /// Set to true, if you want the image to be cached.
  /// Default is `True`
  final bool cache;

  final Color? color;

  /// Can be used to define minimum and maximum sizes of the image.
  final BoxConstraints? constraints;

  /// Round all image corner with the value defined.
  final double? cornerRadius;

  /// How to inscribe the picture into the space allocated during layout.
  /// The default is [BoxFit.contain] if [isSvg] and [BoxFit.cover] else.
  final BoxFit? fit;

  /// Set this to true if you want the overlay to be a gradient.
  final bool gradientOverlay;

  /// Image height
  final double? height;

  /// Can be used to send custom HTTP headers with the image request.
  final Map<String, String>? httpHeaders;

  /// The image to display.
  /// can be an `URL`, `Asset` or `File` path.
  final String image;

  /// Set this to true if the image you want to display is an `SVG`
  final bool isSvg;

  /// Empty space to surround the image.
  final EdgeInsets? margin;

  /// If the overlay is gradient, you can setup the begin and end of this one.
  final AlignmentGeometry? overlayGradientBegin, overlayGradientEnd;

  /// Set the intensity of the overlay. Default is `.05`
  final double overlayOpacity;

  /// The package argument must be non-null when displaying an image from a `package` and null otherwise. See the `Assets in packages` section for details.
  final String? package;

  final ImageProvider<Object>? provider;

  /// The source of the [image]. Can be `asset`, `network` or `system`.
  final FluImageSource source;

  /// Image width
  final double? width;

  @override
  Widget build(BuildContext context) {
    late final Widget img;
    late final BoxFit fit;

    fit = this.fit ?? (isSvg ? BoxFit.contain : BoxFit.cover);

    switch (source) {
      case FluImageSource.asset:
        if (isSvg) {
          img = SvgPicture.asset(
            image,
            height: height,
            width: width,
            fit: fit,
            color: color,
            package: package,
          );
        } else {
          img = Image.asset(
            image,
            height: height,
            width: width,
            fit: fit,
            errorBuilder: errorBuilder,
            frameBuilder: frameBuilder,
            package: package,
          );
        }
        break;
      case FluImageSource.network:
        if (isSvg) {
          img = SvgPicture.network(
            image,
            height: height,
            width: width,
            fit: fit,
            headers: httpHeaders,
            color: color,
          );
        } else {
          img = cache
              ? CachedNetworkImage(
                  imageUrl: image,
                  height: height,
                  width: width,
                  fit: fit,
                  errorWidget: errorBuilder != null
                      ? (context, url, error) =>
                          errorBuilder!(context, url, error)
                      : null,
                  progressIndicatorBuilder: progressIndicatorBuilder,
                  placeholder: placeholder,
                  httpHeaders: httpHeaders,
                )
              : Image.network(
                  image,
                  height: height,
                  width: width,
                  fit: fit,
                  errorBuilder: errorBuilder,
                  frameBuilder: frameBuilder,
                  headers: httpHeaders,
                );
        }
        break;
      case FluImageSource.system:
        if (isSvg) {
          img = SvgPicture.file(
            File(image),
            height: height,
            width: width,
            fit: fit,
            color: color,
          );
        } else {
          img = Image.file(
            File(image),
            height: height,
            width: width,
            fit: fit,
            errorBuilder: errorBuilder,
            frameBuilder: frameBuilder,
          );
        }
        break;
    }

    return Container(
      height: height,
      width: width,
      margin: margin,
      clipBehavior: Clip.hardEdge,
      constraints: constraints,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(cornerRadius ?? 0),
        boxShadow: [if (boxShadow != null) boxShadow!],
      ),
      child: isSvg
          ? img
          : Stack(
              children: [
                img,
                Positioned(
                  top: 0,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: gradientOverlay
                          ? null
                          : Colors.black.withOpacity(overlayOpacity),
                      gradient: gradientOverlay
                          ? LinearGradient(
                              colors: [
                                Colors.transparent,
                                Colors.black.withOpacity(overlayOpacity),
                              ],
                              begin:
                                  overlayGradientBegin ?? Alignment.topCenter,
                              end: overlayGradientEnd ?? Alignment.bottomCenter,
                            )
                          : null,
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
