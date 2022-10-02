part of '../flu_utils.dart';

extension FlukitUI on FlukitInterface {
  ///return current theme context
  BuildContext get context => Get.context!;

  /// Find and return app controller
  FluAppController get appController => Get.find<FluAppController>();

  /// Find and return app informations
  FluAppInformations get appInfos => appController.infos;

  /// Find and return app constants
  FluSettingsInterface get appSettings => appController.settings;

  /// return the current theme
  FluTheme get fluTheme => appController.fluTheme;

  /// return the current themeData
  ThemeData get themeData => appController.theme;

  /// return the current theme textThemes
  TextTheme get textTheme => themeData.textTheme;

  /// return the current theme color palette
  FluColorPalette get themePalette => fluTheme.colors;

  /// return the current theme brightness
  Brightness get themeBrightness => fluTheme.brightness;

  /// return the current theme systemOverlayStyle
  SystemUiOverlayStyle get systemOverlayStyle => fluTheme.systemStyle;

  /// switch theme
  void changeTheme(FluTheme theme) {
    appController.changeTheme(theme);
  }

  /// return the screen size
  Size get screenSize => Get.size;
  double get screenWidth => screenSize.width;
  double get screenHeight => screenSize.height;

  /// return the status bar height
  double get statusBarHeight => MediaQuery.of(context).padding.top;

  /// used to know if the keyboard is visible or not
  bool isKeyboardHidden(BuildContext context) =>
      !(MediaQuery.of(context).viewInsets.bottom == 0);

  /// Hide the keyboard
  void hideKeyboard() => SystemChannels.textInput.invokeMethod('TextInput.hide');

  /// Show the keyboard
  void showKeyboard() => SystemChannels.textInput.invokeMethod('TextInput.show');

  /// build theme based boxShadow
  BoxShadow boxShadow(
          {double blurRadius = 20,
          double spreadRadius = .5,
          double opacity = .065,
          Offset offset = const Offset(0, 10),
          Color? color}) =>
      BoxShadow(
          blurRadius: blurRadius,
          spreadRadius: spreadRadius,
          offset: offset,
          color: (color ?? themePalette.shadow).withOpacity(opacity));

  /// display theme based or custom snackbar
  void showSnackbar(String message,
      {String? title,
      int duration = 2,
      FluSnackbarType type = FluSnackbarType.primary,
      Color? backgroundColor,
      Color? iconColor,
      Color? textColor,
      double? radius,
      double? iconSize,
      BoxShadow? shadow,
      EdgeInsets? margin,
      Widget? icon,
      SnackPosition position = SnackPosition.TOP,
      SnackStyle style = SnackStyle.FLOATING,
      double opacity = .05,
      double blur = 7}) {
    switch (type) {
      case FluSnackbarType.danger:
        backgroundColor = backgroundColor ?? themePalette.danger;
        textColor = textColor ?? themePalette.danger;
        iconColor = iconColor ?? themePalette.danger;
        break;
      case FluSnackbarType.success:
        backgroundColor = backgroundColor ?? themePalette.success;
        textColor = textColor ?? themePalette.success;
        iconColor = iconColor ?? themePalette.success;
        break;
      case FluSnackbarType.warning:
        backgroundColor = backgroundColor ?? themePalette.warning;
        textColor = textColor ?? themePalette.warning;
        iconColor = iconColor ?? themePalette.warning;
        break;
      case FluSnackbarType.primary:
        backgroundColor = backgroundColor ?? fluTheme.primaryColor;
        textColor = textColor ?? fluTheme.primaryColor;
        iconColor = iconColor ?? fluTheme.primaryColor;
        break;
      case FluSnackbarType.light:
        backgroundColor = backgroundColor ?? themePalette.light;
        textColor = textColor ?? themePalette.light;
        iconColor = iconColor ?? themePalette.light;
        break;
    }

    if (Get.isSnackbarOpen == true) Get.back();
    Get.customSnackbar(title, message,
        margin: margin ?? const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        duration: Duration(seconds: duration),
        snackPosition: position,
        snackStyle: style,
        icon: icon,
        boxShadows: [shadow ?? boxShadow(opacity: .085, offset: const Offset(0, 5))],
        colorText: textColor,
        backgroundColor: (backgroundColor).withOpacity(opacity),
        borderRadius: radius ?? 22,
        shouldIconPulse: true,
        barBlur: blur);
  }

  /// Show error snackbar
  void throwError(String? message) {
    Flukit.showSnackbar(
        (message ?? 'Something went wrong , please retry !').replaceAll('_', ' '),
        type: FluSnackbarType.danger,
        position: SnackPosition.TOP,
        textColor: themePalette.danger,
        opacity: .065,
        blur: 45,
        duration: 10);
  }

  /// Display a modal bottom sheet with countries list to select country.
  void showCountrySelectionBottomSheet({
    String? title,
    desc,
    searchInputHint,
    required BuildContext context,
    required void Function(FluCountryModel) onCountrySelected,
    void Function()? onOpen,
    void Function()? onClose,
  }) async {
    if (onOpen != null) onOpen();

    return await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => FluCountrySelect(
              onCountrySelected,
              title: title,
              desc: desc,
              searchInputHint: searchInputHint,
            )).then((_) {
      if (onClose != null) onClose();
    });
  }

  /// show modal bottom sheet
  void showFluModalBottomSheet({
    required Widget child,
    BuildContext? context,
    EdgeInsets? padding,
    double? radius,
    double? maxChildSize,
  }) {
    context = context ?? Flukit.context;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      backgroundColor: Colors.transparent,
      builder: (context) => FluModalBottomSheet(
        maxChildSize: maxChildSize ?? .85,
        radius: radius,
        padding: padding,
        child: child,
      ),
    );
  }

  /// Get memoji
  String getMemoji({int? id}) {
    int number;

    if (id != null) {
      number = id;
    } else {
      number = Random().nextInt(35);
    }

    return 'assets/memojis/with_bg/avatar${number == 0 ? '' : '-$number'}.png';
  }
}

/// Snackbar types
enum FluSnackbarType {
  primary,
  danger,
  success,
  warning,
  light,
}
