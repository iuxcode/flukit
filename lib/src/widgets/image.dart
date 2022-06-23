import 'dart:io';

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
  final FluImageType? type;
  final ImageProvider<Object>? provider;
  final String? url;
  final BoxFit? fit;
  final double? height, width, radius;
  final double overlayOpacity;
  final EdgeInsets? margin;

  const FluImage({
    Key? key,
    this.height,
    this.width,
    this.radius,
    this.type,
    this.provider,
    this.url,
    this.fit = BoxFit.cover,
    this.margin = EdgeInsets.zero,
    this.overlayOpacity = .05
  }): assert(provider != null || url != null), super(key: key);

  @override
  Widget build(BuildContext context) {
    ImageProvider<Object>? imgProvider;
  
    if(provider != null) {
      imgProvider = provider!;
    } else {
      switch(type) {
        case FluImageType.svg:
          imgProvider = null;
          break;
        case FluImageType.network:
          imgProvider = NetworkImage(url!);
          break;
        case FluImageType.file:
          // imgProvider = FileImage(image)
          // break;
          imgProvider = null;
          break;
        case FluImageType.asset:
        default:
          imgProvider = AssetImage(url!);
          break;
      }
    }

    return Container(
      height: height,
      width: width,
      margin: margin,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius ?? 0),
        image: (imgProvider != null) ? DecorationImage(
          image: imgProvider,
          fit: fit,
          onError: (error, stackTrace) {
            /// TODO handle image loading error.
          }
        ) : null,
      ),
      child: Stack(
        children: [
          if(type == FluImageType.svg) SvgPicture.asset(
            url!,
            height: height,
            width: width,
            fit: fit ?? BoxFit.cover,
          ),
          if(type == FluImageType.file) Image.file(
            File(url!),
            height: height ?? double.infinity,
            width: width ?? double.infinity,
            fit: fit ?? BoxFit.cover,
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