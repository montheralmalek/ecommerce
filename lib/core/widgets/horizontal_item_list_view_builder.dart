import 'package:flutter/material.dart';
import 'package:store/core/widgets/item_card.dart';
import 'package:store/domain/entities/product_entity.dart';

class HorizontalItemListViewBuilder extends StatelessWidget {
  const HorizontalItemListViewBuilder({
    super.key,
    required this.products,
    this.itemHeight = 250,
    this.itemWidth = 150,
    this.padding = EdgeInsets.zero,
    this.spacing = 10,
  });

  final List<ProductEntity> products;
  final double itemHeight;
  final double itemWidth;
  final EdgeInsetsGeometry padding;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: itemHeight,
      child: ListView.builder(
        padding: padding,
        itemExtent: itemWidth,
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        itemBuilder: (context, index) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Add spacing between items
              if (index != 0) SizedBox(width: spacing),
              // Item card
              Expanded(child: ItemCrad(product: products[index])),
            ],
          );
        },
      ),
    );
  }
}
