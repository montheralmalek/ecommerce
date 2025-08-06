import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:store/core/themes/dimens.dart';
import 'package:store/core/utils/extensions/context_extensions.dart';
import 'package:store/core/widgets/add_to_cart_button.dart';
import 'package:store/core/widgets/horizontal_item_list_view_builder.dart';
import 'package:store/core/widgets/item_card.dart';
import 'package:store/domain/entities/product.dart';
import 'package:store/presentation/features/product/cubits/getProductByIdCubit/product_detail_cubit.dart';
import 'package:store/presentation/features/product/widgets/product_rating_detail_widget.dart';
import 'package:store/widgets/custom_carousel_slider.dart';
import 'package:store/widgets/custom_error_widget.dart';
import 'package:store/widgets/expandable_text.dart';

class ProductDetailScreen extends StatelessWidget {
  static const String id = '/product_detail_screen';
  const ProductDetailScreen({super.key, required this.productId});

  final int productId;
  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: _getPlatformAppBar(),

      body: BlocBuilder<ProductDetailCubit, ProductDetailState>(
        builder: (context, state) {
          if (state is ProductDetailInitial) {
            context.read<ProductDetailCubit>().loadProductDetail(productId);
          }
          if (state is ProductDetailError) {
            return CustomErrorWidget(message: state.message);
          }
          final product = state.product;
          return Skeletonizer(
            enabled: state is ProductDetailLoading,
            child: Column(
              children: [
                Expanded(child: _buildProductDetail(context, product)),
                if (_isAvailableInStock(product))
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

  PlatformAppBar _getPlatformAppBar() {
    return PlatformAppBar(
      title: Text('Product Details'),
      cupertino:
          (context, platform) => CupertinoNavigationBarData(
            previousPageTitle: 'Back',
            automaticBackgroundVisibility: false,
          ),
    );
  }

  bool _isAvailableInStock(Product product) {
    // return product.stock > 0;
    return true; // Assuming all products are available in stock for this example
  }

  Widget _buildProductDetail(BuildContext context, [Product? product]) {
    final starRating = [0.6, 0.25, 0.1, 0.05, 0.0];
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        _getProductImage(product?.imageUrl ?? ''),
        SliverToBoxAdapter(
          child: Padding(
            padding: _padding,
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
        ),

        SliverPadding(
          padding: _padding,
          sliver: SliverToBoxAdapter(
            child: Text(
              product?.title ?? 'Product Name',
              style: context.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        //
        SliverPadding(
          padding: _padding,
          sliver: SliverToBoxAdapter(
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: RawChip(
                label: const Text('Available in stock'),
                showCheckmark: false,
                selected: false,
                selectedColor: context.colorScheme.primary.withAlpha(100),
                // color: WidgetStateMapper({
                //   WidgetState.selected: context.colorScheme.primary,
                // }),
              ),
            ),
          ),
        ),

        SliverToBoxAdapter(
          child: Skeleton.unite(
            borderRadius: BorderRadius.zero,
            child: SectionTileWidget(
              contentPadding: _padding,
              title: PlatformText('Price'),
              content: Text(
                product?.price != null
                    ? '\$${product!.price.toStringAsFixed(2)}'
                    : '\$0.00',
                style: context.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(child: Divider()),

        SliverToBoxAdapter(
          child: Skeleton.unite(
            borderRadius: BorderRadius.zero,
            child: SectionTileWidget(
              contentPadding: _padding,
              title: PlatformText('Product Description'),
              content: ExpandableText(
                product?.description ??
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
              ),
            ),
          ),
        ),

        SliverFloatingHeader(child: Divider()),
        SliverToBoxAdapter(
          child: Skeleton.leaf(
            child: SectionTileWidget(
              contentPadding: _padding,
              title: PlatformText('Reviews'),
              content: ProductRatingDetailWidget(
                starRatings: starRating,
                rateValue: _calculateAverageRating(starRating),
                reviewsCount: 128,
              ),
            ),
          ),
        ),
        SliverFloatingHeader(child: Divider()),
        SliverToBoxAdapter(
          child: SectionTileWidget(
            contentPadding: _padding,
            title: PlatformText('Related Products'),
            content: ItemListViewHorizontalBuilder(
              products:
                  product != null ? [product, product, product, product] : [],
            ),
          ),
        ),
      ],
    );
  }

  SliverToBoxAdapter _getProductImage(String imageUrl) {
    return SliverToBoxAdapter(
      child: SizedBox(
        // height: 250,
        child: CustomCarouselSlider.builder(
          itemCount: 3,
          autoPlay: true,
          itemBuilder: (context, index, realIndex) {
            return CustomCachedNetworkImage(
              fit: BoxFit.contain,
              width: double.infinity,
              imageUrl: imageUrl,
            );
          },
        ),
        // Stack(
        //   alignment: AlignmentDirectional.bottomEnd,
        //   children: [
        // CustomCachedNetworkImage(
        //   fit: BoxFit.contain,
        //   width: double.infinity,
        //   height: 250,
        //   imageUrl: imageUrl,
        // ),
        //     Container(
        //       // color: context.theme.hoverColor,
        //       padding: const EdgeInsets.all(Dimens.p4),
        //       child: Row(
        //         mainAxisAlignment: MainAxisAlignment.end,
        //         children: [
        //           IconButton.filledTonal(
        //             onPressed: () {},
        //             icon: Icon(Icons.favorite_border),
        //           ),
        //         ],
        //       ),
        //     ),
        //   ],
        // ),
      ),
    );
  }

  EdgeInsets get _padding => EdgeInsets.symmetric(
    horizontal: Dimens.paddingHorizontal,
    vertical: Dimens.p12,
  );

  double _calculateAverageRating(List<double> ratings) {
    double starRating = 0.0;
    for (int i = 0; i < ratings.length; i++) {
      var rating = ratings[i];
      starRating += rating * (ratings.length - i);
    }
    return starRating;
  }
}

class SectionTileWidget extends StatelessWidget {
  const SectionTileWidget({
    super.key,
    this.title,
    this.content,
    this.spacing = 10.0,
    this.trailing,
    this.leading,
    this.headerPadding = EdgeInsets.zero,
    this.contentPadding = EdgeInsets.zero,
  });
  final Widget? title;
  final Widget? trailing;
  final Widget? leading;
  final Widget? content;
  final double spacing;
  final EdgeInsetsGeometry headerPadding;
  final EdgeInsetsGeometry contentPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: contentPadding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_hasHeader) _buildHeader(context),
          Offstage(offstage: !_hasHeader, child: SizedBox(height: spacing)),
          content ?? SizedBox.shrink(),
        ],
      ),
    );
  }

  bool get _hasHeader => title != null || trailing != null;
  bool get _hasFooter => false;
  Widget _buildHeader(BuildContext context) {
    return DefaultTextStyle.merge(
      style: context.textTheme.titleLarge,
      child: Padding(
        padding: headerPadding,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (leading != null) leading!,
            if (title != null) title!,
            if (trailing != null) trailing!,
          ],
        ),
      ),
    );
  }

  // _buildFooter(BuildContext context) {}
}
// void onPopInvokedWithResult(didPop, result) async {
//         if (didPop) {
//           return;
//         }
//      var   canPop = await showPlatformDialog<bool>(
//           context: context,
//           builder: (context) {
//             return PlatformAlertDialog(
//               title: Text('Confirm Exit'),
//               content: Text(
//                 'You are leaving the Product Detail screen. Do you want to continue?',
//               ),
//               actions: [
//                 PlatformDialogAction(
//                   onPressed: () => context.pop<bool>(true),
//                   child: Text('OK'),
//                 ),
//                 PlatformDialogAction(
//                   onPressed: () => context.pop(false),
//                   child: Text('Cancel'),
//                 ),
//               ],
//             );
//           },
//         ).then((value) => value ?? false);
//         if (canPop) {
//           context.pop();
//         }
//       },