import 'package:cached_network_image/cached_network_image.dart';
import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';

class FluAvatar extends StatelessWidget {
  final double size, radius;
  final String? label;
  final String? image;
  final FluImageType source;
  final BorderRadius? borderRadius;
  final bool useCache;
  final bool outlined;
  final double? strokeWidth, spacing;
  final Color? strokeColor, backgroundColor;
  final BoxShadow? boxShadow;
  final EdgeInsets? margin;
  final BoxFit? fit;
  final TextStyle? labelStyle;
  final Widget Function(BuildContext, Object, StackTrace?)? errorBuilder;
  final Widget Function(BuildContext, String)? placeholder;
  final Widget Function(BuildContext, String, DownloadProgress)? progressIndicatorBuilder;

  const FluAvatar({
    Key? key,
    this.image,
    this.label,
    this.source = FluImageType.network,
    this.size = 42,
    this.radius = 18,
    this.borderRadius,
    this.boxShadow,
    this.strokeWidth,
    this.backgroundColor,
    this.strokeColor,
    this.spacing,
    this.margin,
    this.labelStyle,
    this.errorBuilder,
    this.placeholder,
    this.progressIndicatorBuilder,
    this.useCache = false,
    this.outlined = false,
    this.fit = BoxFit.cover
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    final Widget avatar;

    if(label != null && label!.isNotEmpty) {
      avatar = Container(
        height: size,
        width: size,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: backgroundColor ?? Flukit.theme.primaryColor,
          borderRadius: BorderRadius.circular(radius),
          boxShadow: [
            if(boxShadow != null && !outlined) boxShadow!
          ],
        ),
        child: FluText(
          label![0],
          style: FluTextStyle.bodyNeptune,
          customStyle: labelStyle,
        )
      );
    } else if(image != null && image!.isNotEmpty) {
      avatar = FluImage(
        height: size,
        width: size,
        radius: radius,
        image: image!,
        source: source,
        margin: outlined ? null : margin,
        fit: fit,
        boxShadow: outlined ? null : boxShadow,
        errorBuilder: errorBuilder,
        progressIndicatorBuilder: progressIndicatorBuilder,
        placeholder: placeholder,
      );
    } else {
      throw "Avatar must have either label or image";
    }

    return  outlined ? FluOutline(
      radius: radius + 2,
      spacing: spacing,
      thickness: strokeWidth,
      borderRadius: borderRadius,
      color: strokeColor,
      boxShadow: boxShadow,
      margin: margin,
      child: avatar,
    ) : avatar;
  }
}