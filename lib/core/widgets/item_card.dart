import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:store/core/utils/extensions/context_extensions.dart';
import 'package:store/presentation/features/product/cubits/getProductByIdCubit/product_detail_cubit.dart';
import 'package:store/routing/routes.dart';
import 'package:store/core/utils/errors/image_error_functions.dart';
import 'package:store/core/utils/helpers/calculates_func.dart';
import 'package:store/core/widgets/add_to_cart_button.dart';
import 'package:store/domain/domain_models/product.dart';

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
          () {
            // BlocProvider.of<GetCustomProductsCubit>(context).refereshData();
            // BlocProvider.of<GetCustomProductsCubit>(context)
            //     .getCustomProducts(category: product.category);

            // BlocProvider.of<>(context)
            context.read<ProductDetailCubit>().loadProductDetail(product.id);
            context.pushNamed(
              AppRoutes.productDetails,
              pathParameters: {'id': product.id.toString()},
            );
          },
      child: Container(
        height: height,
        width: width,
        margin: margin,
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(width: 0.5, color: Colors.grey),
        ),
        child: Column(
          spacing: 5,
          children: [
            //---------- Start item image ------------
            Expanded(
              child: Badge(
                alignment: AlignmentDirectional(-1, -1),
                backgroundColor: Colors.red,
                label: Text('${product.discount} % OFF'),
                isLabelVisible:
                    product.discount != null && product.discount! > 0,
                offset: const Offset(5, 7),
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                child: CustomCachedNetworkImage(
                  imageUrl: product.imageUrl,
                  radius: radius,
                ),
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
                spacing: 5,
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
                  _PriceShowWidget(
                    discount: product.discount,
                    price: product.price,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //** ------- Add To Cart Button ----------- */
                      // PlatformIconButton(
                      //   icon: Icon(context.platformIcons.favoriteOutline,),
                      //   padding: EdgeInsets.zero,
                      // ),
                      AddToCartButton(product: product, expanded: false),
                      BriefRatingWidget(rateValue: 4.5),
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
    );
  }
}

class CustomCachedNetworkImage extends StatelessWidget {
  const CustomCachedNetworkImage({
    super.key,
    required this.imageUrl,
    this.radius,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
  });

  final String imageUrl;
  final double? radius;
  final BoxFit? fit;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Skeleton.replace(
      width: width ?? double.infinity,
      height: height ?? double.infinity,
      child: SizedBox(
        width: width,
        height: height,
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          imageBuilder:
              (context, imageProvider) => Container(
                width: width,
                height: height,
                constraints: BoxConstraints.expand(
                  width: width ?? double.infinity,
                  height: height ?? double.infinity,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radius ?? 0),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: fit,
                    colorFilter: const ColorFilter.mode(
                      Colors.black12,
                      BlendMode.darken,
                    ),
                  ),
                ),
              ),

          placeholder: (context, url) => SizedBox.shrink(),

          errorWidget: imageErrorWidget,
          errorListener: imageErrorListener,
          // fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _PriceShowWidget extends StatelessWidget {
  const _PriceShowWidget({super.key, required this.price, this.discount});
  final int? discount;
  final double price;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: '${calculateDiscountPrice(price, discount?.toDouble() ?? 0)}',
        children:
            discount != null
                ? [
                  TextSpan(text: ' '),
                  TextSpan(
                    text: '$price',
                    style: TextStyle(
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough,
                      decorationThickness: 1.5,
                      decorationColor: Colors.grey,
                    ),
                  ),
                ]
                : null,
      ),
    );
  }
}

class BriefRatingWidget extends StatelessWidget {
  const BriefRatingWidget({
    super.key,
    required this.rateValue,
    this.reviewsCount,
    this.backgroundColor,
    this.size = 18,
    this.boxShape = BoxShape.circle,
  });

  /// review count
  final double rateValue;
  final int? reviewsCount;
  final Color? backgroundColor;

  final double size;
  final BoxShape boxShape;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 5,
      children: [
        Icon(Icons.star_rate_rounded, color: Colors.amber, size: size),
        Text(
          '$rateValue${reviewsCount != null ? ' ($reviewsCount Reviews)' : ''}',
          style: TextStyle(
            fontSize: size * 0.8,
            color: context.theme.disabledColor,
          ),
        ),
      ],
    );
  }
}

// class FavoriteIconButton extends StatelessWidget {
//   const FavoriteIconButton({
//     super.key,
//     required this.product,
//     this.backgroundColor,
//     this.size = 30,
//     this.boxShape = BoxShape.circle,
//   });
//   final ProductEntity product;
//   final Color? backgroundColor;
//   final double size;
//   final BoxShape boxShape;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(5),
//       decoration: BoxDecoration(
//         color: backgroundColor,
//         shape: boxShape,
//         borderRadius: boxShape == BoxShape.circle
//             ? BorderRadius.circular(size / 2)
//             : BorderRadius.circular(0),
//         border: Border.all(
//           color: Colors.grey.shade300,
//           width: 0.5,
//         ),
//       ),
//       child: IconButton(
//         onPressed: () {
//           // BlocProvider.of<FavoriteCubit>(context).addOrRemoveProduct(product);
//         },
//         icon: BlocBuilder<FavoriteCubit, FavoriteState>(
//           builder: (context, state) {
//             return Icon(
//              state.isFavorite(product)
//                 ? Icons.favorite
//                 : Icons.favorite_border,
//               color: state.isFavorite(product)
//                   ? Colors.red
//                   : Colors.grey.shade600,
//               size: size / 2,
//             );
//           },
//         ),),
//     );
//   }
// }
