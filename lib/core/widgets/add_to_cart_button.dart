import 'package:flutter/material.dart';
import 'package:store/domain/entities/product.dart';
import 'package:store/widgets/widgets.dart';

class AddToCartButton extends StatelessWidget {
  const AddToCartButton({
    super.key,
    required this.product,
    this.minimumHeight,
    this.iconSize,
    this.backgroundColor,
    this.label,
    this.boxShape = BoxShape.rectangle,
    this.borderRadius,
    this.iconColor,
    this.quantity = 1,
    this.expanded = true,
  });
  final int quantity;
  final Product product;
  final double? minimumHeight, iconSize;
  final Color? backgroundColor, iconColor;
  final BoxShape boxShape;
  final BorderRadiusGeometry? borderRadius;
  final bool expanded;
  final String? label;

  @override
  Widget build(BuildContext context) {
    return CustomFilledButton.tonalIcon(
      expanded: expanded,
      minimumHeight: minimumHeight ?? 0,
      broderRadius: borderRadius ?? BorderRadius.circular(8.0),
      label: label,
      onPressed: () {
        // BlocProvider.of<CartCubit>(context)
        //     .addItem(product: product, quantity: quantity);
        // addToCartDialog(context, product, quantity);
      },
      icon: const Icon(Icons.add_shopping_cart_outlined),
    );
  }
}
