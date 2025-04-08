import 'package:flutter/material.dart';

enum _ButtonVariant { filled, tonal, icon, tonalIcon }

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool expanded;
  final String? label;
  final Widget? icon;
  final _ButtonVariant _variant;
  final BorderRadiusGeometry? broderRadius;
  final double? width;
  final EdgeInsetsGeometry? padding;

  const CustomButton({
    super.key,
    this.onPressed,
    this.expanded = true,
    required this.label,
    this.broderRadius,
    this.width,
    this.padding,
  })  : icon = null,
        _variant = _ButtonVariant.filled;
  const CustomButton.tonal({
    super.key,
    this.onPressed,
    this.expanded = true,
    required this.label,
    this.broderRadius,
    this.width,
    this.padding,
  })  : icon = null,
        _variant = _ButtonVariant.tonal;
  const CustomButton.icon({
    super.key,
    required this.onPressed,
    this.expanded = true,
    this.label,
    required this.icon,
    this.broderRadius,
    this.width,
    this.padding,
  }) : _variant = _ButtonVariant.icon;
  const CustomButton.tonalIcon({
    super.key,
    required this.onPressed,
    this.expanded = true,
    this.label,
    required this.icon,
    this.broderRadius,
    this.width,
    this.padding,
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
        )
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
            borderRadius: broderRadius ?? BorderRadius.circular(10)),
        minimumSize: const Size.square(45),
        padding: padding,
        fixedSize: width != null ? Size(width!, 48) : null);
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
    if (label == null) {
      return IconButton.filled(
        onPressed: onPressed,
        icon: icon ?? const SizedBox(),
        style: _buttonStyle,
      );
    }
    return FilledButton.icon(
      onPressed: onPressed,
      label: label != null ? Text(label!) : const SizedBox(),
      icon: icon ?? const SizedBox(),
      style: _buttonStyle,
    );
  }

  Widget _filledButtonTonalIcon() {
    if (label == null) {
      return IconButton.filledTonal(
        onPressed: onPressed,
        icon: icon ?? const SizedBox(),
        style: _buttonStyle,
      );
    }
    return FilledButton.tonalIcon(
      onPressed: onPressed,
      label: Text(label!),
      icon: icon ?? const SizedBox(),
      style: _buttonStyle,
    );
  }
}
