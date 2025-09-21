import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:store/core/utils/errors/image_error_functions.dart';
import 'package:store/core/utils/extensions/context_extensions.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  const CustomCachedNetworkImage({
    super.key,
    required this.imageUrl,
    this.radius,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.color,
    this.colorBlendMode = BlendMode.multiply,
  });

  final String imageUrl;
  final double? radius;
  final BoxFit? fit;
  final double? width;
  final double? height;
  final Color? color;
  final BlendMode? colorBlendMode;

  @override
  Widget build(BuildContext context) {
    return Skeleton.replace(
      width: width,
      height: height,
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(radius ?? 0)),
        ),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          width: width,
          height: height,
          fit: fit,
          color: color,
          colorBlendMode: colorBlendMode,

          // placeholder: (context, url) => SizedBox.shrink(),
          progressIndicatorBuilder: _progressIndicatorBuilder,

          errorWidget: imageErrorWidget,
          errorListener: imageErrorListener,
        ),
      ),
    );
  }
}

Widget _progressIndicatorBuilder(
  BuildContext context,
  String url,
  DownloadProgress progress,
) {
  final theme = context.theme;
  return Center(
    child: SizedBox(
      width: 20,
      height: 20,
      child: CircularProgressIndicator(
        value: progress.progress,
        color: theme.colorScheme.primary,
        strokeWidth: 2.0,
      ),
    ),
  );
}
