import 'package:carousel_slider/carousel_slider.dart' as cs;
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:store/core/utils/extensions/context_extensions.dart';
import 'package:store/core/widgets/item_card.dart';
import 'package:store/domain/domain_models/banner.dart';
import 'package:store/domain/domain_models/section.dart';
import 'package:store/widgets/animation/animated_rising.dart';

class BannerSlider extends StatefulWidget {
  final bool isLoading;
  final List<BannerModel>? slides;

  const BannerSlider({super.key, this.isLoading = false, this.slides});

  @override
  State<BannerSlider> createState() => _BannerSliderState();
}

class _BannerSliderState extends State<BannerSlider> {
  final cs.CarouselSliderController _carouselController =
      cs.CarouselSliderController();

  int current = 0;

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: widget.isLoading,
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          cs.CarouselSlider.builder(
            carouselController: _carouselController,
            itemCount: widget.slides?.length, //state.categoriesList!.length,
            itemBuilder: _carouselItemBuilder,
            options: cs.CarouselOptions(
              height: 200,
              autoPlay: true,
              viewportFraction: 1,
              autoPlayInterval: const Duration(seconds: 5),
              enableInfiniteScroll: true,
              enlargeCenterPage: true,
              enlargeStrategy: cs.CenterPageEnlargeStrategy.height,
              disableCenter: true,
              onPageChanged: (index, reason) {
                setState(() {
                  current = index;
                });
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children:
                widget.slides?.asMap().entries.map((entry) {
                  return GestureDetector(
                    onTap: () => _carouselController.animateToPage(entry.key),
                    child: Container(
                      width: 10.0,
                      height: current == entry.key ? 13 : 10.0,
                      margin: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 4.0,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        shape: BoxShape.rectangle,
                        color: context.colorScheme.primary.withAlpha(
                          current == entry.key ? 255 : 100,
                        ),
                      ),
                    ),
                  );
                }).toList() ??
                [],
          ),
        ],
      ),
    );
  }

  Widget _carouselItemBuilder(
    BuildContext context,
    int itemIndex,
    int pageViewIndex,
  ) {
    final banner = widget.slides?[itemIndex];
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
