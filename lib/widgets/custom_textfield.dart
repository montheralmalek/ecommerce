import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextInputType? inputType;
  final String? hintText;
  final String labelText;
  final Widget? prefixicon;
  final Widget? suffixicon;
  final int? maxlines;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Function(String?)? onsave;
  final Function(String?)? onFieldSubmitted;
  final Function(String)? onChenged;
  final Function()? onEditingComplete, onTap;
  final String? initialValue;
  final TextAlign textAlign;
  final double radius;
  final bool? filled;
  final Color? fillColor;
  final bool obscureText;
  final FocusNode? focusNode, nextFocusNode;
  final double? width;
  final TextInputAction? textInputAction;
  final bool autofocus, enabled;
  const CustomTextFormField({
    super.key,
    required this.labelText,
    this.hintText,
    this.prefixicon,
    this.suffixicon,
    this.controller,
    this.validator,
    this.onsave,
    this.onFieldSubmitted,
    this.inputType,
    this.maxlines = 1,
    this.initialValue,
    this.textAlign = TextAlign.start,
    this.radius = 10,
    this.filled = true,
    this.obscureText = false,
    this.focusNode,
    this.width,
    this.textInputAction,
    this.nextFocusNode,
    this.autofocus = false,
    this.fillColor,
    this.onChenged,
    this.onEditingComplete,
    this.onTap,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TextFormField(
        autofocus: autofocus,
        textInputAction: textInputAction,
        focusNode: focusNode,
        textAlign: textAlign,
        initialValue: initialValue,
        validator: validator, //
        onSaved: onsave, //
        onFieldSubmitted: nextFocusNode != null
            ? (_) => nextFocusNode!.requestFocus()
            : onFieldSubmitted,
        onChanged: onChenged,
        onEditingComplete: onEditingComplete,
        onTap: onTap,
        keyboardType: inputType,
        controller: controller,
        maxLines: maxlines,
        obscureText: obscureText,
        obscuringCharacter: '*',
        decoration: InputDecoration(
          enabled: enabled,
          filled: filled,
          fillColor: fillColor ?? Theme.of(context).cardColor,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          prefixIcon: prefixicon,
          suffixIcon: suffixicon,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(radius))),
          hintText: hintText,
          label: Text(labelText),
        ),
      ),
    );
  }
}
