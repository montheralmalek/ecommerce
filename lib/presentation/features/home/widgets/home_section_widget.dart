import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:store/core/themes/dimens.dart';
import 'package:store/core/widgets/horizontal_item_list_view_builder.dart';
import 'package:store/core/widgets/item_card.dart';
import 'package:store/core/widgets/items_list_sliver_grid_builder.dart';
import 'package:store/domain/domain_models/catgory.dart';
import 'package:store/domain/domain_models/section.dart';
import 'package:store/presentation/features/home/widgets/banner_slider.dart';
import 'package:store/presentation/features/product/views/product_detail_screen.dart';

class HomeSectionWidget extends StatelessWidget {
  const HomeSectionWidget({
    super.key,
    required this.homeSection,
    this.title,
    this.actionText,
    this.onPressedAction,
    this.child,
    this.isLoading = false,
    this.padding = const EdgeInsets.symmetric(
      horizontal: Dimens.paddingHorizontal,
      vertical: Dimens.p4,
    ),
  });
  // final HomeSectionEntity section;
  final String? title;
  final String? actionText;
  final VoidCallback? onPressedAction;
  final Widget? child;
  final bool isLoading;
  final HomeSectionI homeSection;
  final EdgeInsetsGeometry padding;
  @override
  Widget build(BuildContext context) {
    return Skeletonizer(enabled: isLoading, child: _buildSection(context));
  }

  PlatformTextButton? _getTrailing(BuildContext context) {
    return homeSection.hasAction
        ? PlatformTextButton(
          padding: EdgeInsets.zero,
          onPressed: () {},
          child: Text(
            homeSection.actionText!,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        )
        : null;
  }

  Text? _getTitle(BuildContext context) {
    return homeSection.title != null
        ? Text(title!, style: Theme.of(context).textTheme.titleMedium)
        : null;
  }

  Widget _buildSection(BuildContext context) {
    switch (homeSection) {
      case BannerSliderSection _:
        return SectionTileWidget(
          padding: EdgeInsets.zero,
          title: _getTitle(context),
          trailing: _getTrailing(context),
          child: BannerSliderWidget(
            isLoading: isLoading,
            slides: (homeSection as BannerSliderSection).data,
          ),
        );
      case ItemsGridSection _:
        return SectionTileWidget(
          padding: padding,
          title: _getTitle(context),
          trailing: _getTrailing(context),
          child: ItemsListGridBuilder(
            productsList: (homeSection as ItemsGridSection).data,
          ),
        );
      case HorizontalItemsSection _:
        return SectionTileWidget(
          padding: padding,
          title: _getTitle(context),
          trailing: _getTrailing(context),
          child: ItemListViewHorizontalBuilder(
            products: (homeSection as HorizontalItemsSection).data,
          ),
        );
      case HorizontalCategoriesSection _:
        return SectionTileWidget(
          padding: padding,
          title: _getTitle(context),
          trailing: _getTrailing(context),
          child: CategoriesListViewHorizontal(
            categories: (homeSection as HorizontalCategoriesSection).data,
          ),
        );
      // case HOMESECTIONTYPE.horizontalCategories:
      //   return const SizedBox.shrink();
      // case HOMESECTIONTYPE.categoriesGrid:
      //   return const SizedBox.shrink();
      default:
        return const SizedBox.shrink();
    }
  }
}

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
