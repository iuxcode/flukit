import 'package:flukit/flukit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Flu404 extends StatelessWidget {
  const Flu404(this.exceptedRouteName, {super.key});

  final String exceptedRouteName;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('exceptedRouteName', exceptedRouteName));
  }

  @override
  Widget build(BuildContext context) => FluScreen(
        background: Colors.pink,
        overlayStyle: context.systemUiOverlayStyle.copyWith(
          statusBarColor: Colors.transparent,
          systemNavigationBarColor: Colors.pink,
        ),
        body: SafeArea(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  '404',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: M3FontSizes.displayLarge,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(text: 'The route'),
                      TextSpan(
                        text: ' $exceptedRouteName ',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const TextSpan(text: 'was not found!'),
                    ],
                  ),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: M3FontSizes.bodyMedium,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
