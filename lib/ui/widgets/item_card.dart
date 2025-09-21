import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:store/core/themes/app_colors.dart';
import 'package:store/core/utils/extensions/context_extensions.dart';
import 'package:store/core/widgets/widgets.dart';
import 'package:store/ui/widgets/brief_rating_widget.dart';
import 'package:store/routing/routes.dart';
import 'package:store/ui/widgets/add_to_cart_button.dart';
import 'package:store/domain/entities/product.dart';
import 'package:store/ui/widgets/price_widget.dart';
import 'package:store/ui/widgets/product_image_widget.dart';

class ItemCrad extends StatelessWidget {
  const ItemCrad({
    super.key,
    required this.product,
    this.onTap,
    this.radius = 8,
    this.margin,
  }) : height = null,
       width = null;
  const ItemCrad.customSize({
    super.key,
    required this.product,
    this.onTap,
    this.height = 200,
    this.width = 150,
    this.radius = 8,
    this.margin,
  });
  final Product product;
  final double radius;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
          onTap ??
          () => context.pushNamed(
            AppRoutes.productDetails,
            pathParameters: {'id': product.id.toString()},
          ),
      child: SizedBox(
        height: height,
        width: width,
        child: Card.outlined(
          elevation: 7,
          clipBehavior: Clip.antiAlias,
          child: Column(
            spacing: 5,
            children: [
              //---------- Start item image ------------
              Expanded(
                child: Stack(
                  clipBehavior: Clip.none,
                  fit: StackFit.expand,
                  children: [
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          // backgroundBlendMode: BlendMode.multiply,
                        ),
                        child: ProductImageWidget(
                          imageUrl: product.imageUrl,
                          // radius: radius,
                        ),
                      ),
                    ),
                    Positioned.directional(
                      textDirection: context.textDirection,
                      bottom: 8,
                      end: 10,
                      child: CustomButton(
                        onPressed: () => addToCartDialog(context, product, 1),
                        icon: Icon(context.appIcons.addToCart),
                      ),
                    ),
                    if (product.isNew)
                      Positioned.directional(
                        textDirection: context.textDirection,
                        top: 5,
                        start: 5,
                        child: Badge(
                          label: Text('New'),
                          padding: EdgeInsets.symmetric(horizontal: 5),
                        ),
                      ),
                  ],
                ),
              ),
              //---------- End item image ------------------------
              //--------------------------------------------------
              //---------- Start item body -----------------------
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  // color: Colors.grey.shade100,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(radius),
                    bottomRight: Radius.circular(radius),
                    // topLeft: Radius.circular(radius),
                    // topRight: Radius.circular(radius),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (product.brand != null)
                      Text(
                        product.brand!,
                        style: TextStyle(color: context.theme.hintColor),
                      ),
                    Text(
                      product.title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    PriceWidget.small(product: product),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //** ------- Add To Cart Button ----------- */
                        // PlatformIconButton(
                        //   icon: Icon(context.platformIcons.favoriteOutline,),
                        //   padding: EdgeInsets.zero,
                        // ),
                        // AddToCartButton(product: product, expanded: false),
                        if (product.hasRating)
                          BriefRatingWidget(
                            rateValue: product.rateValue ?? 0.0,
                          ),
                      ],
                    ),

                    // AddToCartButton(product: product, label: 'Add To Cart'),
                  ],
                ),
              ),
              //---------- End item body ------------
            ],
          ),
        ),
      ),
    );
  }
}
