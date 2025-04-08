import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TextWithLinkWidget extends StatelessWidget {
  const TextWithLinkWidget(
      {super.key,
      required this.unlinkText,
      required this.linkText,
      this.onTap,
      this.unlinkTextStyle,
      this.linkTextStyle});

  final String unlinkText;
  final String linkText;
  final VoidCallback? onTap;
  final TextStyle? unlinkTextStyle;
  final TextStyle? linkTextStyle;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(children: [
        TextSpan(text: '$unlinkText ', style: unlinkTextStyle),
        TextSpan(
          text: linkText,
          mouseCursor: SystemMouseCursors.click,
          style: linkTextStyle ??
              TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
          recognizer: TapGestureRecognizer()..onTap = onTap,
        ),
      ]),
    );
  }
}
