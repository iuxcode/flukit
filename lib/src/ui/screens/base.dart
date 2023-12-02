import 'package:flukit/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Todo: Write documentation.
/// Create a layout with styled system overlay
class FluScreen extends StatelessWidget {
  // ignore: public_member_api_docs
  const FluScreen({
    required this.body,
    super.key,
    this.appBar,
    this.overlayStyle,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.extendBody = false,
    this.background,
    this.floatingActionButtonLocation =
        FloatingActionButtonLocation.centerDocked,
    this.drawer,
    this.endDrawer,
    this.scaffoldKey,
    this.drawerScrimColor,
    this.resizeToAvoidBottomInset,
  });

  /// A button displayed floating above [body], in the bottom right corner.
  final Widget? floatingActionButton;

  /// A bottom navigation bar to display at the bottom of the scaffold.
  final Widget? bottomNavigationBar;

  /// The color of the [Material] widget that underlies the entire Scaffold.
  final Color? background;

  /// The color to use for the scrim that
  /// obscures primary content while a drawer is open.
  final Color? drawerScrimColor;

  /// A panel displayed to the side of the [body],
  /// often hidden on mobile devices.
  final Widget? drawer, endDrawer;

  /// If true, and [bottomNavigationBar] or
  /// `persistentFooterButtons` is specified,
  /// then the [body] extends to the bottom of the Scaffold,
  /// instead of only extending to the top of the [bottomNavigationBar] or
  /// the `persistentFooterButtons`.
  final bool extendBody;

  /// Responsible for determining where the [floatingActionButton] should go.
  final FloatingActionButtonLocation floatingActionButtonLocation;

  /// Specifies a preference for the style of the system overlays.
  final SystemUiOverlayStyle? overlayStyle;

  /// If true the [body] and the scaffold's floating widgets should size
  /// themselves to avoid the onscreen keyboard whose height is defined
  /// by the ambient [MediaQuery]'s [MediaQueryData.viewInsets] bottom property.
  final bool? resizeToAvoidBottomInset;

  ///
  final GlobalKey<ScaffoldState>? scaffoldKey;

  /// An app bar to display at the top of the scaffold.
  final PreferredSizeWidget? appBar;

  /// The primary content of the scaffold.
  final Widget body;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ColorProperty('background', background))
      ..add(ColorProperty('drawerScrimColor', drawerScrimColor))
      ..add(DiagnosticsProperty<bool>('extendBody', extendBody))
      ..add(
        DiagnosticsProperty<FloatingActionButtonLocation>(
          'floatingActionButtonLocation',
          floatingActionButtonLocation,
        ),
      )
      ..add(
        DiagnosticsProperty<SystemUiOverlayStyle?>(
          'overlayStyle',
          overlayStyle,
        ),
      )
      ..add(
        DiagnosticsProperty<GlobalKey<ScaffoldState>?>(
          'scaffoldKey',
          scaffoldKey,
        ),
      )
      ..add(
        DiagnosticsProperty<bool?>(
          'resizeToAvoidBottomInset',
          resizeToAvoidBottomInset,
        ),
      )
      ..add(ColorProperty('drawerScrimColor', drawerScrimColor))
      ..add(DiagnosticsProperty<bool>('extendBody', extendBody))
      ..add(
        DiagnosticsProperty<FloatingActionButtonLocation>(
          'floatingActionButtonLocation',
          floatingActionButtonLocation,
        ),
      )
      ..add(
        DiagnosticsProperty<SystemUiOverlayStyle?>(
          'overlayStyle',
          overlayStyle,
        ),
      )
      ..add(
        DiagnosticsProperty<GlobalKey<ScaffoldState>?>(
          'scaffoldKey',
          scaffoldKey,
        ),
      )
      ..add(
        DiagnosticsProperty<bool?>(
          'resizeToAvoidBottomInset',
          resizeToAvoidBottomInset,
        ),
      )
      ..add(ColorProperty('drawerScrimColor', drawerScrimColor))
      ..add(DiagnosticsProperty<bool>('extendBody', extendBody))
      ..add(
        DiagnosticsProperty<FloatingActionButtonLocation>(
          'floatingActionButtonLocation',
          floatingActionButtonLocation,
        ),
      )
      ..add(
        DiagnosticsProperty<SystemUiOverlayStyle?>(
          'overlayStyle',
          overlayStyle,
        ),
      )
      ..add(
        DiagnosticsProperty<GlobalKey<ScaffoldState>?>(
          'scaffoldKey',
          scaffoldKey,
        ),
      )
      ..add(
        DiagnosticsProperty<bool?>(
          'resizeToAvoidBottomInset',
          resizeToAvoidBottomInset,
        ),
      )
      ..add(ColorProperty('drawerScrimColor', drawerScrimColor))
      ..add(DiagnosticsProperty<bool>('extendBody', extendBody))
      ..add(
        DiagnosticsProperty<FloatingActionButtonLocation>(
          'floatingActionButtonLocation',
          floatingActionButtonLocation,
        ),
      )
      ..add(
        DiagnosticsProperty<SystemUiOverlayStyle?>(
          'overlayStyle',
          overlayStyle,
        ),
      )
      ..add(
        DiagnosticsProperty<GlobalKey<ScaffoldState>?>(
          'scaffoldKey',
          scaffoldKey,
        ),
      )
      ..add(
        DiagnosticsProperty<bool?>(
          'resizeToAvoidBottomInset',
          resizeToAvoidBottomInset,
        ),
      );
  }

  @override
  Widget build(BuildContext context) => AnnotatedRegion<SystemUiOverlayStyle>(
        value: context.systemUiOverlayStyle.copyWith(
          statusBarColor: overlayStyle?.statusBarColor,
          statusBarIconBrightness: overlayStyle?.statusBarIconBrightness,
          statusBarBrightness: overlayStyle?.statusBarBrightness,
          systemNavigationBarColor: overlayStyle?.systemNavigationBarColor,
          systemNavigationBarDividerColor:
              overlayStyle?.systemNavigationBarDividerColor,
          systemNavigationBarIconBrightness:
              overlayStyle?.systemNavigationBarIconBrightness,
          systemStatusBarContrastEnforced:
              overlayStyle?.systemStatusBarContrastEnforced,
          systemNavigationBarContrastEnforced:
              overlayStyle?.systemNavigationBarContrastEnforced,
        ),
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: background ?? context.colorScheme.background,
          extendBody: extendBody,
          appBar: appBar,
          body: body,
          bottomNavigationBar: bottomNavigationBar,
          floatingActionButtonLocation: floatingActionButtonLocation,
          floatingActionButton: floatingActionButton,
          drawer: drawer,
          endDrawer: endDrawer,
          drawerScrimColor: drawerScrimColor,
          resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        ),
      );
}
