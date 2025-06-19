import 'package:flutter/material.dart';

class CustomLinearProgressIndicator extends StatelessWidget {
  const CustomLinearProgressIndicator({
    super.key,
    required this.value,
    this.backgroundColor,
    this.color,
    this.minHeight = 5,
    this.borderRadius = const BorderRadius.all(Radius.circular(5)),
    this.title,
  });
  final double value;
  final Color? backgroundColor;
  final Color? color;
  final double? minHeight;
  final BorderRadiusGeometry? borderRadius;
  final Widget? title;
  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      children: [
        if (title != null) title!,
        Expanded(
          child: LinearProgressIndicator(
            value: value,
            minHeight: minHeight,
            color: color,
            backgroundColor: backgroundColor,
            borderRadius: borderRadius,
          ),
        ),
      ],
    );
  }
}
