part of '../flu_utils.dart';

extension FlukitUI on FlukitInterface {
  ///return current theme context
  BuildContext get context => Get.context!;

  /// Find and return app controller
  FluAppController get appController => Get.find<FluAppController>();

  /// return the current theme
  FluTheme get theme => appController.theme;

  /// return the current themeData
  ThemeData get themeData => Theme.of(context);

  /// return the current theme systemOverlayStyle
  SystemUiOverlayStyle get systemOverlayStyle => theme.systemStyle;

  /// return the current theme textThemes
  TextTheme get textTheme => themeData.textTheme;

  /// return the current theme color palette
  FluColorPalette get themePalette => theme.palette;

  /// return the current theme brightness
  Brightness get themeBrightness => theme.brightness;

  /// return the screen size
  Size get screenSize => Get.size;

  /// return the status bar height
  double get statusBarHeight => MediaQuery.of(context).padding.top;

  /// used to know if the keyboard is visible or not
  bool isKeyboardHidden(BuildContext context) => !(MediaQuery.of(context).viewInsets.bottom == 0);

  /// switch theme || take the theme as parameter
  /// TODO implement function to switch theme.
  void changeTheme(FluTheme theme) {}

  /// build theme based boxShadow
  BoxShadow boxShadow({
    double blurRadius = 20,
    double spreadRadius = .5,
    double opacity = .065,
    Offset offset = const Offset(0,10),
    Color? color
  }) => BoxShadow(
    blurRadius: blurRadius,
    spreadRadius: spreadRadius,
    offset: offset,
    color: (color ?? theme.palette.shadow).withOpacity(opacity)
  );

  /// display theme based or custom snackbar
  void showSnackbar(
    String message,
    {
      String? title,
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
      double blur = 7
    }
  ) {
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
        backgroundColor = backgroundColor ?? themePalette.primary;
        textColor = textColor ?? themePalette.primary;
        iconColor = iconColor ?? themePalette.primary;
        break;
      case FluSnackbarType.light:
        backgroundColor = backgroundColor ?? themePalette.light;
        textColor = textColor ?? themePalette.light;
        iconColor = iconColor ?? themePalette.light;
        break;
    }


    if(Get.isSnackbarOpen == true) Get.back();
    Get.customSnackbar(
      title,
      message,
      margin: margin ?? const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      duration: Duration(seconds: duration),
      snackPosition: position,
      snackStyle: style,
      icon: icon,
      boxShadows: [ shadow ?? boxShadow(opacity: .085, offset: const Offset(0, 5))],
      colorText: textColor,
      backgroundColor: (backgroundColor).withOpacity(opacity),
      borderRadius: radius ?? 22,
      shouldIconPulse: true,
      barBlur: blur
    );
  }

  /// Show error snackbar
  void throwError(String? message) {
    Flukit.showSnackbar(
      (message ?? 'Something went wrong , please retry !').replaceAll('_', ' ').capitalizeFirst!,
      type: FluSnackbarType.danger,
      position: SnackPosition.TOP,
      textColor: Flukit.theme.palette.danger,
      opacity: .065,
      blur: 15,
      duration: 5
    );
  }

  /// Display a modal with countries list to select country.
  void showCountrySelectionBottomSheet({
    required BuildContext context,
    required void Function(FluCountryModel) onCountrySelected,
    void Function()? onOpen,
    void Function()? onClose,
  }) async {
    if(onOpen != null) onOpen();

    return await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => FluCountrySelect(onCountrySelected)
    ).then((_) {
      if(onClose != null) onClose();
    });
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