import 'dart:math' as math;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';

class FluAvatar extends StatelessWidget {
  final String? image;
  final FluImageSource source;
  final String? text;
  final double size;
  final double radius;
  final BorderRadius? borderRadius;
  final bool memojiAsDefault;
  final bool useCache;
  final bool outlined;
  final double? strokeWidth, spacing;
  final Color? strokeColor, backgroundColor;
  final Gradient? backgroundGradient;
  final BoxShadow? boxShadow;
  final EdgeInsets? margin;
  final String? package;
  final BoxFit? fit;
  final TextStyle? labelStyle;
  final Widget Function(BuildContext, Object, StackTrace?)? errorBuilder;
  final Widget Function(BuildContext, String)? placeholder;
  final Widget Function(BuildContext, String, DownloadProgress)?
      progressIndicatorBuilder;

  const FluAvatar({
    Key? key,
    this.image,
    this.text,
    this.source = FluImageSource.network,
    this.size = 42,
    this.radius = 18,
    this.borderRadius,
    this.boxShadow,
    this.strokeWidth,
    this.backgroundColor,
    this.backgroundGradient,
    this.strokeColor,
    this.spacing,
    this.margin,
    this.labelStyle,
    this.errorBuilder,
    this.placeholder,
    this.progressIndicatorBuilder,
    this.useCache = false,
    this.outlined = false,
    this.fit = BoxFit.cover,
    this.package,
    this.memojiAsDefault = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => outlined
      ? FluOutline(
          radius: radius + 2,
          spacing: spacing,
          thickness: strokeWidth,
          borderRadius: borderRadius,
          color: strokeColor,
          boxShadow: boxShadow,
          margin: margin,
          child: avatar,
        )
      : Container(
          margin: margin,
          child: avatar,
        );

  Widget get avatar {
    if (image != null && image!.isNotEmpty) {
      return buildImage(image!, source);
    } else if (text != null && text!.isNotEmpty && !memojiAsDefault) {
      return defaultt;
    } else {
      return memoji;
    }
  }

  Widget get defaultt => Container(
        height: size,
        width: size,
        clipBehavior: Clip.hardEdge,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: backgroundGradient == null && backgroundColor != null
              ? backgroundColor
              : Flukit.theme.primaryColor,
          gradient: backgroundGradient,
          borderRadius: BorderRadius.circular(radius),
          boxShadow: [if (boxShadow != null && !outlined) boxShadow!],
        ),
        child: FluText(
          text![0],
          style: FluTextStyle.bodyNeptune,
          customStyle:
              labelStyle ?? TextStyle(color: Flukit.themePalette.light),
        ),
      );

  Widget get memoji {
    int random = math.Random().nextInt(35);

    return buildImage(
      'assets/memojis/with_bg/avatar-${random == 0 ? '' : random.toString()}',
      FluImageSource.asset,
      package: 'flukit',
    );
  }

  Widget buildImage(String img, FluImageSource src, {String? package}) =>
      FluImage(
        image: img,
        source: src,
        height: size,
        width: size,
        radius: radius,
        fit: fit,
        boxShadow: outlined ? null : boxShadow,
        errorBuilder: errorBuilder,
        progressIndicatorBuilder: progressIndicatorBuilder,
        placeholder: placeholder,
        package: package,
      );
}
