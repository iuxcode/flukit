import 'package:flukit/widgets/outline.dart';
import 'package:flukit_icons/flukit_icons.dart';
import 'package:flutter/material.dart';

import '../utils/flu_utils.dart';
import 'image.dart';

class FluAvatar extends StatefulWidget {
  const FluAvatar({
    super.key,
    this.image,
    this.label,
    this.icon,
    this.imageSource = ImageSources.network,
    this.defaultAvatarType = FluAvatarTypes.material3D,
    this.circle = false,
    this.size = 62,
    this.cornerRadius = 24,
    this.margin = EdgeInsets.zero,
    this.outlined = false,
    this.outlineColor,
    this.outlineThickness = 2,
    this.outlineGap = 0,
    this.package,
    this.gradientBegin = Alignment.topLeft,
    this.gradientEnd = Alignment.bottomRight,
    this.fillColor,
  });

  /// Set to true, if you want the avatar to be a circle
  final bool circle;

  /// Round all avatar corner with the value defined.
  final double cornerRadius;

  /// Default avatars types
  final FluAvatarTypes defaultAvatarType;

  /// Display icon instead of label or image.
  final FluIcons? icon;

  /// Avatar image like a user profile photo.
  final String? image;

  /// Image source.
  /// Can be from `asset`, `network` or `system`.
  final ImageSources imageSource;

  /// Text to display when there is not an image.
  final String? label;

  /// Empty space to surround the avatar and [child].
  final EdgeInsets margin;

  /// Outline color
  final List<Color>? outlineColor;

  /// Outline thickness
  final double outlineThickness;

  /// set to true to enable outline
  final bool outlined;

  /// Space between outline and the avatar
  final double outlineGap;

  /// The offset at which stop 0.0 of the [outline] gradient is placed
  final Alignment gradientBegin;

  /// The offset at which stop 1.0 of the [outline] gradient is placed.
  final Alignment gradientEnd;

  /// The package argument must be non-null when displaying an image from a package and null otherwise.
  /// See the Assets in packages section for details.
  final String? package;

  /// Avatar size.
  final double size;

  /// BackgroundColor
  final Color? fillColor;

  @override
  State<FluAvatar> createState() => _FluAvatarState();
}

class _FluAvatarState extends State<FluAvatar> {
  late String defaultAvatar;

  @override
  void initState() {
    defaultAvatar = Flu.getAvatar(type: widget.defaultAvatarType);
    super.initState();
  }

  /// Compute avatar [BorderRadius]
  BorderRadius? get _borderRadius =>
      !_isCircle ? BorderRadius.circular(widget.cornerRadius) : null;

  /// Define if the [FluAvatar] shape must be a circle.
  bool get _isCircle =>
      widget.circle || widget.defaultAvatarType == FluAvatarTypes.material3D;

  /// For [FluAvatarTypes.material3D] for example, the avatar need to be a circle.
  BoxShape get _shape => _isCircle ? BoxShape.circle : BoxShape.rectangle;

  /// If an image is not provided, default avatar is displayed.
  String get image => widget.image ?? defaultAvatar;

  @override
  Widget build(BuildContext context) {
    Widget child;

    /// An image is not provided, so we only display the [label] or [icon] if they are provided,
    /// or display provided image or default one.
    if ((widget.label != null || widget.icon != null) && widget.image == null) {
      child = Container(
        height: widget.size,
        width: widget.size,
        clipBehavior: Clip.hardEdge,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: widget.fillColor ?? context.colorScheme.primary,
          shape: _shape,
          borderRadius: _borderRadius,
        ),
        child: widget.label != null
            ? Text(
                Flu.textToAvatarFormat(widget.label ?? 'Flukit').toUpperCase(),
                style: TextStyle(
                    color: context.colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.bold),
              )
            : FluIcon(
                widget.icon!,
                size: 20,
                strokeWidth: 1.8,
                color: context.colorScheme.onPrimaryContainer,
              ),
      );
    } else {
      final mustLoadDefaultAvatar = widget.image != image;

      child = FluImage(
        image,
        imageSource:
            mustLoadDefaultAvatar ? ImageSources.asset : widget.imageSource,
        package: mustLoadDefaultAvatar ? 'flukit' : widget.package,
        circle: _isCircle,
        cornerRadius: widget.cornerRadius,
        height: widget.size,
        square: true,
      );
    }

    if (widget.margin != EdgeInsets.zero || widget.outlined) {
      if (widget.margin != EdgeInsets.zero && !widget.outlined) {
        child = Padding(
          padding: widget.margin,
          child: child,
        );
      }

      if (widget.outlined) {
        child = FluOutline(
          margin: widget.margin,
          thickness: widget.outlineThickness,
          gap: widget.outlineGap,
          colors: widget.outlineColor ?? [context.colorScheme.surfaceVariant],
          circle: _isCircle,
          cornerRadius: widget.cornerRadius + widget.outlineGap,
          child: child,
        );
      }
    }

    return child;
  }
}
