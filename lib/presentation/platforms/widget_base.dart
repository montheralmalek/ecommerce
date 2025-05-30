import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'platform.dart';

typedef PlatformBuilder<T> =
    T Function(BuildContext context, TargetPlatform platform);
typedef PlatformIndexBuilder<T> =
    T Function(BuildContext context, TargetPlatform platform, int index);

/// A base class for creating platform-specific widgets.
/// This class provides a common interface for creating widgets that can
/// adapt to different platforms (e.g., iOS, Android).
/// It uses the `isMaterial` and `isCupertino` flags to determine which
/// widget to create.
/// The `createMaterialWidget` and `createCupertinoWidget` methods
/// should be overridden to provide the specific implementation for
/// each platform.
/// The `build` method will call the appropriate method based on the
/// current platform.
abstract class PlatformWidgetBase<I extends Widget, A extends Widget>
    extends StatelessWidget {
  const PlatformWidgetBase({super.key});

  @override
  Widget build(BuildContext context) {
    if (isMaterial) {
      return createMaterialWidget(context);
    } else if (isCupertino) {
      return createCupertinoWidget(context);
    }

    return throw UnsupportedError(
      'This platform is not supported: $defaultTargetPlatform',
    );
  }

  I createCupertinoWidget(BuildContext context);

  A createMaterialWidget(BuildContext context);
}
