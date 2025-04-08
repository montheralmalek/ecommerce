import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedRising extends StatefulWidget {
  const AnimatedRising({
    super.key,
    this.child,
    this.duration = const Duration(milliseconds: 700),
    this.waitDuration = const Duration(),
    this.rotationCount = 0.0,
    this.scaleBegin = 0.0,
    this.scaleEnd = 1.0,
    this.opacityBegin = 0.0,
    this.opacityEnd = 1.0,
    this.scaleX = false,
    this.scaleY = false,
    this.alignment = Alignment.center,
    this.scaleCurve = Curves.linear,
  });
  final Widget? child;
  final Duration duration, waitDuration;
  final double rotationCount, scaleBegin, scaleEnd, opacityBegin, opacityEnd;
  final bool scaleX, scaleY;
  final AlignmentGeometry alignment;
  final Curve scaleCurve;

  @override
  _AnimatedRisingState createState() => _AnimatedRisingState();
}

class _AnimatedRisingState extends State<AnimatedRising>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _opacityController;
  late Animation<double> _scaleController;
  late Animation<double> _rotateController;
  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _opacityController = Tween<double>(
      begin: widget.opacityBegin,
      end: widget.opacityEnd,
    ).animate(_animationController);
    _scaleController = Tween<double>(
      begin: widget.scaleBegin,
      end: widget.scaleEnd,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: widget.scaleCurve),
    );
    _rotateController = Tween<double>(
      begin: 0.0,
      end: widget.rotationCount * (2 * pi),
    ).animate(_animationController);
    Future.delayed(widget.waitDuration, () {
      _animationController.forward();
    });
    // _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.rotate(
          angle: _rotateController.value,
          child: Transform.scale(
            scaleX: widget.scaleX ? _scaleController.value : null,
            scaleY: widget.scaleY ? _scaleController.value : null,
            scale:
                widget.scaleX || widget.scaleY ? null : _scaleController.value,
            alignment: widget.alignment,
            child: Opacity(
              opacity: _opacityController.value,
              child: widget.child,
            ),
          ),
        );
      },
    );
  }
}

///---------------------------------------------------------
///---------------------------------------------------------
class AnimatedTransition extends StatefulWidget {
  final Widget? child;
  final Axis axis;
  final MainAxisAlignment horizontalAlignment;
  final VerticalDirection verticalDirection;
  final Animation<double> animation;

  const AnimatedTransition({
    super.key,
    this.axis = Axis.horizontal,
    this.child,
    this.horizontalAlignment = MainAxisAlignment.end,
    this.verticalDirection = VerticalDirection.down,
    required this.animation,
  });

  @override
  _AnimatedTransitionState createState() => _AnimatedTransitionState();
}

class _AnimatedTransitionState extends State<AnimatedTransition>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _sizeController;
  late Animation<double> _opacityController;
  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    _sizeController = CurvedAnimation(
      parent: widget.animation,
      curve: Curves.easeInOut,
    );
    _opacityController = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: widget.animation, curve: Curves.easeIn));
    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Row(
          mainAxisAlignment: widget.horizontalAlignment,
          children: [
            Column(
              verticalDirection: widget.verticalDirection,
              children: [
                SizeTransition(
                  sizeFactor: _sizeController,
                  axisAlignment: _axisAlignment,
                  axis: widget.axis,
                  child: Opacity(
                    opacity: _opacityController.value,
                    child: widget.child,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  double get _axisAlignment {
    if (widget.axis == Axis.vertical) {
      return widget.verticalDirection == VerticalDirection.up ? -1.0 : 1.0;
    }
    if (widget.horizontalAlignment == MainAxisAlignment.end &&
        widget.verticalDirection == VerticalDirection.up) {
      return -1.0;
    }
    if (widget.horizontalAlignment == MainAxisAlignment.start &&
        widget.verticalDirection == VerticalDirection.up) {
      return 1.0;
    }
    if (widget.horizontalAlignment == MainAxisAlignment.end &&
        widget.verticalDirection == VerticalDirection.down) {
      return -1.0;
    }
    return 1.0;
  }
}
