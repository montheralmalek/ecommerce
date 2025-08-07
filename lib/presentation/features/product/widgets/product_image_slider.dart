import 'package:flutter/material.dart';
import 'package:store/core/utils/extensions/context_extensions.dart';
import 'package:store/core/widgets/item_card.dart';
import 'package:store/presentation/features/product/widgets/full_screen_images.dart';
import 'package:store/widgets/custom_carousel_slider.dart';

class ProductImagsSlider extends StatelessWidget {
  const ProductImagsSlider({super.key, required this.imageUrls});
  final List<String> imageUrls;
  @override
  Widget build(BuildContext context) {
    return CustomCarouselSlider.builder(
      itemCount: imageUrls.length,
      autoPlay: false,
      activeIndicatorColor: context.colorScheme.primary,
      height: 200,

      itemBuilder: (context, index, realIndex) {
        return InkWell(
          onTap:
              () => showFullScreenImages(
                context,
                currentIndex: index,
                imageUrls: imageUrls,
              ),
          child: Hero(
            tag: imageUrls[index],
            child: CustomCachedNetworkImage(
              fit: BoxFit.contain,

              imageUrl: imageUrls[index],
            ),
          ),
        );
      },
    );
  }
}
