import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:store/core/config/dependency_injection.dart';
import 'package:store/ui/widgets/horizontal_item_list_view_builder.dart';
import 'package:store/domain/entities/ad_banner.dart';
import 'package:store/domain/entities/home_section.dart';
import 'package:store/domain/entities/product.dart';
import 'package:store/domain/use_cases/get_banners_use_case.dart';
import 'package:store/domain/use_cases/get_section_products_use_case.dart';
import 'package:store/ui/features/home/cubits/get_home_section_data_cubit/get_home_section_data_cubit.dart';
import 'package:store/ui/features/home/widgets/banner_slider.dart';
import 'package:store/ui/features/home/widgets/skeletones/home_section_data_skeletone.dart';
import 'package:store/ui/features/product/widgets/section_tile_widget.dart';
import 'package:store/core/widgets/custom_error_widget.dart';

class HomeSectionItem extends StatefulWidget {
  const HomeSectionItem({super.key, required this.section});
  final HomeSection section;

  @override
  State<HomeSectionItem> createState() => _HomeSectionItemState();
}

class _HomeSectionItemState extends State<HomeSectionItem>
    with AutomaticKeepAliveClientMixin {
  late final GetHomeSectionDataCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = GetHomeSectionDataCubit(
      section: widget.section,
      bannersUseCase: getIt<GetBannersUseCase>(),
      getSectionProductsUseCase: getIt<GetSectionProductsUseCase>(),
    );
  }

  @override
  void dispose() {
    _cubit.close(); // Explicit disposal
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SectionTileWidget(
      title: _getTitle(context),
      trailing: _getTrailing(context),
      content: _getContent(),
    );
  }

  BlocProvider<GetHomeSectionDataCubit> _getContent() {
    return BlocProvider.value(value: _cubit, child: const _HSecContent());
  }

  PlatformTextButton? _getTrailing(BuildContext context) {
    return widget.section.hasAction
        ? PlatformTextButton(
          padding: EdgeInsets.zero,
          onPressed: () {},
          child: Text(
            widget.section.actionText!,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        )
        : null;
  }

  Text? _getTitle(BuildContext context) {
    return widget.section.title != null
        ? Text(
          widget.section.title!,
          style: Theme.of(context).textTheme.titleMedium,
        )
        : null;
  }
}

class _HSecContent extends StatelessWidget {
  const _HSecContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetHomeSectionDataCubit, GetHomeSectionDataState>(
      builder: (context, state) {
        // Handle different states
        if (state is GetHomeSectionDataInitial) {
          return SizedBox.shrink();
        }
        if (state is GetHomeSectionDataError) {
          return CustomErrorWidget(message: state.message);
        }
        if (state is GetHomeSectionDataLoaded) {
          final section = state.section;
          return _buildSectionContent(section.type, section.data);
        }
        return state.skeletonOf(
          context.read<GetHomeSectionDataCubit>().section.type,
        );
      },
    );
  }

  Widget _buildSectionContent(HomeSectionType sectionType, dynamic data) {
    switch (sectionType) {
      case HomeSectionType.bannerSlider:
        return _buildBannerSlider(data);
      case HomeSectionType.gridItems:
        return _buildGridItemsSection();
      case HomeSectionType.horizontalItems:
        return _buildHorizontalItemsSection(data);
      case HomeSectionType.horizontalCategories:
        return _buildHorizontalCategoriesSection();

      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildHorizontalCategoriesSection() {
    return SizedBox.shrink();
    // return CategoriesListViewHorizontal(categories: section.data ?? []);
  }

  Widget _buildHorizontalItemsSection(List<Product> data) {
    return ItemListViewHorizontalBuilder(products: data);
  }

  Widget _buildGridItemsSection() {
    return const SizedBox.shrink();
    // ItemsListGridBuilder(
    //   productsList: (homeSection as ItemsGridSection).data ?? [],
    // );
  }

  Widget _buildBannerSlider(List<AdBanner> data) {
    return BannerSliderWidget(slides: data);
  }
}
