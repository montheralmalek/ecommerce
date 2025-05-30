import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// This class is used to create a page based on the platform.
/// It returns a [Page] object that is either a [CupertinoPage] or a
/// [MaterialPage] depending on the platform.
class PlatformPage extends Page {
  const PlatformPage({required this.child});

  final Widget child;

  @override
  Route createRoute(BuildContext context) {
    return Platform.isIOS
        ? CupertinoPageRoute(builder: (context) => child, settings: this)
        : MaterialPageRoute(builder: (context) => child, settings: this);
  }
}
