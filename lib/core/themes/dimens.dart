import 'package:flutter/material.dart';
import 'package:store/core/utils/extensions/context_extensions.dart';

abstract final class Dimens {
  const Dimens();

  /// General horizontal padding used to separate UI items
  static const paddingHorizontal = 20.0;

  /// General vertical padding used to separate UI items
  static const paddingVertical = 24.0;

  static const p4 = 4.0;
  static const p8 = 8.0;
  static const p12 = 12.0;
  static const p16 = 16.0;
  static const p20 = 20.0;
  static const p24 = 24.0;
  static const p32 = 32.0;

  /// Horizontal padding for screen edges
  double get paddingScreenHorizontal;

  /// Vertical padding for screen edges
  double get paddingScreenVertical;

  double get profilePictureSize;

  /// Horizontal symmetric padding for screen edges
  EdgeInsets get edgeInsetsScreenHorizontal =>
      EdgeInsets.symmetric(horizontal: paddingScreenHorizontal);

  /// Symmetric padding for screen edges
  EdgeInsets get edgeInsetsScreenSymmetric => EdgeInsets.symmetric(
    horizontal: paddingScreenHorizontal,
    vertical: paddingScreenVertical,
  );

  /// Small padding value
  double get paddingSmall;

  /// Medium padding value
  double get paddingMedium;

  /// Large padding value
  double get paddingLarge;

  static const Dimens desktop = _DimensDesktop();
  static const Dimens mobile = _DimensMobile();

  /// Get dimensions definition based on screen size
  factory Dimens.of(BuildContext context) => switch (context.platform) {
    TargetPlatform.android ||
    TargetPlatform.iOS ||
    TargetPlatform.fuchsia when context.isMobile => Dimens.mobile,
    TargetPlatform.macOS ||
    TargetPlatform.windows ||
    TargetPlatform.linux when !context.isMobile => Dimens.desktop,
    _ => Dimens.mobile, // Default to mobile if platform is unknown
  };
}

/// Mobile dimensions
final class _DimensMobile extends Dimens {
  @override
  final double paddingScreenHorizontal = Dimens.paddingHorizontal;

  @override
  final double paddingScreenVertical = Dimens.paddingVertical;

  @override
  final double profilePictureSize = 64.0;

  @override
  final double paddingLarge = Dimens.p32;

  @override
  final double paddingMedium = Dimens.p16;

  @override
  final double paddingSmall = Dimens.p8;

  const _DimensMobile();
}

/// Desktop/Web dimensions
final class _DimensDesktop extends Dimens {
  @override
  final double paddingScreenHorizontal = 100.0;

  @override
  final double paddingScreenVertical = 64.0;

  @override
  final double profilePictureSize = 128.0;

  @override
  final double paddingLarge = 32.0;

  @override
  final double paddingMedium = 16.0;

  @override
  final double paddingSmall = 8.0;

  const _DimensDesktop();
}
