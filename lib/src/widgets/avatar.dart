import 'package:flutter/material.dart';
import 'outline.dart';

class FluAvatar extends StatelessWidget {
  final double? size, radius;
  final String? label;
  final ImageProvider<Object>? image;
  final BorderRadius? borderRadius;
  final bool useCache;
  final bool outlined;
  final double? strokeWidth, spacing;
  final Color? strokeColor;
  final BoxShadow? boxShadow, strokeShadow;
  final EdgeInsets? margin;

  const FluAvatar({
    Key? key,
    this.image,
    this.label,
    this.size,
    this.radius,
    this.borderRadius,
    this.boxShadow,
    this.strokeWidth,
    this.strokeColor,
    this.spacing,
    this.strokeShadow,
    this.margin,
    this.useCache = false,
    this.outlined = false
  }):
    assert((label != null && label.length >= 1) ||image != null, 'Avatar must have either label or image.'),
    super(key: key);

  factory FluAvatar.asset({
    String? assetName,
    String? label,
    AssetBundle? bundle,
    String? package,
    double? size,
    double? radius,
    BorderRadius? borderRadius,
    double? strokeWidth,
    double? spacing,
    Color? strokeColor,
    BoxShadow? boxShadow,
    BoxShadow? strokeShadow,
    EdgeInsets? margin,
    bool outlined = false
  }) => FluAvatar(
    size: size,
    radius: radius,
    borderRadius: borderRadius,
    outlined: outlined,
    spacing: spacing,
    strokeWidth: strokeWidth,
    strokeColor: strokeColor,
    strokeShadow: strokeShadow,
    boxShadow: boxShadow,
    margin: margin,
    label: label,
    image: assetName != null ? AssetImage(
      assetName,
      bundle: bundle,
      package: package
    ) : null
  );

  factory FluAvatar.network({
    required String url,
    String? label,
    AssetBundle? bundle,
    String? package,
    double? size,
    double? radius,
    BorderRadius? borderRadius,
    double? strokeWidth,
    double? spacing,
    Color? strokeColor,
    BoxShadow? boxShadow,
    BoxShadow? strokeShadow,
    EdgeInsets? margin,
    bool outlined = false,
    double scale = 1.0,
    Map<String, String>? headers
  }) => FluAvatar(
    size: size,
    radius: radius,
    borderRadius: borderRadius,
    outlined: outlined,
    spacing: spacing,
    strokeWidth: strokeWidth,
    strokeColor: strokeColor,
    strokeShadow: strokeShadow,
    boxShadow: boxShadow,
    margin: margin,
    label: label,
    image: NetworkImage(
      url,
      scale: scale,
      headers: headers
    )
  );

  @override
  Widget build(BuildContext context) {
    final Widget avatar = Container(
      height: size ?? 42,
      width: size ?? 42,
      alignment: Alignment.center,
      margin: outlined ? null : margin,
      decoration: BoxDecoration(
        borderRadius: borderRadius ?? BorderRadius.circular(radius ?? 18),
        boxShadow: boxShadow != null ? [boxShadow!] : null,
        image: image != null ? DecorationImage(
          image: image!,
          fit: BoxFit.cover
        ) : null
      ),
      child: image == null && label != null ? Text(
        label!.trim()[0]
      ) : null
    );

    return  outlined ? FluOutline(
      radius: (radius ?? 18) + 2,
      spacing: spacing,
      strokeWidth: strokeWidth,
      strokeBorderRadius: borderRadius,
      strokeColor: strokeColor,
      boxShadow: strokeShadow,
      margin: margin,
      child: avatar,
    ) : avatar;
  }
}