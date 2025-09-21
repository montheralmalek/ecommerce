import 'package:flutter/material.dart';
import 'package:store/core/themes/app_colors.dart';
import 'package:store/core/utils/extensions/context_extensions.dart';
import 'package:store/ui/widgets/custom_cached_network_image.dart';
import 'package:store/ui/widgets/full_screen_images.dart';
import 'package:store/core/widgets/custom_carousel_slider.dart';

class ProductImagsSlider extends StatelessWidget {
  const ProductImagsSlider({
    super.key,
    required this.imageUrls,
    this.height,
    this.disAbleCenter = false,
  });
  final List<String> imageUrls;
  final double? height;
  final bool disAbleCenter;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.surface,
      child: CustomCarouselSlider.builder(
        disableCenter: disAbleCenter,
        itemCount: imageUrls.length,
        autoPlay: false,
        // enlargeCenterPage: true,
        // viewportFraction: 0.8,
        // aspectRatio: 16 / 9,
        indicatorAlignment: MainAxisAlignment.center,
        enableInfiniteScroll: imageUrls.length > 1,
        activeIndicatorColor: context.colorScheme.primary,
        height: height,

        // indicator: ,
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
                fit: BoxFit.cover,
                color: AppColors.surface,
                imageUrl: imageUrls[index],
              ),
            ),
          );
        },
        indicatorBuilder:
            (context, currentIndex, index) => AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              width: 40,
              height: index == currentIndex ? 50 : 40,
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              decoration: BoxDecoration(
                // shape: BoxShape.circle,
                // border:
                //     index == currentIndex
                //         ? Border.all(
                //           color: context.colorScheme.primary,
                //           width: 2,
                //         )
                //         : null,
              ),
              child: CustomCachedNetworkImage(
                fit: BoxFit.cover,
                color: AppColors.surface,
                imageUrl: imageUrls[index],
              ),
            ),
      ),
    );
  }
}
