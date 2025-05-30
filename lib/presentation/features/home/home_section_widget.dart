import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:store/core/widgets/horizontal_item_list_view_builder.dart';
import 'package:store/core/widgets/items_list_sliver_grid_builder.dart';
import 'package:store/domain/domain_models/banner.dart';
import 'package:store/domain/domain_models/section.dart';
import 'package:store/domain/domain_models/product.dart';
import 'package:store/presentation/features/home/banner_slider.dart';

class HomeSectionWidget<T> extends StatelessWidget {
  const HomeSectionWidget({
    super.key,
    required this.section,
    required this.title,
    this.actionText,
    this.onPressedAction,
    this.child,
    this.isLoading = false,
  });
  // final HomeSectionEntity section;
  final String title;
  final String? actionText;
  final VoidCallback? onPressedAction;
  final Widget? child;
  final bool isLoading;
  final Section<T> section;
  @override
  Widget build(BuildContext context) {
    return Skeletonizer(enabled: isLoading, child: _buildSection(context));
  }

  Widget _buildSection(BuildContext context) {
    switch (section.type) {
      case HOMESECTIONTYPE.bannerSlider:
        return BannerSlider(
          isLoading: isLoading,
          slides: section.data as List<BannerModel>,
        );
      case HOMESECTIONTYPE.itemsGrid:
        return ItemsListGridBuilder(
          productsList: section.data as List<Product>,
        );
      case HOMESECTIONTYPE.horizontalItems:
        return ItemListViewHorizontalBuilder(
          title: Text(section.title),
          trailing:
              section.hasAction
                  ? PlatformTextButton(
                    onPressed: () {},
                    child: Text(section.actionText!),
                  )
                  : null,
          products: section.data as List<Product>,
        );
      case HOMESECTIONTYPE.horizontalCategories:
        return const SizedBox.shrink();
      case HOMESECTIONTYPE.categoriesGrid:
        return const SizedBox.shrink();
      default:
        return const SizedBox.shrink();
    }
  }
}
