import 'package:flutter/material.dart';
import 'package:store/core/utils/extensions/context_extensions.dart';
import 'package:store/core/widgets/widgets.dart';

class InputQuantity extends StatefulWidget {
  final int initialValue;
  final void Function(int)? onChanged;

  const InputQuantity({super.key, this.initialValue = 1, this.onChanged});

  @override
  State<InputQuantity> createState() => _InputQuantityState();
}

class _InputQuantityState extends State<InputQuantity> {
  late int _value;
  void changeValue(int newValue) {
    if (newValue < 1) return;
    setState(() {
      _value = newValue;
    });

    widget.onChanged?.call(newValue);
  }

  @override
  void initState() {
    _value = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
        side: BorderSide(color: context.colorScheme.primary),
      ),
      clipBehavior: Clip.antiAlias,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomButton.filled(
            broderRadius: BorderRadius.zero,
            icon: const Icon(Icons.remove, size: 20),
            onPressed: () => changeValue(_value - 1),
          ),
          Container(
            constraints: BoxConstraints(minWidth: 30),
            child: Text(
              '$_value',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),

          CustomButton.filled(
            broderRadius: BorderRadius.zero,
            icon: const Icon(Icons.add, size: 20),
            onPressed: () => changeValue(_value + 1),
          ),
        ],
      ),
    );
  }
}
