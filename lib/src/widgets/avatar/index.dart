import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';

/// Add an avatar easily
/// TODO: Add these badges | Online | writing | Count | Notifications
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
    this.textStyle,
    this.useCache = true,
    this.outlined = false,
    this.package,
    this.memojiAsDefault = false,
    this.memoji,
    this.circle = false,
  }) : super(key: key);

  /// The avatar's background fill color.
  final Color? background;

  /// The avatar's background fill gradient.
  final Gradient? backgroundGradient;

  /// If non-null, the corners of this avatar are rounded by this [BorderRadius].
  final BorderRadius? borderRadius;

  /// If non-null, it define a shadow cast by this avatar behind the avatar.
  final BoxShadow? boxShadow;

  /// Round all avatar corner with the value defined.
  final double cornerRadius;

  /// The avatar image.
  final String? image;

  /// The source of the [image]. Can be `asset`, `network` or `system`.
  final FluImageSource imageSource;

  /// Empty space to surround the image.
  final EdgeInsets? margin;

  /// Define the memoji to display.
  final String? memoji;

  /// If it's set to true, a memoji will be displayed instead of the [text]
  final bool memojiAsDefault;

  /// Set to true if you want to outline the avatar
  /// It generates a border around the avatar, this is usually used to represent that the user is doing an action or in many cases has a `History`.
  final bool outlined;

  /// The package argument must be non-null when displaying an image from a `package` and null otherwise. See the `Assets in packages` section for details.
  final String? package;

  /// Avatar size.
  final double size;

  /// Define the space between outline and avatar.
  final double? spacing;

  /// If the avatar is [outlined], you can use this property to change the outline color.
  final Color? strokeColor;

  /// if the avatar is [outlined], you can use this to define the outline stroke width.
  final double? strokewidth;

  /// If the user has a short name, you can use this to display it. (ie: the user doesn't have an avatar image).
  /// if this is a very long text or has several spaces, the text to be displayed will be automatically generated so that it can be seen correctly.
  final String? text;

  /// Can be used to define a style for the avatar text.
  final TextStyle? textStyle;

  /// Set to true, if you want the image to be cached.
  /// Default is `True`
  final bool useCache;

  /// Set to true, if you want the avatar to be a circle
  final bool circle;

  @override
  Widget build(BuildContext context) {
    String? img, package;
    Widget avatar;
    double _cornerRadius = circle ? 999 : cornerRadius;

    if (image != null && image!.isNotEmpty) {
      img = image!;
    } else if (memojiAsDefault) {
      img = memoji ?? Flu.getMemoji();
      package = 'flukit';
    }

    if (img != null) {
      avatar = FluImage(
        img,
        source: memojiAsDefault && image == null
            ? FluImageSource.asset
            : imageSource,
        height: size,
        width: size,
        cornerRadius: _cornerRadius,
        fit: BoxFit.cover,
        boxShadow: outlined ? null : boxShadow,
        package: package,
        cache: useCache,
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
              : Flu.theme.primary,
          gradient: backgroundGradient,
          borderRadius: BorderRadius.circular(_cornerRadius),
          boxShadow: [if (boxShadow != null && !outlined) boxShadow!],
        ),
        child: FluText(
          text: Flu.textToAvatarFormat(
              ((text != null && text!.isNotEmpty && !memojiAsDefault)
                      ? text!
                      : 'Flu')
                  .trim()),
          stylePreset: FluTextStyle.bodyNeptune,
          style: textStyle ?? TextStyle(color: Flu.theme.light),
        ),
      );
    }

    return outlined
        ? FluOutline(
            radius: _cornerRadius + 2,
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
