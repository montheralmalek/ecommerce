import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:store/core/themes/app_colors.dart';
import 'package:store/core/utils/extensions/context_extensions.dart';
import 'package:store/core/widgets/custom_carousel_slider.dart';
import 'package:store/core/widgets/widgets.dart';
import 'package:store/ui/widgets/brief_rating_widget.dart';
import 'package:store/routing/routes.dart';
import 'package:store/ui/widgets/add_to_cart_button.dart';
import 'package:store/domain/entities/product/product.dart';
import 'package:store/ui/widgets/price_widget.dart';
import 'package:store/ui/widgets/product_image_widget.dart';

class ItemCrad extends StatelessWidget {
  const ItemCrad({
    super.key,
    required this.product,
    this.onTap,
    this.radius = 8,
    this.margin,
  }); //: height = null,
  //  width = null;
  // const ItemCrad.customSize({
  //   super.key,
  //   required this.product,
  //   this.onTap,
  //   this.height = 200,
  //   this.width = 150,
  //   this.radius = 8,
  //   this.margin,
  // });
  final Product product;
  final double radius;
  // final double? height;
  // final double? width;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:
          onTap ??
          () => context.pushNamed(
            AppRoutes.productDetails,
            pathParameters: {'id': product.id.toString()},
          ),
      child: Card.outlined(
        elevation: 7,
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _buildImageSection(context)),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildProductInfo(context),
                  PricingWidget.small(product: product),
                  _buildFooterSection(context),

                  // AddToCartButton(product: product, label: 'Add To Cart'),
                ],
              ),
            ),
            //---------- End item body ------------
          ],
        ),
      ),
    );
  }

  Stack _buildImageSection(BuildContext context) {
    return Stack(
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
          child: _buildAddToCartButton(context),
        ),
        if (product.isNew)
          Positioned.directional(
            textDirection: context.textDirection,
            top: 5,
            start: 5,
            child: _buildBadge('New', context.colorScheme.error),
          ),
      ],
    );
  }

  CustomButton _buildAddToCartButton(BuildContext context) {
    return CustomButton(
      onPressed: () => addToCartDialog(context, product, 1),
      icon: Icon(context.appIcons.addToCart),
    );
  }

  // Build product info
  Widget _buildProductInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (product.brand != null)
          Text(
            product.brand!,
            style: TextStyle(color: context.theme.hintColor),
          ),
        Text(product.title, overflow: TextOverflow.ellipsis, maxLines: 2),
      ],
    );
  }

  Widget _buildFooterSection(BuildContext context) {
    return CustomCarouselSlider(
      scrollDirection: Axis.vertical,

      height: 35,
      showIndicator: false,
      items: [
        BriefRatingWidget(rateValue: product.rateValue ?? 0.0),
        Text('data2'),
        Text('data3'),
      ],
    );
  }

  Widget _buildBadge(String text, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      margin: EdgeInsets.only(right: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
