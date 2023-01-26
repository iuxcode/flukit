part of '../flu_utils.dart';

// modify the default getX Snackbar
// - make title || titleText not required
extension ExtensionSnackbar on GetInterface {
  FluSnackbarController showSnakbar(FluSnackBar snackbar) {
    return FluSnackbarController(snackbar)..show();
  }

  FluSnackbarController customSnackbar(
    String? title,
    String message, {
    Color? colorText,
    Duration? duration = const Duration(seconds: 3),

    /// with instantInit = false you can put snackbar on initState
    bool instantInit = true,
    SnackPosition? snackPosition,
    Widget? titleText,
    Widget? messageText,
    Widget? icon,
    bool? shouldIconPulse,
    double? maxWidth,
    EdgeInsets? margin,
    EdgeInsets? padding,
    double? borderRadius,
    Color? borderColor,
    double? borderWidth,
    Color? background,
    Color? leftBarIndicatorColor,
    List<BoxShadow>? boxShadows,
    Gradient? backgroundGradient,
    TextButton? mainButton,
    OnSnackTap? onTap,
    bool? isDismissible,
    bool? showProgressIndicator,
    DismissDirection? dismissDirection,
    AnimationController? progressIndicatorController,
    Color? progressIndicatorbackground,
    Animation<Color>? progressIndicatorValueColor,
    SnackStyle? snackStyle,
    Curve? forwardAnimationCurve,
    Curve? reverseAnimationCurve,
    Duration? animationDuration,
    double? barBlur,
    double? overlayBlur,
    SnackbarStatusCallback? snackbarStatus,
    Color? overlayColor,
    Form? userInputForm,
  }) {
    final ThemeData t = Theme.of(Get.context!);
    final getSnackBar = FluSnackBar(
        snackbarStatus: snackbarStatus,
        titleText: titleText ??
            (title != null
                ? Text(
                    title,
                    style: t.textTheme.bodySmall!.copyWith(
                      color: colorText ?? iconColor ?? Colors.black,
                      fontSize: 16,
                    ),
                  )
                : null),
        messageText: messageText ??
            Text(
              message,
              textAlign: TextAlign.center,
              style: t.textTheme.bodySmall!.copyWith(
                color: colorText ?? iconColor ?? Colors.black,
                fontSize: 14,
              ),
            ),
        snackPosition: snackPosition ?? SnackPosition.TOP,
        borderRadius: borderRadius ?? 20,
        margin: margin ?? const EdgeInsets.symmetric(horizontal: 10),
        padding: padding ?? const EdgeInsets.all(20),
        duration: duration,
        barBlur: barBlur ?? 7.0,
        background: background ?? Colors.grey.withOpacity(0.2),
        icon: icon,
        shouldIconPulse: shouldIconPulse ?? true,
        maxWidth: maxWidth,
        borderColor: borderColor,
        borderWidth: borderWidth,
        leftBarIndicatorColor: leftBarIndicatorColor,
        boxShadows: boxShadows,
        backgroundGradient: backgroundGradient,
        mainButton: mainButton,
        onTap: onTap,
        isDismissible: isDismissible ?? true,
        dismissDirection: dismissDirection,
        showProgressIndicator: showProgressIndicator ?? false,
        progressIndicatorController: progressIndicatorController,
        progressIndicatorbackground: progressIndicatorbackground,
        progressIndicatorValueColor: progressIndicatorValueColor,
        snackStyle: snackStyle ?? SnackStyle.FLOATING,
        forwardAnimationCurve: forwardAnimationCurve ?? Curves.easeOutCirc,
        reverseAnimationCurve: reverseAnimationCurve ?? Curves.easeOutCirc,
        animationDuration: animationDuration ?? const Duration(seconds: 1),
        overlayBlur: overlayBlur ?? 0.0,
        overlayColor: overlayColor ?? Colors.transparent,
        userInputForm: userInputForm);

    final controller = FluSnackbarController(getSnackBar);

    if (instantInit) {
      controller.show();
    } else {
      // routing.isSnackbar = true;
      SchedulerBinding.instance.addPostFrameCallback((_) {
        controller.show();
      });
    }

    return controller;
  }
}
