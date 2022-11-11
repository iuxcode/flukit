import 'package:flukit/flukit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class FluAvatar extends StatelessWidget {
  const FluAvatar({
    Key? key,
    this.image,
    this.text,
    this.imageSource = FluImageSource.network,
    this.size = 42,
    this.cornerRadius = 18,
    this.borderRadius,
    this.boxShadow,
    this.strokewidth,
    this.background,
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

  final Widget Function(BuildContext, Object, StackTrace?)? errorBuilder;
  final Widget Function(BuildContext, String)? placeholder;
  final Widget Function(BuildContext, String, DownloadProgress)?
      progressIndicatorBuilder;

  final String Function(String value)? placeholderTextFormatter;
  final Color? strokeColor, background;
  final Gradient? backgroundGradient;
  final BorderRadius? borderRadius;
  final BoxShadow? boxShadow;
  final double cornerRadius;
  final BoxFit? fit;
  final String? image;
  final FluImageSource imageSource;
  final TextStyle? labelStyle;
  final EdgeInsets? margin;
  final String? memoji;
  final bool memojiAsDefault;
  final bool outlined;
  final String? package;
  final TextStyle? placeholderTextStyle;
  final double size;
  final double? strokewidth, spacing;
  final String? text;
  final bool useCache;

  @override
  Widget build(BuildContext context) {
    String? img, package;
    Widget avatar;

    if (image != null && image!.isNotEmpty) {
      img = image!;
    } else if (memojiAsDefault) {
      img = memoji ?? Flu.getMemoji();
      package = 'flukit';
    }

    if (img != null) {
      avatar = FluImage(
        img,
        src: memojiAsDefault ? FluImageSource.asset : imageSource,
        height: size,
        width: size,
        cornerRadius: cornerRadius,
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
          color: backgroundGradient == null && background != null
              ? background
              : Flu.theme().primary,
          gradient: backgroundGradient,
          borderRadius: BorderRadius.circular(cornerRadius),
          boxShadow: [if (boxShadow != null && !outlined) boxShadow!],
        ),
        child: FluText(
          text: Flu.textToAvatarFormat(
              ((text != null && text!.isNotEmpty && !memojiAsDefault)
                      ? text!
                      : 'Flu')
                  .trim()),
          stylePreset: FluTextStyle.bodyNeptune,
          style: (labelStyle ?? TextStyle(color: Flu.theme().light))
              .merge(placeholderTextStyle),
        ),
      );
    }

    return outlined
        ? FluOutline(
            radius: cornerRadius + 2,
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
