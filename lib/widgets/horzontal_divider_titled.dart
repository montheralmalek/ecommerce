import 'package:flutter/material.dart';

class HorzontalDivdierTitled extends StatelessWidget {
  final String text;
  final double? indent;
  final double? endIndent;
  final double? thickness;
  final double? height;
  final Color? color;
  final TextStyle? textStyle;
  final MainAxisAlignment textAlignment;

  const HorzontalDivdierTitled({
    super.key,
    required this.text,
    this.indent,
    this.endIndent,
    this.color,
    this.thickness,
    this.height = 40,
    this.textStyle,
    this.textAlignment = MainAxisAlignment.center,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment: textAlignment,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (textAlignment != MainAxisAlignment.start)
          Expanded(
            child: Divider(
              indent: indent,
              endIndent: 10,
              thickness: thickness,
              height: height,
              color: color?.withValues(alpha: 0.6),
            ),
          ),
        Text(
          text,
          style:
              textStyle ??
              Theme.of(context).textTheme.titleLarge?.copyWith(color: color),
        ),
        if (textAlignment != MainAxisAlignment.end)
          Expanded(
            child: Divider(
              indent: 10,
              endIndent: endIndent,
              thickness: thickness,
              height: height,
              color: color?.withValues(alpha: 0.6),
            ),
          ),
      ],
    );
  }
}
// Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Expanded(
//           child: Divider(
//             indent: indent,
//             endIndent: 8,
//             thickness: thickness,
//             height: height,
//             color: color?.withOpacity(0.6),
//           ),
//         ),
//         Text(
//           text,
//           style: textStyle ??
//               Theme.of(context).textTheme.titleLarge?.copyWith(color: color),
//         ),
//         Expanded(
//           child: Divider(
//             indent: 8,
//             endIndent: endIndent,
//             thickness: thickness,
//             height: height,
//             color: color?.withOpacity(0.6),
//           ),
//         ),
//       ],
//     )