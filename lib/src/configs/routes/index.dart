import 'package:get/get.dart';

import '../../../flukit.dart';

class FluGetPage extends GetPage {
  FluGetPage({
    required super.name,
    required super.page,
    super.binding,
    Transition? transition,
  }) : super(
          transition: transition ?? Transition.rightToLeft,
          transitionDuration: FluSettings.defaultPageAnimationDuration,
          curve: FluSettings.defaultPageAnimationCurve,
        );
}
