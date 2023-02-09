import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

/// Display an image
class FluImage extends StatelessWidget {
  const FluImage(
    this.image, {
    this.overlayOpacity = 0.0,
    this.overlayColor,
    this.gradientOverlay = false,
    this.gradientOverlayBegin = Alignment.topCenter,
    this.gradientOverlayEnd = Alignment.bottomCenter,
    super.key,
  });

  final String image;
  final double overlayOpacity;
  final Color? overlayColor;
  final bool gradientOverlay;
  final Alignment gradientOverlayBegin;
  final Alignment gradientOverlayEnd;

  const factory FluImage.asset(String image, {Key? key}) = _FluImageFromAsset;

  @override
  Widget build(BuildContext context) {
    return _Image(
      key: key,
      overlayOpacity: overlayOpacity,
      overlayColor: overlayColor,
      gradientOverlay: gradientOverlay,
      gradientOverlayBegin: gradientOverlayBegin,
      gradientOverlayEnd: gradientOverlayEnd,
      child: CachedNetworkImage(
        imageUrl: image,
      ),
    );
  }
}

class _FluImageFromAsset extends FluImage {
  const _FluImageFromAsset(
    this.name, {
    super.key,
  }) : super(name);

  final String name;

  @override
  Widget build(BuildContext context) {
    return _Image(
      key: key,
      overlayOpacity: overlayOpacity,
      overlayColor: overlayColor,
      gradientOverlay: gradientOverlay,
      gradientOverlayBegin: gradientOverlayBegin,
      gradientOverlayEnd: gradientOverlayEnd,
      child: Image.asset(
        name,
      ),
    );
  }
}

class _Image extends StatelessWidget {
  const _Image(
      {required this.child,
      this.overlayOpacity = 0.0,
      this.overlayColor,
      this.gradientOverlay = false,
      this.gradientOverlayBegin = Alignment.topCenter,
      this.gradientOverlayEnd = Alignment.bottomCenter,
      super.key});

  final Widget child;
  final double overlayOpacity;
  final Color? overlayColor;
  final bool gradientOverlay;
  final Alignment gradientOverlayBegin;
  final Alignment gradientOverlayEnd;

  @override
  Widget build(BuildContext context) {
    if (overlayOpacity > 0) {
      return Stack(children: [
        child,
        Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                color: gradientOverlay
                    ? null
                    : (overlayColor ?? Colors.black)
                        .withOpacity(overlayOpacity),
                gradient: gradientOverlay
                    ? LinearGradient(colors: [
                        Colors.transparent,
                        overlayColor ?? Colors.black,
                      ], begin: gradientOverlayBegin, end: gradientOverlayEnd)
                    : null,
              ),
            ))
      ]);
    }

    return child;
  }
}
