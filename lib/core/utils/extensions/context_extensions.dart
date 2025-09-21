import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:store/core/constants/app_icons.dart';

extension ContextExtensions on BuildContext {
  /// Returns the [ThemeData] of the current context.
  ThemeData get theme => Theme.of(this);

  /// Returns the [TextTheme] of the current context.
  TextTheme get textTheme => theme.textTheme;

  /// Returns the [ColorScheme] of the current context.
  ColorScheme get colorScheme => theme.colorScheme;

  /// Returns the [Brightness] of the current context.
  Brightness get brightness => theme.brightness;

  /// Returns the [MediaQueryData] of the current context.
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  /// Returns the [Size] of the current context.
  Size get size => mediaQuery.size;

  /// Rturns the [width] of the current context.
  double get width => size.width;

  /// Returns the [height] of the current context.
  double get height => size.height;

  /// Returns the [Orientation] of the current context.
  Orientation get orientation => mediaQuery.orientation;

  /// Returns the [DeviceOrientation] of the current context.
  Orientation get deviceOrientation => mediaQuery.orientation;

  /// Returns the [Directionality] of the current context.
  TextDirection get textDirection => Directionality.of(this);

  /// Returns the [Locale] of the current context.
  Locale get locale => Localizations.localeOf(this);

  /// Returns the [NavigatorState] of the current context.
  NavigatorState get navigator => Navigator.of(this);

  /// Returns the [ScaffoldMessengerState] of the current context.
  ScaffoldMessengerState get scaffoldMessenger => ScaffoldMessenger.of(this);

  /// Returns the [TargetPlatform] of the current context.
  TargetPlatform get platform => Theme.of(this).platform;

  /// Returns the [FocusScopeNode] of the current context.
  FocusScopeNode get focusScope => FocusScope.of(this);

  /// Returns true if the device is in portrait mode.
  bool get isPortrait => orientation == Orientation.portrait;

  /// Returns true if the device is in landscape mode.
  bool get isLandscape => orientation == Orientation.landscape;

  /// Returns true if the device is mobile.
  bool get isMobile => size.width < 600;

  /// Return true if the device is tablet.
  bool get isTablet => size.width >= 600 && size.width < 1200;

  /// Returns true if the text direction is rtl.
  bool get isRTL => textDirection == TextDirection.rtl;

  /// Returns true if the text direction is ltr.
  bool get isLTR => textDirection == TextDirection.ltr;

  /// Sets theme mode.
  void setThemeMode(ThemeMode mode) {
    Theme.of(this).copyWith(
      brightness: mode == ThemeMode.dark ? Brightness.dark : Brightness.light,
    );
  }

  bool get isDarkMode =>
      MediaQuery.of(this).platformBrightness == Brightness.dark;
  bool get isLightMode =>
      MediaQuery.of(this).platformBrightness == Brightness.light;

  /// Returns AppIcons based on platform
  AppIcons get appIcons => AppIcons.of(this);
}

/// Navigate extension methods for [BuildContext].
extension GoRouterNavigationExtensions<T> on BuildContext {
  /// Navigate to a named route.
  /// Navigate to a named route.
  ///
  /// [pathParameters] are the parameters to be passed in the path of the route.
  /// [queryParameters] are the parameters to be passed as query strings.
  /// [extra] is additional data to be passed to the route.
  /// [T] represents the expected return type of the navigation result.
  Future<R?> toNamed<R extends Object?>(
    String name, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) => GoRouter.of(this).pushNamed<R>(
    name,
    pathParameters: pathParameters,
    queryParameters: queryParameters,
    extra: extra,
  );
}
