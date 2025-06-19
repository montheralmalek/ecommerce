import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:store/core/themes/dimens.dart';
import 'package:store/core/utils/extensions/context_extensions.dart';
import 'package:store/core/widgets/add_to_cart_button.dart';
import 'package:store/core/widgets/item_card.dart';
import 'package:store/domain/domain_models/product.dart';
import 'package:store/presentation/features/product_detail/cubit/product_detail_cubit.dart';
import 'package:store/presentation/features/product_detail/widgets/product_rating_detail_widget.dart';
import 'package:store/widgets/custom_error_widget.dart';
import 'package:store/widgets/expandable_text.dart';

class ProductDetailScreen extends StatelessWidget {
  static const String id = '/product_detail_screen';
  const ProductDetailScreen({super.key, required this.productId});

  final int productId;
  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: Text('Product Details'),
        cupertino:
            (context, platform) => CupertinoNavigationBarData(
              previousPageTitle: 'Back',
              automaticBackgroundVisibility: false,
            ),
      ),

      body: BlocBuilder<ProductDetailCubit, ProductDetailState>(
        builder: (context, state) {
          if (state is ProductDetailInitial) {
            context.read<ProductDetailCubit>().loadProductDetail(productId);
          }
          if (state is ProductDetailError) {
            return CustomErrorWidget(message: state.message);
          }
          final product = state is ProductDetailLoaded ? state.product : null;
          return Skeletonizer(
            enabled: state is ProductDetailLoading,
            child: Column(
              children: [
                Expanded(child: _buildProductDetail(context, product)),
                if (product != null && _isAvailableInStock(product))
                  Card(
                    margin: EdgeInsets.zero,
                    color: context.colorScheme.surface,
                    shape: RoundedRectangleBorder(),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Dimens.of(context).paddingScreenHorizontal,
                        vertical: Dimens.of(context).paddingScreenVertical,
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        child: AddToCartButton(
                          product: product,
                          minimumHeight: 48,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  bool _isAvailableInStock(Product product) {
    // return product.stock > 0;
    return true; // Assuming all products are available in stock for this example
  }

  Widget _buildProductDetail(BuildContext context, [Product? product]) {
    final starRating = [0.6, 0.25, 0.1, 0.05, 0.0];
    return Padding(
      padding: EdgeInsets.only(
        bottom: Dimens.of(context).paddingScreenVertical,
      ),
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(
              height: 250,
              child: Stack(
                alignment: AlignmentDirectional.centerEnd,
                children: [
                  CustomCachedNetworkImage(
                    fit: BoxFit.contain,
                    width: double.infinity,
                    height: 250,
                    imageUrl: product?.imageUrl ?? '',
                  ),
                  Container(
                    color: context.theme.hoverColor,
                    padding: EdgeInsets.all(
                      Dimens.of(context).paddingScreenHorizontal / 2,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton.filledTonal(
                          onPressed: () {},
                          icon: Icon(Icons.favorite_border),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Dimens.of(context).paddingScreenHorizontal,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 10.0,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: Dimens.of(context).paddingScreenVertical / 2,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          product?.brand ?? 'Brand',
                          style: context.textTheme.titleMedium?.copyWith(
                            color: context.theme.hintColor,
                          ),
                        ),
                        BriefRatingWidget(rateValue: 4.4, reviewsCount: 128),
                      ],
                    ),
                  ),

                  //
                  Text(
                    product?.title ?? 'Product Name',
                    style: context.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  //
                  RawChip(
                    label: const Text('Available in stock'),
                    showCheckmark: false,
                    selected: false,
                    selectedColor: context.colorScheme.primary.withAlpha(100),
                    // color: WidgetStateMapper({
                    //   WidgetState.selected: context.colorScheme.primary,
                    // }),
                  ),
                  //
                  Skeleton.unite(
                    borderRadius: BorderRadius.zero,
                    child: SectionWidget(
                      title: PlatformText('Product Description'),
                      child: ExpandableText(
                        product?.description ??
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                      ),
                    ),
                  ),

                  Skeleton.leaf(
                    child: ProductRatingDetailWidget(
                      starRatings: starRating,
                      rateValue: _calculateAverageRating(starRating),
                      reviewsCount: 128,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
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

class SectionWidget extends StatelessWidget {
  const SectionWidget({super.key, this.title, this.child, this.spacing = 10.0});
  final Widget? title;
  final Widget? child;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spacing,
      children: [
        DefaultTextStyle.merge(
          style: context.textTheme.titleLarge,
          child: title ?? SizedBox.shrink(),
        ),
        child ?? SizedBox.shrink(),
      ],
    );
  }
}
