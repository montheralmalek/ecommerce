import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:store/core/utils/extensions/context_extensions.dart';
import 'package:store/ui/widgets/brief_rating_widget.dart';
import 'package:store/ui/cubits/getProductByIdCubit/get_product_by_id_cubit.dart';
import 'package:store/routing/routes.dart';
import 'package:store/domain/entities/product.dart';
import 'package:store/ui/widgets/price_widget.dart';
import 'package:store/ui/widgets/product_image_widget.dart';

class ItemCradHorizontal extends StatelessWidget {
  const ItemCradHorizontal({
    super.key,
    required this.product,
    this.onTap,
    this.radius = 8,
    this.margin,
    this.showAddToCartButton = true,
  }) : height = null,
       width = null;
  const ItemCradHorizontal.customSize({
    super.key,
    required this.product,
    this.onTap,
    this.height = 200,
    this.width = 150,
    this.radius = 8,
    this.margin,
    this.showAddToCartButton = true,
  });
  final Product product;
  final double radius;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;
  final bool showAddToCartButton;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:
          onTap ??
          () {
            context.read<GetProductByIdCubit>().loadProductDetail(product.id);
            context.pushNamed(
              AppRoutes.productDetails,
              pathParameters: {'id': product.id.toString()},
            );
          },
      child: Container(
        clipBehavior: Clip.antiAlias,
        height: height,
        // width: width,
        margin: margin,
        // padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        decoration: BoxDecoration(
          color: context.theme.cardColor,
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(width: 0.5, color: context.colorScheme.outline),
        ),
        child: Row(
          spacing: 5,
          children: [
            //---------- Start item image ------------
            Expanded(
              child: Stack(
                children: [
                  Positioned(
                    child: ProductImageWidget(imageUrl: product.imageUrl),
                  ),
                ],
              ),
            ),
            //---------- End item image ------------------------
            //--------------------------------------------------
            //---------- Start item body -----------------------
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.all(5),

                child: Column(
                  spacing: 5,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      product.title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    PriceWidget(product: product),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //** ------- Add To Cart Button ----------- */
                        // PlatformIconButton(
                        //   icon: Icon(context.platformIcons.favoriteOutline,),
                        //   padding: EdgeInsets.zero,
                        // ),
                        RawChip(
                          label: const Text('Available in stock'),
                          showCheckmark: false,
                          selected: product.isAvailableInStock,
                          selectedColor: context.colorScheme.primary.withAlpha(
                            100,
                          ),
                          // color: WidgetStateMapper({
                          //   WidgetState.selected: context.colorScheme.primary,
                          // }),
                        ),
                        // if (showAddToCartButton)
                        //   AddToCartButton(product: product, expanded: false),
                        if (product.hasRating)
                          BriefRatingWidget(rateValue: product.rateValue!),
                      ],
                    ),
                    // AddToCartButton(product: product, label: 'Add To Cart'),
                  ],
                ),
              ),
            ),
            //---------- End item body ------------
          ],
        ),
      ),
    );
  }
}
