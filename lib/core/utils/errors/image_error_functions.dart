import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:skeletonizer/skeletonizer.dart';

final _log = Logger('ImageErrorListener');

/// Listener for image loading errors.
void imageErrorListener(Object error) {
  _log.warning('Failed to load image', error);
}

/// Widget to display when an image fails to load.
Widget imageErrorWidget(context, url, error) {
  _log.warning('Image error for URL: $url', error);
  return Container(
    alignment: Alignment.center,
    constraints: const BoxConstraints.expand(),

    // decoration: BoxDecoration(borderRadius: BorderRadius.circular(radius ?? 0)),
    child: Skeleton.ignore(child: const Icon(Icons.error_outline_rounded)),
  );
}
