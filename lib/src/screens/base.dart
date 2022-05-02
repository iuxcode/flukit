import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/flu_utils.dart';

class FluScreen extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget body;
  final SystemUiOverlayStyle? systemUiOverlayStyle;
  final bool extendBody;
  final Widget? bottomNavigationBar;

  const FluScreen({
    Key? key,
    required this.body,
    this.appBar,
    this.systemUiOverlayStyle,
    this.bottomNavigationBar,
    this.extendBody = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => AnnotatedRegion<SystemUiOverlayStyle>(
    value: Flukit.systemOverlayStyle.copyWith(
      statusBarColor: Colors.transparent
    ),
    child: Scaffold(
      extendBody: extendBody,
      appBar: appBar,
      body: body,
      bottomNavigationBar: bottomNavigationBar,
    )
  );
}