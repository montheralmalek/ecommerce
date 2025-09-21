//=============================================
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:store/core/utils/extensions/context_extensions.dart';

/// Default CupertinoNavigationBarData
CupertinoNavigationBarData defaultCupertinoNavigationBarData(
  BuildContext context,
) => CupertinoNavigationBarData(
  backgroundColor: context.colorScheme.primary.withAlpha(50),
  automaticBackgroundVisibility: false,
  brightness: context.brightness,
  enableBackgroundFilterBlur: false,
);
//=============================================
