import 'package:flutter/material.dart';
import 'custom_textfield.dart';

class PasswordTextFormField extends StatefulWidget {
  const PasswordTextFormField({
    super.key,
    this.hinttext,
    this.labeltext,
    this.prefixicon,
    this.controller,
    this.validator,
    this.onsave,
    this.radius = 4,
    this.width,
    this.filled = true,
    this.fillColor,
  });
  final String? hinttext;
  final String? labeltext;
  final Widget? prefixicon;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Function(String?)? onsave;
  final double radius;
  final double? width;
  final bool filled;
  final Color? fillColor;

  @override
  State<PasswordTextFormField> createState() => _PasswordTextFormFieldState();
}

class _PasswordTextFormFieldState extends State<PasswordTextFormField> {
  bool _obscuretext = true;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: CustomTextFormField(
        validator: widget.validator,
        onsave: widget.onsave,
        controller: widget.controller,
        obscureText: _obscuretext,
        labelText: widget.labeltext ?? 'Password',
        hintText: widget.hinttext,
        filled: widget.filled,
        fillColor: widget.fillColor,
        prefixicon: widget.prefixicon ?? const Icon(Icons.lock_outline_rounded),
        suffixicon: IconButton(
          icon: Icon(
            _obscuretext
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
          ),
          onPressed: () {
            setState(() {
              _obscuretext = !_obscuretext;
            });
          },
        ),
      ),
    );
  }
}
