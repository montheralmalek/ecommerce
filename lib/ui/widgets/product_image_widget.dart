import 'package:flutter/material.dart';
import 'package:store/core/themes/app_colors.dart';
import 'package:store/ui/widgets/custom_cached_network_image.dart';

class ProductImageWidget extends StatelessWidget {
  const ProductImageWidget({
    super.key,
    required this.imageUrl,
    this.radius,
    this.fit = BoxFit.cover,
  });

  final String imageUrl;
  final double? radius;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return CustomCachedNetworkImage(
      imageUrl: imageUrl,
      radius: radius,
      fit: fit,
      color: AppColors.surface,
      // colorBlendMode: BlendMode.multiply,
    );
  }
}
