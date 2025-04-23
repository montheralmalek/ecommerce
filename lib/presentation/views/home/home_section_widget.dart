import 'package:flutter/material.dart';

class HomeSectionWidget extends StatelessWidget {
  const HomeSectionWidget({
    super.key,
    // required this.section,
    required this.title,
    this.actionText,
    this.onPressedAction,
    required this.child,
  });
  // final HomeSectionEntity section;
  final String title;
  final String? actionText;
  final VoidCallback? onPressedAction;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          title: Text(title),
          trailing:
              actionText != null && actionText!.isNotEmpty
                  ? TextButton(
                    onPressed: onPressedAction,
                    child: Text(actionText!),
                  )
                  : null,
        ),

        child,
      ],
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   switch (section.type) {
  //     case HOMESECTIONTYPE.bannerSlider:
  //       return const SizedBox();
  //     case HOMESECTIONTYPE.itemsGrid:
  //       return ItemsListGridBuilder(
  //         productsList: section.data as List<ProductEntity>,
  //       );
  //     case HOMESECTIONTYPE.horizontalItems:
  //       return HorizontalItemListViewBuilder(
  //         products: section.data as List<ProductEntity>,
  //       );
  //     case HOMESECTIONTYPE.horizontalCategories:
  //       return const SizedBox();
  //     case HOMESECTIONTYPE.categoriesGrid:
  //       return const SizedBox();
  //     default:
  //       return const SizedBox();
  //   }
  // }
}
