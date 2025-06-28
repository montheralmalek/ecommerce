import 'package:flutter/material.dart';

class RatingBar extends StatefulWidget {
  const RatingBar({
    super.key,
    required this.rateValue,
    required this.itemCount,
    this.itemSize = 34,
    this.allowHalfRating = false,
    this.onRatingUpdate,
    this.minRating = 0.0,
    this.maxRating = 5.0,
    this.spacing = 10.0,
    this.itemBuilder,
    this.unratedColor,
    this.ratedColor,
  }) : assert(itemCount > 0, 'itemCount must be greater than 0'),
       assert(itemSize > 0, 'itemSize must be greater than 0'),
       assert(
         minRating == null || minRating >= 0,
         'minRating must be non-negative',
       ),
       assert(
         maxRating == null || minRating == null || maxRating >= minRating,
         'maxRating must be greater than or equal to minRating!',
       ),
       assert(spacing == null || spacing >= 0, 'spacing must be non-negative');

  /// Creates a star rating bar with the specified parameters.
  factory RatingBar.star({
    double rateValue = 0.0,
    int itemCount = 5,
    double itemSize = 24.0,
    bool allowHalfRating = false,
    ValueChanged<double>? onRatingUpdate,
    double? minRating,
    double? maxRating,
    double? spacing,
    Widget Function(BuildContext, int)? itemBuilder,
    Color? unratedColor,
    Color? ratedColor,
  }) {
    return RatingBar(
      rateValue: rateValue,
      itemCount: itemCount,
      itemSize: itemSize,
      allowHalfRating: allowHalfRating,
      onRatingUpdate: onRatingUpdate,
      minRating: minRating ?? 0.0,
      maxRating: maxRating ?? 5.0,
      spacing: spacing ?? 0.0,
      unratedColor: unratedColor ?? Colors.grey,
      ratedColor: ratedColor ?? Colors.amber,
      itemBuilder:
          itemBuilder ??
          (context, index) => Icon(Icons.star_rate, size: itemSize),
    );
  }

  final double rateValue;
  final int itemCount;
  final double itemSize;
  final bool allowHalfRating;
  final ValueChanged<double>? onRatingUpdate;
  final double? minRating;
  final double? maxRating;
  final double? spacing;
  final Widget Function(BuildContext, int)? itemBuilder;
  final Color? unratedColor;
  final Color? ratedColor;

  @override
  State<RatingBar> createState() => _RatingBarState();
}

class _RatingBarState extends State<RatingBar> {
  double get _currentRating => widget.rateValue;
  double get _clampedRating =>
      widget.rateValue.clamp(widget.minRating ?? 0.0, widget.maxRating ?? 5.0);
  int get _floorRating => _currentRating.floor();
  bool _isFullStar(int index) {
    return index < _floorRating;
  }

  bool _isHalfStar(int index) {
    return widget.allowHalfRating &&
        index == _floorRating &&
        _currentRating - _floorRating >= 0.0;
  }

  Color _itemColor(int index) {
    return _isFullStar(index) || _isHalfStar(index)
        ? _ratedColor
        : _unratedColor;
  }

  Color get _unratedColor => widget.unratedColor ?? Colors.grey;
  Color get _ratedColor => widget.ratedColor ?? Colors.amber;
  Widget _ratingWidget(BuildContext context, int index) {
    if (widget.itemBuilder != null) {
      if (_isHalfStar(index)) {
        return HalfColoredStar(
          size: widget.itemSize,
          // enableMask: true,
          filledColor: _ratedColor,
          emptyColor: _unratedColor,
          fillPercent: (_currentRating - _floorRating),
          child: widget.itemBuilder!(context, index),
        );
      }
      return _RatingItemWidget(
        size: widget.itemSize,
        enableMask: true,
        itemColor: _itemColor(index),
        child: widget.itemBuilder!(context, index),
      );
    }
    return Icon(
      index < _currentRating.floor()
          ? Icons.star_rate
          : (widget.allowHalfRating &&
              index == _currentRating.floor() &&
              _currentRating - index >= 0.5)
          ? Icons.star_half
          : Icons.star_border,
      size: widget.itemSize,
      color: _itemColor(index),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  void _onTap(int index) {
    double newRating = widget.allowHalfRating ? index + 0.5 : index + 1.0;
    if (widget.allowHalfRating && _currentRating == index + 0.5) {
      newRating += 0.5;
    }
    if (newRating > (widget.maxRating ?? 5.0)) {
      newRating = widget.maxRating ?? 5.0;
    }
    // setState(() {
    //   _currentRating = newRating;
    // });
    widget.onRatingUpdate?.call(newRating);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: widget.spacing ?? 0.0,
      children: List.generate(widget.itemCount, (index) {
        return GestureDetector(
          onTap: () => _onTap(index),
          child: _ratingWidget(context, index),
        );
      }),
    );
  }
}

// class _RatedWidget extends StatelessWidget {
//   const _RatedWidget({
//     required this.size,
//     required this.child,
//     required this.enableMask,
//     required this.ratedColor,
//   });

//   final double size;
//   final Widget child;
//   final bool enableMask;
//   final Color ratedColor;

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: size,
//       width: size,
//       child: FittedBox(
//         fit: BoxFit.contain,
//         child:
//             enableMask
//                 ? ColorFiltered(
//                   colorFilter: ColorFilter.mode(ratedColor, BlendMode.srcIn),
//                   child: child,
//                 )
//                 : child,
//       ),
//     );
//   }
// }

class _RatingItemWidget extends StatelessWidget {
  const _RatingItemWidget({
    required this.size,
    required this.child,
    required this.enableMask,
    required this.itemColor,
  });

  final double size;
  final Widget child;
  final bool enableMask;
  final Color itemColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: FittedBox(
        fit: BoxFit.contain,
        child:
            enableMask
                ? ColorFiltered(
                  colorFilter: ColorFilter.mode(itemColor, BlendMode.srcIn),
                  child: child,
                )
                : child,
      ),
    );
  }
}

class _HalfRatingWidget extends StatelessWidget {
  const _HalfRatingWidget({
    required this.size,
    required this.child,
    required this.enableMask,
    required this.ratedColor,
  });

  final double size;
  final Widget child;
  final bool enableMask;
  final Color ratedColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: FittedBox(
        fit: BoxFit.contain,
        child:
            enableMask
                ? ColorFiltered(
                  colorFilter: ColorFilter.mode(ratedColor, BlendMode.srcIn),
                  child: ClipRect(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      widthFactor: 0.5,
                      child: Icon(Icons.star, color: ratedColor),
                    ),
                  ),
                )
                : child,
      ),
    );
  }
}

class HalfColoredStar extends StatelessWidget {
  final double fillPercent; // 0.0 to 1.0
  final Color filledColor;
  final Color emptyColor;
  final double size;
  final Widget child;

  const HalfColoredStar({
    super.key,
    required this.fillPercent,
    this.filledColor = Colors.amber,
    this.emptyColor = Colors.grey,
    this.size = 24.0,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: size,
          width: size,
          child: MaskedWidget(color: emptyColor, child: child),
        ),

        // Icon(Icons.star, color: emptyColor, size: size),
        ClipRect(
          child: Align(
            alignment: Alignment.centerLeft,
            widthFactor: fillPercent,
            child: SizedBox(
              height: size,
              width: size,
              child: MaskedWidget(color: filledColor, child: child),
            ),
          ),
        ),
      ],
    );
  }
}

class MaskedWidget extends StatelessWidget {
  final Widget? child;
  final Color color;
  final BoxFit fit;

  const MaskedWidget({
    super.key,
    required this.child,
    required this.color,
    this.fit = BoxFit.contain,
  });

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: fit,
      child: ColorFiltered(
        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
        child: child,
      ),
    );
  }
}
