import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:store/ui/widgets/item_card.dart';
import 'package:store/domain/entities/product.dart';

class ItemListViewHorizontalBuilder extends StatelessWidget {
  const ItemListViewHorizontalBuilder({
    super.key,
    required this.products,
    this.itemHeight = 300,
    this.itemWidth = 150,
    this.padding = EdgeInsets.zero,
    this.spacing = 10,
    this.isLoading = false,
    this.title,
    this.trailing,
  });

  final List<Product> products;
  final double itemHeight;
  final double itemWidth;
  final EdgeInsetsGeometry padding;
  final double spacing;
  final bool isLoading;
  final Widget? title;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: isLoading,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // if (title != null) PlatformListTile(title: title!, trailing: trailing),
          SizedBox(
            height: itemHeight,
            child: ListView.builder(
              padding: EdgeInsets.only(bottom: 8),
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
          ),
        ],
      ),
    );
  }
}
