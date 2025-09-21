import 'package:flutter/material.dart';

class AnimatedLoadingIcon extends StatefulWidget {
  const AnimatedLoadingIcon({
    super.key,
    this.animationHeight = 25,
    this.dotWidth = 10,
    this.duration = const Duration(seconds: 1),
  });
  final double animationHeight, dotWidth;
  final Duration duration;

  @override
  _AnimatedLoadingIconState createState() => _AnimatedLoadingIconState();
}

class _AnimatedLoadingIconState extends State<AnimatedLoadingIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController animController;
  final List<Animation<AlignmentGeometry>> _alignControllerList = [];
  final dotsColors = [
    const Color.fromARGB(255, 99, 45, 193),
    const Color.fromARGB(255, 0, 153, 255),
    const Color.fromARGB(255, 6, 167, 86),
    const Color.fromARGB(255, 249, 175, 0),
  ];

  @override
  void initState() {
    animController = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    double upDownAnimationWeight = 40.0;

    for (var i = 0; i < 4; i++) {
      double awaitBeforAnimation = i * (upDownAnimationWeight / 2);
      double awaitAfterAnimation =
          100 - (upDownAnimationWeight + awaitBeforAnimation);
      List<TweenSequenceItem<AlignmentGeometry>> tweenSequenceItems = [];

      ///------------ Add await befor animation without the first element
      if (i > 0) {
        tweenSequenceItems.add(
          TweenSequenceItem<AlignmentGeometry>(
            tween: Tween<AlignmentGeometry>(
              begin: Alignment.bottomCenter,
              end: Alignment.bottomCenter,
            ),
            weight: awaitBeforAnimation,
          ),
        );
      }

      // ///------ Add Animation Up Down ----------
      tweenSequenceItems.addAll([
        TweenSequenceItem<AlignmentGeometry>(
          tween: Tween<AlignmentGeometry>(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
          weight: upDownAnimationWeight / 2,
        ),
        TweenSequenceItem<AlignmentGeometry>(
          tween: Tween<AlignmentGeometry>(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ).chain(CurveTween(curve: Curves.bounceOut)),
          weight: upDownAnimationWeight / 2,
        ),
      ]);

      ///------------ Add await after animation without the last element
      if (i < 3) {
        tweenSequenceItems.add(
          TweenSequenceItem<AlignmentGeometry>(
            tween: Tween<AlignmentGeometry>(
              begin: Alignment.bottomCenter,
              end: Alignment.bottomCenter,
            ),
            weight: awaitAfterAnimation,
          ),
        );
      }

      _alignControllerList.add(
        TweenSequence<AlignmentGeometry>(tweenSequenceItems).animate(
          CurvedAnimation(
            parent: animController,
            curve: const Interval(0.0, 1.0),
          ),
        ),
      );
    }

    animController.repeat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // alignment: Alignment.topCenter,
      height: widget.animationHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
            _alignControllerList.asMap().entries.map<Widget>((entry) {
              final index = entry.key;
              final alignController = entry.value;
              return AlignTransition(
                alignment: alignController,
                child: CircularContainer(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: widget.dotWidth,
                  fillColor: dotsColors[index],
                ),
              );
            }).toList(),
      ),
    );
  }
}

class CircularContainer extends StatelessWidget {
  const CircularContainer({
    super.key,
    this.width,
    this.fillColor,
    this.strokeWidth = 0.0,
    this.strokeColor = const Color(0xff000000),
    this.child,
    this.margin,
    this.padding,
  });
  final Widget? child;
  final double? width;
  final double strokeWidth;
  final Color? fillColor;
  final Color strokeColor;
  final EdgeInsetsGeometry? margin, padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: width,
      width: width,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: fillColor,
        border:
            strokeWidth == 0
                ? null
                : Border.all(width: strokeWidth, color: strokeColor),
        shape: BoxShape.circle,
      ),
      child: child,
    );
  }
}
