import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

typedef CarouselItemBuiler =
    Widget Function(BuildContext context, int index, int realIndex);
const _kDefaultAutoPlayInterval = Duration(seconds: 3);
const _kDefaultAnimationDuration = Duration(milliseconds: 800);
const _kDefaultAnimationCurve = Curves.fastOutSlowIn;

class CustomCarouselSlider extends StatefulWidget {
  final List<Widget>? items;
  final CarouselItemBuiler? itemBuilder;
  final int? itemCount;
  // options-------------
  final double? height;
  final bool autoPlay;
  final Duration autoPlayInterval;
  final Curve animationCurve;
  final Duration animationDuration;
  final bool enlargeCenterPage;
  final double viewportFraction;
  final double aspectRatio;
  final ValueChanged<int>? onPageChanged;
  final int initialPage;
  final bool enableInfiniteScroll;
  final bool reverse;
  final Axis scrollDirection;
  final bool disableCenter;
  // indicator ------------
  final Color inActiveIndicatorColor;
  final Color activeIndicatorColor;
  final double indicatorDotSize;
  final double indicatorSpacing;
  final bool showIndicator;
  final Widget? indicator;
  final MainAxisAlignment indicatorAlignment;
  final Widget Function(BuildContext context, int currentIndex, int index)?
  indicatorBuilder;

  const CustomCarouselSlider._({
    super.key,
    this.items,
    this.itemBuilder,
    this.itemCount,
    this.height,
    required this.autoPlay,
    required this.autoPlayInterval,
    required this.animationCurve,
    required this.animationDuration,
    required this.enlargeCenterPage,
    required this.viewportFraction,
    required this.aspectRatio,
    required this.initialPage,
    required this.enableInfiniteScroll,
    required this.reverse,
    required this.scrollDirection,
    required this.disableCenter,
    this.onPageChanged,

    required this.inActiveIndicatorColor,
    required this.activeIndicatorColor,
    required this.indicatorDotSize,
    required this.indicatorSpacing,
    required this.showIndicator,
    this.indicator,
    this.indicatorBuilder,
    this.indicatorAlignment = MainAxisAlignment.center,
  }) : assert(items != null || (itemBuilder != null && itemCount != null));

  ///
  factory CustomCarouselSlider({
    Key? key,
    required List<Widget>? items,
    double? height,
    bool autoPlay = true,
    int initialPage = 0,
    Duration autoPlayInterval = _kDefaultAutoPlayInterval,
    Curve animationCurve = _kDefaultAnimationCurve,
    Duration animationDuration = _kDefaultAnimationDuration,
    bool enlargeCenterPage = true,
    double viewportFraction = 0.9,
    double aspectRatio = 16 / 9,
    bool enableInfiniteScroll = true,
    bool reverse = false,
    Axis scrollDirection = Axis.horizontal,
    bool disableCenter = false,
    ValueChanged<int>? onPageChanged,
    Widget? indicator,
    Color inActiveIndicatorColor = Colors.grey,
    Color activeIndicatorColor = Colors.blue,
    double indicatorDotSize = 10.0,
    double indicatorSpacing = 8.0,
    bool showIndicator = true,
    MainAxisAlignment indicatorAlignment = MainAxisAlignment.center,
  }) => CustomCarouselSlider._(
    key: key,
    items: items,
    // itemBuilder: null,
    // itemCount: null,
    height: height,
    autoPlay: autoPlay,
    autoPlayInterval: autoPlayInterval,
    animationCurve: animationCurve,
    animationDuration: animationDuration,
    enlargeCenterPage: enlargeCenterPage,
    viewportFraction: viewportFraction,
    aspectRatio: aspectRatio,
    initialPage: initialPage,
    enableInfiniteScroll: enableInfiniteScroll,
    reverse: reverse,
    scrollDirection: scrollDirection,
    onPageChanged: onPageChanged,
    indicator: indicator,
    indicatorBuilder: null,
    disableCenter: disableCenter,
    inActiveIndicatorColor: inActiveIndicatorColor,
    activeIndicatorColor: activeIndicatorColor,
    indicatorDotSize: indicatorDotSize,
    indicatorSpacing: indicatorSpacing,
    showIndicator: showIndicator,
    indicatorAlignment: indicatorAlignment,
  );

  ///
  factory CustomCarouselSlider.builder({
    Key? key,
    required int itemCount,
    required CarouselItemBuiler itemBuilder,
    double? height,
    bool autoPlay = true,
    int initialPage = 0,
    Duration autoPlayInterval = _kDefaultAutoPlayInterval,
    Curve animationCurve = _kDefaultAnimationCurve,
    Duration animationDuration = _kDefaultAnimationDuration,
    bool enlargeCenterPage = true,
    double viewportFraction = 1,
    double aspectRatio = 16 / 9,
    bool enableInfiniteScroll = true,
    bool reverse = false,
    Axis scrollDirection = Axis.horizontal,
    bool disableCenter = false,
    ValueChanged<int>? onPageChanged,
    Widget? indicator,
    Color inActiveIndicatorColor = Colors.grey,
    Color activeIndicatorColor = Colors.blue,
    double indicatorDotSize = 10.0,
    double indicatorSpacing = 8.0,
    bool showIndicator = true,
    MainAxisAlignment indicatorAlignment = MainAxisAlignment.center,
    Widget Function(BuildContext context, int currentIndex, int index)?
    indicatorBuilder,
  }) => CustomCarouselSlider._(
    key: key,
    items: null,
    itemBuilder: itemBuilder,
    itemCount: itemCount,
    height: height,
    autoPlay: autoPlay,
    autoPlayInterval: autoPlayInterval,
    animationCurve: animationCurve,
    animationDuration: animationDuration,
    enlargeCenterPage: enlargeCenterPage,
    viewportFraction: viewportFraction,
    aspectRatio: aspectRatio,
    initialPage: initialPage,
    enableInfiniteScroll: enableInfiniteScroll,
    reverse: reverse,
    scrollDirection: scrollDirection,
    disableCenter: disableCenter,
    onPageChanged: onPageChanged,
    indicator: indicator,
    inActiveIndicatorColor: inActiveIndicatorColor,
    activeIndicatorColor: activeIndicatorColor,
    indicatorDotSize: indicatorDotSize,
    indicatorSpacing: indicatorSpacing,
    showIndicator: showIndicator,
    indicatorAlignment: indicatorAlignment,
    indicatorBuilder: indicatorBuilder,
  );

  @override
  _CustomCarouselSliderState createState() => _CustomCarouselSliderState();
}

class _CustomCarouselSliderState extends State<CustomCarouselSlider> {
  final CarouselSliderController _carouselController =
      CarouselSliderController();
  int _currentIndex = 0;
  int get itemCount => widget.itemCount ?? widget.items?.length ?? 0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: [
        widget.items != null
            ? CarouselSlider(
              carouselController: _carouselController,
              items: widget.items,
              options: _buildCarouselOptions(),
            )
            : CarouselSlider.builder(
              carouselController: _carouselController,
              itemCount: widget.itemCount!,
              itemBuilder: widget.itemBuilder!,
              options: _buildCarouselOptions(),
            ),
        if (widget.showIndicator) _buildDotIndicators(context),
      ],
    );
  }

  CarouselOptions _buildCarouselOptions() {
    return CarouselOptions(
      height: widget.height,
      autoPlay: widget.autoPlay,
      autoPlayInterval: widget.autoPlayInterval,
      autoPlayCurve: widget.animationCurve,
      autoPlayAnimationDuration: widget.animationDuration,
      enlargeCenterPage: widget.enlargeCenterPage,
      viewportFraction: widget.viewportFraction,
      aspectRatio: widget.aspectRatio,
      initialPage: widget.initialPage,
      enableInfiniteScroll: widget.enableInfiniteScroll,
      reverse: widget.reverse,
      // enlargeStrategy: CenterPageEnlargeStrategy.height,
      disableCenter: widget.disableCenter,
      onPageChanged: (index, reason) {
        setState(() => _currentIndex = index);
        widget.onPageChanged?.call(index);
      },
    );
  }

  Widget _buildDotIndicators(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: widget.indicatorAlignment,
        // mainAxisSize: MainAxisSize.min,
        children:
            itemCount > 1
                ? List.generate(itemCount, (index) {
                  return GestureDetector(
                    onTap: () => _onIndicatorTap(index),
                    child:
                        widget.indicatorBuilder?.call(
                          context,
                          _currentIndex,
                          index,
                        ) ??
                        _defaultIndicator(index),
                  );
                })
                : const [],
      ),
    );
  }

  void _onIndicatorTap(int index) {
    _carouselController.animateToPage(
      index,
      duration: widget.animationDuration,
      curve: widget.animationCurve,
    );
  }

  AnimatedContainer _defaultIndicator(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width:
          _currentIndex == index
              ? widget.indicatorDotSize * 1.2
              : widget.indicatorDotSize,
      height:
          _currentIndex == index
              ? widget.indicatorDotSize * 1.2
              : widget.indicatorDotSize,
      margin: EdgeInsets.symmetric(horizontal: widget.indicatorSpacing / 2),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color:
            _currentIndex == index
                ? widget.activeIndicatorColor
                : widget.inActiveIndicatorColor,
      ),
    );
  }
}
