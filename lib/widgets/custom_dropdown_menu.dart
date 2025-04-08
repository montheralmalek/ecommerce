import 'package:flutter/material.dart';

class CustomDropdownMenu<Object> extends StatelessWidget {
  const CustomDropdownMenu({
    super.key,
    this.label,
    this.width,
    this.radius = 30,
    this.controller,
    this.onSelected,
    required this.dropdownMenuEntries,
    this.contentPadding,
  });

  //final GroupControllerImp controller;
  final Widget? label;
  final double? width;
  final double radius;
  final TextEditingController? controller;
  final Function(Object?)? onSelected;
  final List<DropdownMenuEntry<Object>> dropdownMenuEntries;
  final EdgeInsetsGeometry? contentPadding;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      label: label,
      width: width,
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: contentPadding,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(radius))),
      ),
      controller: controller,
      onSelected: onSelected,
      dropdownMenuEntries: dropdownMenuEntries,
    );
  }
}
