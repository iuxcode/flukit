import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';

class FluDefaultScreen extends StatelessWidget {
  const FluDefaultScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => FluScreen(
          body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(Flu.appSettings.defaultPaddingSize),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Flu.',
                    style: TextStyle(
                        fontFamily: 'Neptune',
                        package: 'Flu',
                        fontWeight: Flu.appSettings.textBold,
                        fontSize: Flu.appSettings.headlineFs + 25,
                        color: Flu.theme().primary)),
                const SizedBox(height: 5),
                const Text(
                  'Voluptates ut earum voluptatum dolore sed. Perferendis qui enim aut labore eos. Deleniti quasi possimus molestiae eligendi est et porro et voluptatem. Libero et sunt modi aut quas accusamus fuga excepturi.',
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
        ),
      ));
}
