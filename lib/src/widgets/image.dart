import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum FluImageType {
  svg,
  asset,
  network
}

class FluImage extends StatelessWidget {
  final FluImageType? type;
  final ImageProvider<Object>? provider;
  final String? image;
  final BoxFit? fit;
  final double? height, width;

  const FluImage({
    Key? key,
    this.height,
    this.width,
    this.type,
    this.provider,
    this.image,
    this.fit
  }): assert(provider != null || image != null), super(key: key);

  @override
  Widget build(BuildContext context) {
    if(provider != null) {
      return Image(
        image: provider!,
        height: height,
        width: width,
        fit: fit ?? BoxFit.cover,
      );
    } else {
      switch(type) {
        case FluImageType.svg:
          return SvgPicture.asset(
            image!,
            height: height,
            width: width,
            fit: fit ?? BoxFit.cover,
          );
        case FluImageType.network:
          return Image.network(
            image!,
            height: height,
            width: width,
            fit: fit ?? BoxFit.cover,
          );
        case FluImageType.asset:
        default:
          return Image.asset(
            image!,
            height: height,
            width: width,
            fit: fit ?? BoxFit.cover,
          );
      }
    }
  }
}