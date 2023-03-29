import 'package:flutter/material.dart';

class FlukitDefaultScreen extends StatelessWidget {
  const FlukitDefaultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Text('Flukit',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 25)),
          const Text('Est consectetur dolor ut eaque quia nihil natus.')
        ],
      )),
    );
  }
}
