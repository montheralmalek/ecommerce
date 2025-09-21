import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:store/core/config/dependency_injection.dart';
import 'package:store/core/themes/app_colors.dart';
import 'package:store/core/themes/dimens.dart';
import 'package:store/core/utils/extensions/context_extensions.dart';
import 'package:store/core/utils/extensions/widget_extensions.dart';
import 'package:store/data/repositories/product_repository/product_repository.dart';
import 'package:store/ui/features/product/cubits/product_detail_cubit/product_detail_cubit.dart';
import 'package:store/ui/widgets/add_to_cart_button.dart';
import 'package:store/ui/widgets/brief_rating_widget.dart';
import 'package:store/ui/widgets/default_cupertino_navigation_bar_data.dart';
import 'package:store/ui/widgets/horizontal_item_list_view_builder.dart';
import 'package:store/domain/entities/product.dart';
import 'package:store/ui/cubits/getProductByIdCubit/get_product_by_id_cubit.dart';
import 'package:store/ui/features/product/widgets/product_image_slider.dart';
import 'package:store/ui/features/product/widgets/product_rating_detail_widget.dart';
import 'package:store/ui/features/product/widgets/section_tile_widget.dart';
import 'package:store/core/widgets/expandable_text.dart';
import 'package:store/core/widgets/sliver_spacer.dart';
import 'package:store/core/widgets/widgets.dart';
import 'package:store/ui/widgets/price_widget.dart';

class ProductDetailScreen extends StatelessWidget {
  static const String id = '/product_detail_screen';
  const ProductDetailScreen({super.key, required this.productId});

  final int productId;
  @override
  Widget build(BuildContext context) {
    return BlocProvider<GetProductByIdCubit>(
      create:
          (context) =>
              GetProductByIdCubit(productRepository: getIt<ProductRepository>())
                ..loadProductDetail(productId),
      child: Builder(
        builder: (context) {
          return PlatformScaffold(
            appBar: _getPlatformAppBar(),
            body: BlocBuilder<GetProductByIdCubit, GetProductByIdState>(
              builder: (context, state) {
                if (state is GetProductByIdInitial) {
                  context.read<GetProductByIdCubit>().loadProductDetail(
                    productId,
                  );
                }
                if (state is GetProductByIdError) {
                  return CustomErrorWidget(message: state.message);
                }
                final product = state.product;
                return Skeletonizer(
                  enabled: state is GetProductByIdLoading,
                  child: _buildProductDetailView(context, product),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildProductDetailView(BuildContext context, Product product) {
    final starRating = [0.6, 0.25, 0.1, 0.05, 0.0];
    return BlocProvider<ProductDetailCubit>(
      create: (context) => ProductDetailCubit(product: product),
      child: Column(
        children: [
          Expanded(
            child: SafeArea(
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  _buildProductImageSlider(context, [
                    product.imageUrl,
                    product.imageUrl,
                  ]),
                  _spacer,

                  _buildPriceWithBriefRating(
                    context,
                    product,
                  ).withScreenPaddingHorizontal(context).toSliver,

                  _spacer,
                  _buildBrand(
                    product.brand ?? 'Brand',
                    context,
                  ).withScreenPaddingHorizontal(context).toSliver,
                  // _spacer,
                  buildTitle(
                    product.title,
                    context,
                  ).withScreenPaddingHorizontal(context).toSliver,
                  _spacer,
                  _buildProductAvailability(
                    context,
                    product.isAvailableInStock,
                  ).withScreenPaddingHorizontal(context).toSliver,
                  // _spacer,
                  // _QuantitySelector().toSliver,
                  _divider,
                  buildDescription(
                    product.description,
                  ).withScreenPaddingHorizontal(context).toSliver,
                  _divider,
                  _buildReviews(
                    starRating,
                    128,
                  ).withScreenPaddingHorizontal(context).toSliver,
                  _divider,
                  _buildRelatedProducts(
                    product,
                  ).withScreenPaddingHorizontal(context).toSliver,
                ],
              ),
            ),
          ),

          ///
          if (product.isAvailableInStock)
            _buildAddToCartButton(context, product),
        ],
      ),
    );
  }

  SliverToBoxAdapter get _divider => SliverToBoxAdapter(child: Divider());

  Widget _buildAddToCartButton(BuildContext context, Product product) {
    return Padding(
      padding: EdgeInsets.only(
        left: Dimens.of(context).paddingLarge,
        right: Dimens.of(context).paddingLarge,
        top: Dimens.of(context).paddingMedium,
        bottom:
            context.mediaQuery.padding.bottom > 0
                ? context.mediaQuery.padding.bottom
                : Dimens.of(context).paddingMedium,
      ),

      child: Container(
        height: 60,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
        clipBehavior: Clip.antiAlias,
        child: Row(
          spacing: 10,
          children: [
            CustomButton.outLined(
              height: double.maxFinite,
              width: 70,
              icon: Icon(context.appIcons.cart, size: 28),
              onPressed: () => addToCartDialog(context, product, 1),
            ),

            Expanded(
              child: CustomButton.filled(
                expanded: true,
                height: double.maxFinite,
                label: 'Add To Shoping Cart',
                icon: Icon(context.appIcons.addToCart, size: 24),
                onPressed: () => addToCartDialog(context, product, 1),
              ),
            ),
          ],
        ),
      ),
    );
  }

  PlatformAppBar _getPlatformAppBar() {
    return PlatformAppBar(
      title: Text('Product Details'),
      cupertino:
          (context, platform) => defaultCupertinoNavigationBarData(context),
    );
  }

  Widget _buildRelatedProducts(Product? product) {
    return SectionTileWidget(
      title: PlatformText('Related Products'),
      content: ItemListViewHorizontalBuilder(
        products: product != null ? List.generate(5, (i) => product) : [],
      ),
    );
  }

  Widget _buildReviews(List<double> starRating, int count) {
    return Skeleton.leaf(
      child: SectionTileWidget(
        title: PlatformText('Reviews'),
        content: ProductRatingDetailWidget(
          starRatings: starRating,
          rateValue: _calculateAverageRating(starRating),
          reviewsCount: count,
        ),
      ),
    );
  }

  Widget buildDescription(String description) {
    return Skeleton.unite(
      borderRadius: BorderRadius.zero,
      child: SectionTileWidget(
        // contentPadding: _padding,
        title: PlatformText('Product Description'),
        content: ExpandableText(description),
      ),
    );
  }

  Widget _buildProductAvailability(
    BuildContext context,
    bool isAvailableInStock,
  ) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: RawChip(
        label: const Text('Available in stock'),
        showCheckmark: false,
        selected: isAvailableInStock,
        selectedColor: context.colorScheme.primary.withAlpha(100),
        // color: WidgetStateMapper({
        //   WidgetState.selected: context.colorScheme.primary,
        // }),
      ),
    );
  }

  Widget buildTitle(String title, BuildContext context) {
    return Text(title, style: context.textTheme.titleLarge?.copyWith());
  }

  Widget _buildBrand(String brand, BuildContext context) {
    return Text(
      brand,
      style: context.textTheme.titleMedium?.copyWith(
        color: context.theme.hintColor,
      ),
    );
  }

  Widget _buildPriceWithBriefRating(BuildContext context, Product product) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        PriceWidget.large(product: product),

        BriefRatingWidget(rateValue: 4.4, reviewsCount: 128),
      ],
    );
  }

  SliverSpacer get _spacer => SliverSpacer.vertical(Dimens.p12);

  ///
  SliverAppBar _buildProductImageSlider(
    BuildContext context,
    List<String> imageUrls,
  ) {
    return SliverAppBar(
      expandedHeight: 350,
      automaticallyImplyLeading: false,
      centerTitle: false,
      backgroundColor: AppColors.surface,
      foregroundColor: AppColors.onSurface,
      flexibleSpace: FlexibleSpaceBar(
        background: ProductImagsSlider(
          imageUrls: imageUrls,
          height: double.infinity,
          disAbleCenter: true,
        ),
      ),
    );
  }

  double _calculateAverageRating(List<double> ratings) {
    double starRating = 0.0;
    for (int i = 0; i < ratings.length; i++) {
      var rating = ratings[i];
      starRating += rating * (ratings.length - i);
    }
    return starRating;
  }
}
