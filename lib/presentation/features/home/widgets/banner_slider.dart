import 'package:flutter/material.dart';
import 'package:store/core/utils/extensions/context_extensions.dart';
import 'package:store/core/widgets/item_card.dart';
import 'package:store/domain/entities/ad_banner.dart';
import 'package:store/widgets/animation/animated_rising.dart';
import 'package:store/widgets/custom_carousel_slider.dart';

class BannerSliderWidget extends StatelessWidget {
  final List<AdBanner>? slides;

  const BannerSliderWidget({super.key, this.slides});

  @override
  Widget build(BuildContext context) {
    return CustomCarouselSlider.builder(
      itemCount: slides?.length ?? 0, //state.categoriesList!.length,
      itemBuilder: _carouselItemBuilder,
      initialPage: 0,
      height: 200,
      autoPlay: true,
      viewportFraction: 1,
      autoPlayInterval: const Duration(seconds: 5),
      enableInfiniteScroll: true,
      enlargeCenterPage: true,
      disableCenter: true,
      inActiveIndicatorColor: context.theme.disabledColor,
      activeIndicatorColor: context.colorScheme.secondary,
      onPageChanged: (value) {},
    );
  }

  Widget _carouselItemBuilder(
    BuildContext context,
    int itemIndex,
    int pageViewIndex,
  ) {
    final banner = slides?[itemIndex];
    return AnimatedRising(
      scaleBegin: 1,
      duration: Duration(milliseconds: 900),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 0),
        decoration: BoxDecoration(
          // image: DecorationImage(image: CachedNetworkImageProvider(banner)),
        ),
        child:
            banner != null
                ? CustomCachedNetworkImage(imageUrl: banner.imageUrl, radius: 0)
                : null,
      ),
    );
  }
}
