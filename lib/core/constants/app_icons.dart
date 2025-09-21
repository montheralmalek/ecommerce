import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Icons used in the app
abstract final class AppIcons {
  const AppIcons();

  /// Material design icons
  static const AppIcons material = _MaterialIcons();

  /// Cupertino style icons
  static const AppIcons cupertino = _CupertinoIcons();

  /// Get icons based on platform
  factory AppIcons.of(BuildContext context) => switch (Theme.of(
    context,
  ).platform) {
    TargetPlatform.android ||
    TargetPlatform.fuchsia ||
    TargetPlatform.windows => AppIcons.material,
    TargetPlatform.macOS ||
    TargetPlatform.iOS ||
    TargetPlatform.linux => AppIcons.cupertino,
  };

  // Cart icons
  IconData get cart;
  IconData get addToCart;
  IconData get removeFromCart;
}

/// Material Icons
final class _MaterialIcons extends AppIcons {
  const _MaterialIcons();

  @override
  IconData get cart => Icons.shopping_cart_outlined;

  @override
  IconData get addToCart => Icons.add_shopping_cart_outlined;

  @override
  IconData get removeFromCart => Icons.remove_shopping_cart_outlined;
}

/// Cupertino Icons
final class _CupertinoIcons extends AppIcons {
  const _CupertinoIcons();
  @override
  IconData get cart => CupertinoIcons.cart;
  @override
  IconData get addToCart => CupertinoIcons.cart_badge_plus;
  @override
  IconData get removeFromCart => CupertinoIcons.cart_badge_minus;
}
