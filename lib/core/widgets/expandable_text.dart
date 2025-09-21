import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:store/core/utils/extensions/context_extensions.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  final int trimLines;
  final TextStyle? style;
  final String expandText;
  final String collapseText;
  final TextStyle? linkStyle;
  final TextAlign textAlign;

  const ExpandableText(
    this.text, {
    super.key,
    this.trimLines = 3,
    this.style,
    this.expandText = 'Show more',
    this.collapseText = 'Show less',
    this.linkStyle,
    this.textAlign = TextAlign.start,
  });

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  final _log = Logger('ExpandableText');
  bool _expanded = false;

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) => _checkOverflow());
  }

  bool _isOverflowing(BuildContext context, BoxConstraints constraints) {
    final textSpan = TextSpan(
      text: widget.text,
      style: widget.style ?? _defaultTextStyle(context),
    );
    final textPainter = TextPainter(
      text: textSpan,
      maxLines: widget.trimLines,
      textDirection: context.textDirection,
    );
    textPainter.layout(maxWidth: constraints.maxWidth);
    _log.info(
      'Text overflow check: maxLines=${widget.trimLines}, '
      'didExceedMaxLines=${textPainter.didExceedMaxLines}',
    );
    return textPainter.didExceedMaxLines;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isOverflowing = _isOverflowing(context, constraints);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.text,
              style: widget.style ?? _defaultTextStyle(context),
              maxLines: _expanded ? null : widget.trimLines,
              overflow: TextOverflow.fade,
              textAlign: widget.textAlign,
            ),
            if (isOverflowing)
              GestureDetector(
                onTap: () => setState(() => _expanded = !_expanded),
                child: Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    _expanded ? widget.collapseText : widget.expandText,
                    style: widget.linkStyle ?? _defaultlinkTextStyle(context),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  TextStyle _defaultTextStyle(BuildContext context) {
    return context.textTheme.bodyMedium?.copyWith(
          color: context.theme.hintColor,
        ) ??
        TextStyle(color: context.theme.hintColor, fontSize: 14);
  }

  TextStyle? _defaultlinkTextStyle(BuildContext context) {
    return TextStyle(
      color: Theme.of(context).colorScheme.primary,
      fontWeight: FontWeight.w600,
    );
  }
}
