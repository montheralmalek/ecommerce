import 'package:flutter/material.dart';

class CustomDropdownButtonFormField<Null> extends StatelessWidget {
  const CustomDropdownButtonFormField({
    super.key,
    this.hint,
    this.items,
    this.validator,
    this.onChanged,
    this.isExpanded = true,
    this.menuItemsRadius = 8,
    this.buttonRadius = 8,
    this.value,
    this.height,
    this.width,
    this.enabled = true,
    this.filled = true,
    this.label,
    this.focusNode,
    this.nextFocuNode,
    this.fillColor,
  });

  //final GroupControllerImp controller;
  final bool isExpanded;
  final double menuItemsRadius;
  final double buttonRadius;
  final Widget? hint, label;
  final List<DropdownMenuItem<Null>>? items;
  final String? Function(Null?)? validator;
  final void Function(Null?)? onChanged;
  final Null? value;
  final double? height;
  final double? width;
  final bool enabled, filled;
  final FocusNode? focusNode, nextFocuNode;
  final Color? fillColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: DropdownButtonHideUnderline(
        child: DropdownButtonFormField<Null>(
          focusNode: focusNode,
          isExpanded: isExpanded,
          borderRadius: BorderRadius.all(Radius.circular(menuItemsRadius)),
          decoration: InputDecoration(
            label: label,
            filled: filled,
            fillColor: fillColor ?? Theme.of(context).cardColor,
            enabled: enabled,
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(buttonRadius))),
          ),
          hint: hint,
          validator: validator,
          onChanged: enabled
              ? (val) {
                  onChanged?.call(val);
                  onChanged;
                  nextFocuNode?.requestFocus();
                }
              : null,
          value: value,
          items: items,
        ),
      ),
    );
  }
}
