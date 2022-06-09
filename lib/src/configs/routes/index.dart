import 'package:get/get.dart';
import '../theme/tweaks.dart';

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
    transitionDuration: FluConsts.defaultPageAnimationDuration,
    curve: FluConsts.defaultPageAnimationCurve,
  );
}