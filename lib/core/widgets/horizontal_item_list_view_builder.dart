import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:store/core/widgets/item_card.dart';
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
          ),
        ],
      ),
    );
  }
}
