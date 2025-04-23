import 'package:flutter/material.dart';
import 'package:store/core/widgets/item_card.dart';
import 'package:store/domain/entities/product_entity.dart';

class ItemsListGridBuilder extends StatelessWidget {
  const ItemsListGridBuilder({
    super.key,
    required this.productsList,
    this.itemHeight = 270,
    this.padding = EdgeInsets.zero,
    this.mainAxisSpacing = 10,
    this.crossAxisSpacing = 10,
    this.physics = const NeverScrollableScrollPhysics(),
  });
  final List<ProductEntity> productsList;
  final double? itemHeight;
  final EdgeInsetsGeometry padding;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final ScrollPhysics? physics;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: GridView.builder(
        shrinkWrap: true,
        physics: physics,
        // Configure the grid layout for the SliverGrid
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          // Maximum width of each grid item
          maxCrossAxisExtent: 210,
          // Aspect ratio of each grid item (width / height)
          childAspectRatio: 2 / 3,
          // Fixed height for each grid item
          mainAxisExtent: itemHeight,
          // Vertical spacing between grid items
          mainAxisSpacing: mainAxisSpacing,
          // Horizontal spacing between grid items
          crossAxisSpacing: crossAxisSpacing,
        ),
        itemCount: productsList.length,
        itemBuilder: (context, index) {
          return ItemCrad(product: productsList[index]);
        },
      ),
    );
  }
}
