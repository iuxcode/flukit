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
    this.src = FluImageSource.network,
    this.boxShadow,
    this.provider,
    this.frameBuilder,
    this.errorBuilder,
    this.placeholder,
    this.progressIndicatorBuilder,
    this.httpHeaders,
    this.fit = BoxFit.cover,
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

  final BoxShadow? boxShadow;
  final bool cache;
  final BoxConstraints? constraints;
  final double? height, width, cornerRadius;
  final BoxFit? fit;
  final bool gradientOverlay;
  final Map<String, String>? httpHeaders;
  final String image;
  final bool isSvg;
  final EdgeInsets? margin;
  final AlignmentGeometry? overlayGradientBegin, overlayGradientEnd;
  final double overlayOpacity;
  final String? package;
  final ImageProvider<Object>? provider;
  final FluImageSource src;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    Widget img;

    switch (src) {
      case FluImageSource.asset:
        if (isSvg) {
          img = SvgPicture.asset(
            image,
            height: height,
            width: width,
            fit: fit ?? BoxFit.cover,
            color: color,
            package: package,
          );
        } else {
          img = Image.asset(
            image,
            height: height,
            width: width,
            fit: fit ?? BoxFit.cover,
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
            fit: fit ?? BoxFit.cover,
            headers: httpHeaders,
            color: color,
          );
        } else {
          img = cache
              ? CachedNetworkImage(
                  imageUrl: image,
                  height: height,
                  width: width,
                  fit: fit ?? BoxFit.cover,
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
                  fit: fit ?? BoxFit.cover,
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
            fit: fit ?? BoxFit.cover,
            color: color,
          );
        } else {
          img = Image.file(
            File(image),
            height: height,
            width: width,
            fit: fit ?? BoxFit.cover,
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
