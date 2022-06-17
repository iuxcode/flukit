import 'package:get/get.dart';
import '../../../flukit.dart';

class FluGetPage extends GetPage {
  FluGetPage({
    required String name,
    required GetPageBuilder page,
    Transition? transition,
    Bindings? binding,
  }) : super(
    name: name,
    page: page,
    binding: binding,
    transition: transition ?? Transition.rightToLeft,
    transitionDuration: Flukit.appConsts.defaultPageAnimationDuration,
    curve: Flukit.appConsts.defaultPageAnimationCurve,
  );
}