import 'package:carousel_slider/carousel_slider.dart' as cs;
import 'package:flutter/material.dart';
import 'package:store/presentation/views/home/home_screen.dart';

class BannerSlider extends StatefulWidget {
  const BannerSlider({super.key});

  // final List imageList;
  final List<BannerWidget> banners = const [
    BannerWidget(
      // imageUrl: 'assets/images/banner1.png',
      title: 'Banner 1',
      backgroundColor: Colors.amber,
      // description: 'Description for Banner 1',
    ),
    BannerWidget(
      // imageUrl: 'assets/images/banner2.png',
      title: 'Banner 2',
      backgroundColor: Colors.amber,
      // description: 'Description for Banner 2',
    ),
    BannerWidget(
      // imageUrl: 'assets/images/banner3.png',
      title: 'Banner 3',
      backgroundColor: Colors.amber,
      // description: 'Description for Banner 3',
    ),
  ];
  @override
  State<BannerSlider> createState() => _BannerSliderState();
}

class _BannerSliderState extends State<BannerSlider> {
  final cs.CarouselSliderController _carouselController =
      cs.CarouselSliderController();

  int current = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      // color: Colors.amber,
      mainAxisSize: MainAxisSize.min,
      children: [
        cs.CarouselSlider.builder(
          carouselController: _carouselController,
          itemCount: widget.banners.length, //state.categoriesList!.length,
          itemBuilder:
              (BuildContext context, int itemIndex, int pageViewIndex) =>
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 6),
                    child: widget.banners[itemIndex],
                    //  CategoryCardWidget(
                    //   category: widget.imageList[itemIndex],
                    //   width: double.infinity,
                    //   circularRadius: 10,
                    // ),
                  ),
          options: cs.CarouselOptions(
            height: 200,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 5),
            enableInfiniteScroll: true,
            enlargeCenterPage: true,
            enlargeStrategy: cs.CenterPageEnlargeStrategy.height,
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
              widget.banners.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () => _carouselController.animateToPage(entry.key),
                  child: Container(
                    width: 10.0,
                    height: current == entry.key ? 15 : 10.0,
                    margin: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 4.0,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      shape: BoxShape.rectangle,
                      color: Colors.amber.withAlpha(
                        current == entry.key ? 255 : 100,
                      ),
                    ),
                  ),
                );
              }).toList(),
        ),
      ],
    );
  }
}
