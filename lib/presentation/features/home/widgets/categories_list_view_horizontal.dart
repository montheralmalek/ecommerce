import 'package:flutter/material.dart';
import 'package:store/core/widgets/item_card.dart';
import 'package:store/domain/entities/catgory.dart';

class CategoriesListViewHorizontal extends StatelessWidget {
  const CategoriesListViewHorizontal({
    super.key,
    required this.categories,
    this.padding = EdgeInsets.zero,
  });
  final List<Category> categories;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: SizedBox(
        height: 40,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];

            return OutlinedButton.icon(
              onPressed: () {},
              label: Text(category.name),
              icon: CustomCachedNetworkImage(
                radius: 30,
                width: 30,
                height: 30,
                imageUrl:
                    category.imageUrl ??
                    'https://www.sportsbusinessjournal.com/resizer/v2/S5JVZBMWEFHTKXV2XM5DMBADRQ.jpg?auth=68b41114239694229eb5d57ca7da34358df8f748f952f0e017d5aab301f9b929&width=1440&height=711',
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(width: 8.0);
          },
        ),
      ),
    );
  }
}
