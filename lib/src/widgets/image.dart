import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../flukit.dart';

enum FluImageType {
  svg,
  asset,
  network,
  file
}

class FluImage extends StatelessWidget {
  final FluImageType? source;
  final ImageProvider<Object>? provider;
  final String image;
  final BoxFit? fit;
  final double? height, width, radius;
  final double overlayOpacity;
  final EdgeInsets? margin;
  final BoxShadow? boxShadow;
  final bool cache;
  final Map<String, String>? httpHeaders;
  final Widget Function(BuildContext, Widget, int?, bool)? frameBuilder;
  final Widget Function(BuildContext, Object, StackTrace?)? errorBuilder;
  final Widget Function(BuildContext, String)? placeholder;
  final Widget Function(BuildContext, String, DownloadProgress)? progressIndicatorBuilder;

  const FluImage({
    Key? key,
    this.height,
    this.width,
    this.radius,
    this.source,
    this.boxShadow,
    this.provider,
    this.frameBuilder,
    this.errorBuilder,
    this.placeholder,
    this.progressIndicatorBuilder,
    this.httpHeaders,
    required this.image,
    this.fit = BoxFit.cover,
    this.margin = EdgeInsets.zero,
    this.overlayOpacity = .05,
    this.cache = true
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      margin: margin,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius ?? 0),
        boxShadow: [
          if(boxShadow != null) boxShadow!
        ]
      ),
      child: Stack(
        children: [
          if(source == FluImageType.svg) SvgPicture.asset(
            image,
            height: height,
            width: width,
            fit: fit ?? BoxFit.cover,
          )
          else if(source == FluImageType.network) CachedNetworkImage(
            imageUrl: image,
            height: height,
            width: width,
            fit: fit ?? BoxFit.cover,
            // TODO make caching optional
            // cacheManager: cache ? BaseCacheManager() : null,
            errorWidget: errorBuilder != null ? (context, url, error) => errorBuilder!(context, url, error) : null,
            progressIndicatorBuilder: progressIndicatorBuilder,
            placeholder: placeholder,
            httpHeaders: httpHeaders
          )
          else if(source == FluImageType.file) Image.file(
            File(image),
            height: height,
            width: width,
            fit: fit ?? BoxFit.cover,
            errorBuilder: errorBuilder,
            frameBuilder: frameBuilder,
          )
          else if(source == FluImageType.asset) Image.asset(
            image,
            height: height,
            width: width,
            fit: fit ?? BoxFit.cover,
            errorBuilder: errorBuilder,
            frameBuilder: frameBuilder,
          ),
          Container(
            decoration: BoxDecoration(
              color: Flukit.themePalette.dark.withOpacity(overlayOpacity)
            ),
          ),
        ],
      )
    );
  }
}