import 'package:flutter/material.dart';

enum _ButtonVariant { elevated, filled, tonal, icon, tonalIcon, outLined }

const _kDefaultRaduis = BorderRadius.all(Radius.circular(10));
const _kDefaultPadding = EdgeInsets.all(5);

class CustomButton extends StatelessWidget {
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
  final double? height;

  /// Creates a button with an elevated style.
  const CustomButton({
    super.key,
    this.onPressed,
    this.expanded = false,
    this.label,
    this.icon,
    this.broderRadius = _kDefaultRaduis,
    this.width,
    this.padding = _kDefaultPadding,
    this.labelStyle,
    this.borderSide = BorderSide.none,
    this.height,
  }) : _variant = _ButtonVariant.elevated,
       assert(
         label != null || icon != null,
         'Either label or icon must be provided',
       );

  /// Creates a button with a filled style.
  const CustomButton.filled({
    super.key,
    this.onPressed,
    this.expanded = false,
    this.label,
    this.icon,
    this.broderRadius = _kDefaultRaduis,
    this.width,
    this.padding = _kDefaultPadding,
    this.labelStyle,
    this.borderSide = BorderSide.none,
    this.height,
  }) : _variant = _ButtonVariant.filled,
       assert(
         label != null || icon != null,
         'Either label or icon must be provided',
       );

  /// Creates a button with a tonal style.
  const CustomButton.tonal({
    super.key,
    this.onPressed,
    this.expanded = false,
    this.label,
    this.icon,
    this.broderRadius = _kDefaultRaduis,
    this.width,
    this.padding = _kDefaultPadding,
    this.labelStyle,
    this.borderSide = BorderSide.none,
    this.height,
  }) : _variant = _ButtonVariant.tonal,
       assert(
         label != null || icon != null,
         'Either label or icon must be provided',
       );
  @Deprecated('Use icon in Custombutton')
  /// Creates a button with an icon.
  const CustomButton.icon({
    super.key,
    required this.onPressed,
    this.expanded = false,
    this.label,
    required this.icon,
    this.broderRadius = _kDefaultRaduis,
    this.width,
    this.padding = _kDefaultPadding,
    this.labelStyle,
    this.borderSide = BorderSide.none,
    this.height,
  }) : _variant = _ButtonVariant.icon;
  @Deprecated('Use tonal constructor')
  /// Creates a button with a tonal icon.
  const CustomButton.tonalIcon({
    super.key,
    required this.onPressed,
    this.expanded = false,
    this.label,
    required this.icon,
    this.broderRadius = _kDefaultRaduis,
    this.width,
    this.padding = _kDefaultPadding,
    this.labelStyle,
    this.borderSide = BorderSide.none,
    this.height,
  }) : _variant = _ButtonVariant.tonalIcon;

  /// Creates a button with an outlined style.
  const CustomButton.outLined({
    super.key,
    required this.onPressed,
    this.expanded = false,
    this.label,
    this.icon,
    this.broderRadius = _kDefaultRaduis,
    this.width,
    this.padding = _kDefaultPadding,
    this.labelStyle,
    this.borderSide = BorderSide.none,
    this.height,
  }) : _variant = _ButtonVariant.outLined,
       assert(
         label != null || icon != null,
         'Either label or icon must be provided',
       );

  @override
  Widget build(BuildContext context) {
    return ExpandButton(button: _getButton(), expanded: expanded);
  }

  Widget _getButton() {
    switch (_variant) {
      case _ButtonVariant.filled:
        return _filledButton();
      case _ButtonVariant.tonal:
        return _filledButtonTonal();
      // case _ButtonVariant.icon:
      //   return _filledButtonIcon();
      // case _ButtonVariant.tonalIcon:
      //   return _filledButtonTonalIcon();
      case _ButtonVariant.outLined:
        return _outlinedButton();
      default:
        return _elevatedButton();
    }
  }

  ButtonStyle get _buttonStyle {
    return FilledButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: broderRadius,
        side: borderSide,
      ),

      minimumSize: Size.zero,
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      fixedSize: _fixedSize,
      padding: padding,
      // iconColor: Color(0xFFFFFFFF),
    );
  }

  Size? get _fixedSize {
    if (width != null && height != null) {
      return Size(width!, height!);
    } else if (width != null) {
      return Size.fromWidth(width!);
    } else if (height != null) {
      return Size.fromHeight(height!);
    }

    return null;
  }

  // elevated button
  Widget _elevatedButton() {
    return _isLabelWithIcon
        ? ElevatedButton.icon(
          onPressed: onPressed,
          style: _buttonStyle,
          icon: icon!,
          label: Text(label!),
        )
        : ElevatedButton(
          onPressed: onPressed,
          style: _buttonStyle,
          child: icon ?? Text(label ?? ''),
        );
  }

  /// filled button
  Widget _filledButton() {
    return _isLabelWithIcon
        ? FilledButton.icon(
          onPressed: onPressed,
          style: _buttonStyle,
          icon: icon,
          label: Text(label ?? ''),
        )
        : FilledButton(
          onPressed: onPressed,
          style: _buttonStyle,
          child: icon ?? Text(label ?? ''),
        );
  }

  /// tonal button
  Widget _filledButtonTonal() {
    return _isLabelWithIcon
        ? FilledButton.tonalIcon(
          onPressed: onPressed,
          style: _buttonStyle,
          icon: icon,
          label: Text(label ?? ''),
        )
        : FilledButton.tonal(
          onPressed: onPressed,
          style: _buttonStyle,
          child: icon ?? Text(label ?? ''),
        );
  }

  // Widget _filledButtonIcon() {
  //   return label == null
  //       ? FilledButton(
  //         onPressed: onPressed,
  //         style: _buttonStyle,
  //         child: icon!,
  //         // icon: icon!,
  //       )
  //       : FilledButton.icon(
  //         onPressed: onPressed,
  //         label: Text(label!),
  //         icon: icon,
  //         style: _buttonStyle,
  //       );
  // }

  // Widget _filledButtonTonalIcon() {
  //   return label == null
  //       ? FilledButton.tonal(
  //         onPressed: onPressed,
  //         style: _buttonStyle,
  //         child: icon,
  //       )
  //       : FilledButton.tonalIcon(
  //         onPressed: onPressed,
  //         label: Text(label!),
  //         icon: icon ?? const SizedBox.shrink(),
  //         style: _buttonStyle,
  //       );
  // }

  // outlined button
  Widget _outlinedButton() {
    if (_isLabelWithIcon) {
      return OutlinedButton.icon(
        onPressed: onPressed,
        style: _buttonStyle,
        icon: icon!,
        label: Text(label!),
      );
    }
    return OutlinedButton(
      onPressed: onPressed,
      style: _buttonStyle,
      child: icon ?? Text(label ?? ''),
    );
  }

  bool get _isLabelWithIcon => label != null && icon != null;
}

/// Expand The button to fill the available width
class ExpandButton extends StatelessWidget {
  final bool expanded;
  final Widget button;
  const ExpandButton({super.key, this.expanded = false, required this.button});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,

      children: [
        Flexible(flex: expanded ? 1 : 0, fit: FlexFit.tight, child: button),
      ],
    );
  }
}

// /// Common button style
// ButtonStyle get _buttonStyle {
//   return ButtonStyle(
//     minimumSize: WidgetStatePropertyAll(Size.zero),
//     tapTargetSize: MaterialTapTargetSize.shrinkWrap,
//     padding: WidgetStatePropertyAll(_kDefaultPadding),
//     shape: WidgetStateProperty.resolveWith(
//       (_) => RoundedRectangleBorder(
//         borderRadius: _kDefaultRaduis,
//         side: BorderSide.none,
//       ),
//     ),
//   );
// }

// /// Custom Icon Button
// class CustomIconButton extends StatelessWidget {
//   const CustomIconButton({
//     super.key,
//     required this.onPressed,
//     required this.icon,
//     this.expanded = false,
//     this.buttonVariant,
//     this.broderRadius = _kDefaultRaduis,
//     this.backgroundColor,
//     this.size,
//     this.forgroundColor,
//     this.iconSize,
//   });
//   final VoidCallback? onPressed;
//   final Widget icon;
//   final bool expanded;
//   final BorderRadiusGeometry broderRadius;
//   final Color? backgroundColor, forgroundColor;
//   final Size? size;
//   final double? iconSize;
//   final _ButtonVariant? buttonVariant;

//   @override
//   Widget build(BuildContext context) {
//     return ExpandButton(expanded: expanded, button: _buildButton(context));
//   }

//   //
//   Widget _buildButton(BuildContext context) {
//     switch (buttonVariant) {
//       case _ButtonVariant.tonal:
//         return IconButton.filledTonal(
//           onPressed: onPressed,
//           icon: icon,
//           style: _getButtonStyle,
//         );
//       // case ButtonVariant.outLined:
//       //   return _outlinedButton();
//       // case ButtonVariant.icon:
//       //   return _iconButton();
//       // case ButtonVariant.tonalIcon:
//       //   return _tonalIconButton();
//       default:
//         return IconButton(
//           onPressed: onPressed,
//           icon: icon,
//           style: _getButtonStyle,
//         );
//     }
//   }

//   ButtonStyle get _getButtonStyle => _buttonStyle.merge(
//     IconButton.styleFrom(
//       backgroundColor: backgroundColor,
//       shape: RoundedRectangleBorder(borderRadius: broderRadius),
//       fixedSize: size,
//       iconSize: iconSize,
//       foregroundColor: forgroundColor,
//     ),
//   );
// }
