import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum _ButtonVariant { filled, tonal, icon, tonalIcon }

class CustomFilledButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool expanded;
  final String? label;
  final Widget? icon;
  final _ButtonVariant _variant;
  final BorderRadiusGeometry broderRadius;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final TextStyle? labelStyle;
  final BorderSide borderSide;
  final double minimumHeight;

  //
  static const _kDefaultRaduis = BorderRadius.all(Radius.circular(10));
  static const _kDefaultPadding = EdgeInsets.all(5);

  ///
  const CustomFilledButton({
    super.key,
    this.onPressed,
    this.expanded = true,
    required this.label,
    this.broderRadius = _kDefaultRaduis,
    this.width,
    this.padding = _kDefaultPadding,
    this.labelStyle,
    this.borderSide = BorderSide.none,
    this.minimumHeight = 0,
  }) : icon = null,
       _variant = _ButtonVariant.filled;

  /// Creates a button with a tonal style.
  const CustomFilledButton.tonal({
    super.key,
    this.onPressed,
    this.expanded = true,
    required this.label,
    this.broderRadius = _kDefaultRaduis,
    this.width,
    this.padding = _kDefaultPadding,
    this.labelStyle,
    this.borderSide = BorderSide.none,
    this.minimumHeight = 0,
  }) : icon = null,
       _variant = _ButtonVariant.tonal;

  /// Creates a button with an icon.
  const CustomFilledButton.icon({
    super.key,
    required this.onPressed,
    this.expanded = true,
    this.label,
    required this.icon,
    this.broderRadius = _kDefaultRaduis,
    this.width,
    this.padding = _kDefaultPadding,
    this.labelStyle,
    this.borderSide = BorderSide.none,
    this.minimumHeight = 0,
  }) : _variant = _ButtonVariant.icon;

  /// Creates a button with a tonal icon.
  const CustomFilledButton.tonalIcon({
    super.key,
    required this.onPressed,
    this.expanded = true,
    this.label,
    required this.icon,
    this.broderRadius = _kDefaultRaduis,
    this.width,
    this.padding = _kDefaultPadding,
    this.labelStyle,
    this.borderSide = BorderSide.none,
    this.minimumHeight = 0,
  }) : _variant = _ButtonVariant.tonalIcon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          flex: expanded ? 1 : 0,
          fit: FlexFit.tight,
          child: _getButton(),
        ),
      ],
    );
  }

  Widget _getButton() {
    switch (_variant) {
      case _ButtonVariant.tonal:
        return _filledButtonTonal();
      case _ButtonVariant.icon:
        return _filledButtonIcon();
      case _ButtonVariant.tonalIcon:
        return _filledButtonTonalIcon();
      default:
        return _filledButton();
    }
  }

  ButtonStyle get _buttonStyle {
    return FilledButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: broderRadius,
        side: borderSide,
      ),
      minimumSize: Size.square(minimumHeight),
      padding: padding,
      fixedSize: width != null ? Size(width!, 45) : null,
    );
  }

  Widget _filledButton() {
    return FilledButton(
      onPressed: onPressed,
      style: _buttonStyle,
      child: Text(label ?? ''),
    );
  }

  Widget _filledButtonTonal() {
    return FilledButton.tonal(
      onPressed: onPressed,
      style: _buttonStyle,
      child: Text(label ?? ''),
    );
  }

  Widget _filledButtonIcon() {
    return label == null
        ? FilledButton(onPressed: onPressed, style: _buttonStyle, child: icon)
        : FilledButton.icon(
          onPressed: onPressed,
          label: Text(label!),
          icon: icon,
          style: _buttonStyle,
        );
  }

  Widget _filledButtonTonalIcon() {
    return label == null
        ? FilledButton.tonal(
          onPressed: onPressed,
          style: _buttonStyle,
          child: icon,
        )
        : FilledButton.tonalIcon(
          onPressed: onPressed,
          label: Text(label!),
          icon: icon ?? const SizedBox.shrink(),
          style: _buttonStyle,
        );
  }
}
