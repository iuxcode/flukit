import 'package:flutter/material.dart';

import 'base.dart';

class FluDefaultScreen extends StatelessWidget {
  const FluDefaultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FluScreen(
      body: SafeArea(
          child: Column(
        children: const [Text('Flukit')],
      )),
    );
  }
}
