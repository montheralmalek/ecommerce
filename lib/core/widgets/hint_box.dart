import 'package:flutter/material.dart';

class HintBox extends StatefulWidget {
  final String hintText;
  final HintBoxType hintBoxType;
  // final IconData? icon;
  // final Color? backgroundColor;
  // final TextStyle? textStyle;
  final bool isDismissable;

  const HintBox({
    super.key,
    this.hintBoxType = HintBoxType.info,
    required this.hintText,
    this.isDismissable = true,
  });

  @override
  State<HintBox> createState() => _HintBoxState();
}

class _HintBoxState extends State<HintBox> {
  bool _isVisible = true;
  @override
  Widget build(BuildContext context) {
    return _isVisible
        ? Container(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          decoration: BoxDecoration(
            color: _backgroundColor(context),
            borderRadius: BorderRadius.circular(6),
            border: BorderDirectional(
              start: BorderSide(color: _iconColor(context), width: 5),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _getIcon(context),
              const SizedBox(width: 8),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      color: _hintTextColor(context),
                      fontSize: 16,
                    ),
                    children: [
                      TextSpan(
                        text: '${widget.hintBoxType.value}: ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          // color: Theme.of(context).colorScheme.onErrorContainer,
                        ),
                      ),
                      TextSpan(text: widget.hintText),
                    ],
                  ),
                ),
              ),
              if (widget.isDismissable)
                InkWell(
                  child: Icon(Icons.close, color: _hintTextColor(context)),
                  onTap: () {
                    setState(() {
                      _isVisible = false;
                    });
                  },
                ),
            ],
          ),
        )
        : SizedBox.shrink();
  }

  Color _hintTextColor(BuildContext context) {
    switch (widget.hintBoxType) {
      case HintBoxType.info:
        return Theme.of(context).colorScheme.onPrimaryContainer;
      case HintBoxType.note:
        return Theme.of(context).colorScheme.onSecondaryContainer;
      case HintBoxType.error:
        return Theme.of(context).colorScheme.onErrorContainer;
      case HintBoxType.warning:
        return Theme.of(context).colorScheme.onTertiaryContainer;
      case HintBoxType.success:
        return Theme.of(context).colorScheme.onSurface;
    }
  }

  Color _backgroundColor(BuildContext context) {
    switch (widget.hintBoxType) {
      case HintBoxType.info:
        return Theme.of(context).colorScheme.primaryContainer;
      case HintBoxType.note:
        return Theme.of(context).colorScheme.secondaryContainer;
      case HintBoxType.error:
        return Theme.of(context).colorScheme.errorContainer;
      case HintBoxType.warning:
        return Theme.of(context).colorScheme.tertiaryContainer;
      case HintBoxType.success:
        return Theme.of(context).colorScheme.surfaceContainerHighest;
    }
  }

  Color _iconColor(BuildContext context) {
    switch (widget.hintBoxType) {
      case HintBoxType.info:
        return Theme.of(context).colorScheme.primary;
      case HintBoxType.note:
        return Theme.of(context).colorScheme.secondary;
      case HintBoxType.error:
        return Theme.of(context).colorScheme.error;
      case HintBoxType.warning:
        return Theme.of(context).colorScheme.tertiary;
      case HintBoxType.success:
        return Theme.of(context).colorScheme.surface;
    }
  }

  Widget _getIcon(BuildContext context) {
    switch (widget.hintBoxType) {
      case HintBoxType.info:
        return Icon(Icons.info_outline, color: _iconColor(context));
      case HintBoxType.note:
        return Icon(Icons.note, color: _iconColor(context));
      case HintBoxType.error:
        return Icon(Icons.error, color: _iconColor(context));
      case HintBoxType.warning:
        return Icon(Icons.warning, color: _iconColor(context));
      case HintBoxType.success:
        return Icon(Icons.check_circle, color: _iconColor(context));
    }
  }
}

enum HintBoxType {
  info('Info'),
  note('Note'),
  error('Error'),
  warning('Warning'),
  success('Success');

  final String value;

  const HintBoxType(this.value);
}
