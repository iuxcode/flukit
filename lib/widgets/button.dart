import 'package:flutter/material.dart';

/// Create a button
class FluButton extends StatelessWidget {
  const FluButton({required this.child, required this.onPressed, super.key});

  final Widget child;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: child,
    );
  }
}
