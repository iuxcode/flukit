/// [FluSettingsInterface] allows any auxiliary package to be merged into the app constants
/// class through extensions
abstract class FluSettingsInterface {}

class _FluSettingsImpl extends FluSettingsInterface {}

// ignore: non_constant_identifier_names
final FluSettingsInterface FluSettings = _FluSettingsImpl();

/// Some events like button tap will generate a vibration.
/// You can control the vibration intensity with this.
enum PhysicFeedbackIntensity { light, normal, medium, heavy }
