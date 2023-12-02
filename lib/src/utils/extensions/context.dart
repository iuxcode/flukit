import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

extension ContextExt on BuildContext {
  /// The same of [MediaQuery.of(context).size]
  Size get mediaQuerySize => MediaQuery.of(this).size;

  /// The same of [MediaQuery.of(context).size.height]
  /// Note: updates when you resize your screen (like on a browser or
  /// desktop window)
  double get height => mediaQuerySize.height;

  /// The same of [MediaQuery.of(context).size.width]
  /// Note: updates when you resize your screen (like on a browser or
  /// desktop window)
  double get width => mediaQuerySize.width;

  /// Gives you the power to get a portion of the height.
  /// Useful for responsive applications.
  ///
  /// [dividedBy] is for when you want to have a portion of the value you
  /// would get like for example: if you want a value that represents a third
  /// of the screen you can set it to 3, and you will get a third of the height
  ///
  /// [reducedBy] is a percentage value of how much of the height you want
  /// if you for example want 46% of the height, then you reduce it by 56%.
  double heightTransformer({double dividedBy = 1, double reducedBy = 0.0}) =>
      (mediaQuerySize.height - ((mediaQuerySize.height / 100) * reducedBy)) /
      dividedBy;

  /// Gives you the power to get a portion of the width.
  /// Useful for responsive applications.
  ///
  /// [dividedBy] is for when you want to have a portion of the value you
  /// would get like for example: if you want a value that represents a third
  /// of the screen you can set it to 3, and you will get a third of the width
  ///
  /// [reducedBy] is a percentage value of how much of the width you want
  /// if you for example want 46% of the width, then you reduce it by 56%.
  double widthTransformer({double dividedBy = 1, double reducedBy = 0.0}) =>
      (mediaQuerySize.width - ((mediaQuerySize.width / 100) * reducedBy)) /
      dividedBy;

  /// Divide the height proportionally by the given value
  double ratio({
    double dividedBy = 1,
    double reducedByW = 0.0,
    double reducedByH = 0.0,
  }) =>
      heightTransformer(dividedBy: dividedBy, reducedBy: reducedByH) /
      widthTransformer(dividedBy: dividedBy, reducedBy: reducedByW);

  /// similar to [MediaQuery.of(context).theme]
  ThemeData get theme => Theme.of(this);

  /// similar to [MediaQuery.of(context).theme.colorScheme]
  ColorScheme get colorScheme => theme.colorScheme;

  /// Check if dark mode theme is enabled
  bool get isDarkMode => theme.brightness == Brightness.dark;

  /// give access to Theme.of(context).iconTheme.color
  Color? get iconColor => theme.iconTheme.color;

  /// SystemUIOverlayStyle
  SystemUiOverlayStyle get systemUiOverlayStyle => SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: colorScheme.brightness == Brightness.light
            ? Brightness.dark
            : Brightness.light,
        systemNavigationBarColor: colorScheme.background,
        systemNavigationBarIconBrightness: colorScheme.brightness,
      );

  /// similar to [MediaQuery.of(context).padding]
  TextTheme get textTheme => Theme.of(this).textTheme;

  /// similar to [MediaQuery.of(context).padding]
  EdgeInsets get mediaQueryPadding => MediaQuery.of(this).padding;

  /// similar to [MediaQuery.of(context).padding]
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  /// similar to [MediaQuery.of(context).viewPadding]
  EdgeInsets get mediaQueryViewPadding => MediaQuery.of(this).viewPadding;

  /// similar to [MediaQuery.of(context).viewInsets]
  EdgeInsets get mediaQueryViewInsets => MediaQuery.of(this).viewInsets;

  /// similar to [MediaQuery.of(context).orientation]
  Orientation get orientation => MediaQuery.of(this).orientation;

  /// return [MediaQuery.of(context).padding.top]
  double get statusBarHeight => MediaQuery.of(this).padding.top;

  /// Detect if the keyboard is visible or not
  /// true if [MediaQuery.of(context).viewInsets.bottom] == 0
  bool get isKeyboardHidden => MediaQuery.of(this).viewInsets.bottom == 0;

  /// similar to [MediaQuery.of(context).alwaysUse24HourFormat]
  bool get alwaysUse24HourFormat => MediaQuery.of(this).alwaysUse24HourFormat;

  /// check if device is on landscape mode
  bool get isLandscape => orientation == Orientation.landscape;

  /// check if device is on portrait mode
  bool get isPortrait => orientation == Orientation.portrait;

  /// similar to [MediaQuery.of(this).devicePixelRatio]
  double get devicePixelRatio => MediaQuery.of(this).devicePixelRatio;

  /// similar to [MediaQuery.of(this).textScaleFactor]
  TextScaler get textScaler => MediaQuery.of(this).textScaler;

  /// get the shortestSide from screen
  double get mediaQueryShortestSide => mediaQuerySize.shortestSide;

  /// True if width be larger than 800
  bool get showNavbar => width > 800;

  /// True if the width is smaller than 600p
  bool get isPhoneOrLess => width <= 600;

  /// True if the width is higher than 600p
  bool get isPhoneOrWider => width >= 600;

  /// True if the shortestSide is smaller than 600p
  bool get isPhone => mediaQueryShortestSide < 600;

  /// True if the width is smaller than 600p
  bool get isSmallTabletOrLess => width <= 600;

  /// True if the width is higher than 600p
  bool get isSmallTabletOrWider => width >= 600;

  /// True if the shortestSide is largest than 600p
  bool get isSmallTablet => mediaQueryShortestSide >= 600;

  /// True if the shortestSide is largest than 720p
  bool get isLargeTablet => mediaQueryShortestSide >= 720;

  /// True if the width is smaller than 720p
  bool get isLargeTabletOrLess => width <= 720;

  /// True if the width is higher than 720p
  bool get isLargeTabletOrWider => width >= 720;

  /// True if the current device is Tablet
  bool get isTablet => isSmallTablet || isLargeTablet;

  /// True if the width is smaller than 1200p
  bool get isDesktopOrLess => width <= 1200;

  /// True if the width is higher than 1200p
  bool get isDesktopOrWider => width >= 1200;

  /// same as [isDesktopOrLess]
  bool get isDesktop => isDesktopOrLess;
}
