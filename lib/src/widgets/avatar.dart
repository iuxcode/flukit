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
  final String? memoji;
  final bool memojiAsDefault;
  final bool useCache;
  final bool outlined;
  final double? strokewidth, spacing;
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
  final String Function(String value)? placeholderTextFormatter;
  final TextStyle? placeholderTextStyle;

  const FluAvatar({
    Key? key,
    this.image,
    this.text,
    this.source = FluImageSource.network,
    this.size = 42,
    this.radius = 18,
    this.borderRadius,
    this.boxShadow,
    this.strokewidth,
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
    this.memoji,
    this.placeholderTextFormatter,
    this.placeholderTextStyle,
  }) : super(key: key);

  String getText() {
    final placeholderText =
        ((text != null && text!.isNotEmpty && !memojiAsDefault) ? text! : 'flukit')
            .trim();

    if (placeholderTextFormatter != null) {
      return placeholderTextFormatter!(placeholderText);
    } else {
      String text;
      List<String> array = placeholderText.split(' ');

      if (array.length >= 2) {
        text = array[0][0] + array[array.length - 1][0];
      } else {
        text = placeholderText[0];
      }

      return text.toLowerCase();
    }
  }

  @override
  Widget build(BuildContext context) {
    String? img, package;
    FluImageSource? imgSrc;

    Widget avatar;

    if (image != null && image!.isNotEmpty) {
      img = image!;
      imgSrc = source;
    } else if (memojiAsDefault) {
      img = memoji ?? Flukit.getMemoji();
      imgSrc = FluImageSource.asset;
      package = 'flukit';
    }

    if (img != null) {
      avatar = FluImage(
        image: img,
        source: imgSrc,
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
    } else {
      avatar = Container(
        height: size,
        width: size,
        clipBehavior: Clip.hardEdge,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: backgroundGradient == null && backgroundColor != null
              ? backgroundColor
              : Flukit.fluTheme.primaryColor,
          gradient: backgroundGradient,
          borderRadius: BorderRadius.circular(radius),
          boxShadow: [if (boxShadow != null && !outlined) boxShadow!],
        ),
        child: FluText(
          text: getText(),
          stylePreset: FluTextStyle.bodyNeptune,
          style: (labelStyle ?? TextStyle(color: Flukit.themePalette.light))
              .merge(placeholderTextStyle),
        ),
      );
    }

    return outlined
        ? FluOutline(
            radius: radius + 2,
            spacing: spacing,
            thickness: strokewidth,
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
  }
}
