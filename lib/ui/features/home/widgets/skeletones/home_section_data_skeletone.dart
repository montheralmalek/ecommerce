import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:store/ui/widgets/horizontal_item_list_view_builder.dart';
import 'package:store/ui/widgets/items_list_sliver_grid_builder.dart';
import 'package:store/domain/entities/ad_banner.dart';
import 'package:store/domain/entities/home_section.dart';
import 'package:store/domain/entities/product.dart';
import 'package:store/ui/features/home/cubits/get_home_section_data_cubit/get_home_section_data_cubit.dart';
import 'package:store/ui/features/home/widgets/banner_slider.dart';

extension HomeSectionSkeletonX<T> on GetHomeSectionDataState {
  /// Returns the number of skeleton items to show for this section type.
  Widget skeletonOf(HomeSectionType type) {
    switch (type) {
      case HomeSectionType.bannerSlider:
        return Skeletonizer(
          enabled: true,
          child: BannerSliderWidget(slides: [AdBanner.onLoading()]),
        );
      case HomeSectionType.gridItems:
        return ItemsListGridBuilder(productsList: []);
      case HomeSectionType.horizontalItems:
        return ItemListViewHorizontalBuilder(
          isLoading: true,
          products: [Product.loading(), Product.loading(), Product.loading()],
        );
      case HomeSectionType.horizontalCategories:
        return Skeletonizer(
          enabled: true,
          child: Container(
            color: Colors.grey,
            width: double.infinity,
            height: 100,
          ),
        );
      case HomeSectionType.gridCategories:
        return SizedBox.shrink();
      case HomeSectionType.unknown:
        return SizedBox.shrink();

      default:
        return SizedBox.shrink();
    }
  }
}
