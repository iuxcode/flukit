import 'package:get/get.dart';
import '../theme/tweaks.dart';

class FluGetPage extends GetPage {
  FluGetPage({
    required String name,
    required GetPageBuilder page,
    Bindings? binding,
  }) : super(
    name: name,
    page: page,
    binding: binding,
    transitionDuration: FluConsts.defaultPageAnimationDuration,
    curve: FluConsts.defaultPageAnimationCurve,
  );
}