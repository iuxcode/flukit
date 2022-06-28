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
  final FluImageType? source;
  final ImageProvider<Object>? provider;
  final String image;
  final BoxFit? fit;
  final double? height, width, radius;
  final double overlayOpacity;
  final EdgeInsets? margin;
  final BoxShadow? boxShadow;

  const FluImage({
    Key? key,
    this.height,
    this.width,
    this.radius,
    this.source,
    this.boxShadow,
    this.provider,
    required this.image,
    this.fit = BoxFit.cover,
    this.margin = EdgeInsets.zero,
    this.overlayOpacity = .05
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    ImageProvider<Object>? imgProvider;
  
    if(provider != null) {
      imgProvider = provider!;
    } else {
      switch(source) {
        case FluImageType.svg:
          imgProvider = null;
          break;
        case FluImageType.network:
          imgProvider = NetworkImage(image);
          break;
        case FluImageType.file:
          imgProvider = null;
          break;
        case FluImageType.asset:
        default:
          imgProvider = AssetImage(image);
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
        boxShadow: [
          if(boxShadow != null) boxShadow!
        ],
        image: (imgProvider != null) ? DecorationImage(
          image: imgProvider,
          fit: fit,
          onError: (error, stackTrace) {
            ///!!! TODO handle image loading error ...
          }
        ) : null,
      ),
      child: Stack(
        children: [
          if(source == FluImageType.svg) SvgPicture.asset(
            image,
            height: height,
            width: width,
            fit: fit ?? BoxFit.cover,
          ),
          if(source == FluImageType.file) Image.file(
            File(image),
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