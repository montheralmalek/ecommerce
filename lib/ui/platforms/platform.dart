import 'dart:io' show Platform;

// import 'package:flutter/cupertino.dart'
//     show
//         CupertinoDynamicColor,
//         CupertinoTheme,
//         CupertinoThemeData,
//         showCupertinoDialog,
//         showCupertinoModalPopup;
import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart'
//     show Theme, ThemeData, Colors, showDialog, showModalBottomSheet;
import 'package:flutter/widgets.dart';
import 'package:store/core/utils/extensions/context_extensions.dart';

bool get isWeb => kIsWeb;
bool get isAndroid => isWeb ? false : Platform.isAndroid;
bool get isIOS => isWeb ? false : Platform.isIOS;

bool get isMobile => isAndroid || isIOS;
bool get isCupertino => isIOS;
bool get isMaterial => isAndroid;

TargetPlatform platform(BuildContext context) => context.platform;
