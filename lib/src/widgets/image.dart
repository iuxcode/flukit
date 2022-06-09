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
  final String? image;
  final BoxFit? fit;
  final double? height, width;
  final double overlayOpacity;
  final EdgeInsets? margin;

  const FluImage({
    Key? key,
    this.height,
    this.width,
    this.type,
    this.provider,
    this.image,
    this.fit,
    this.margin = EdgeInsets.zero,
    this.overlayOpacity = .05
  }): assert(provider != null || image != null), super(key: key);

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
          imgProvider = NetworkImage(image!);
          break;
        case FluImageType.file:
          // imgProvider = FileImage(image)
          // break;
          imgProvider = null;
          break;
        case FluImageType.asset:
        default:
          imgProvider = AssetImage(image!);
          break;
      }
    }

    return Container(
      height: height,
      width: width,
      margin: margin,
      decoration: BoxDecoration(
        image: (imgProvider != null) ? DecorationImage(
          image: imgProvider,
          fit: fit,
          onError: (error, stackTrace) {
            print(error);
          }
        ) : null,
      ),
      child: Stack(
        children: [
          if(type == FluImageType.svg) SvgPicture.asset(
            image!,
            height: height,
            width: width,
            fit: fit ?? BoxFit.cover,
          ),
          if(type == FluImageType.file) Image.file(
            File(image!),
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