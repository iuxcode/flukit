export 'helpers/ui.dart';
export 'helpers/text.dart';

/// FluInterface allows any auxiliary package to be merged into the "Flu"
/// class through extensions
abstract class FluInterface {}

class _FluImpl extends FluInterface {}

// ignore: non_constant_identifier_names
final FluInterface Flu = _FluImpl();
