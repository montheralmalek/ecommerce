import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:store/core/utils/helpers/calculates_func.dart';
import 'package:store/core/widgets/add_to_cart_button.dart';
import 'package:store/domain/entities/product_entity.dart';

class ItemCrad extends StatelessWidget {
  const ItemCrad({
    super.key,
    required this.product,
    this.radius = 8,
    this.margin,
  }) : height = null,
       width = null;
  const ItemCrad.customSize({
    super.key,
    required this.product,
    this.height = 200,
    this.width = 150,
    this.radius = 8,
    this.margin,
  });
  final ProductEntity product;
  final double radius;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // BlocProvider.of<GetCustomProductsCubit>(context).refereshData();
        // BlocProvider.of<GetCustomProductsCubit>(context)
        //     .getCustomProducts(category: product.category);
        // Navigator.pushNamed(context, ProductView.id, arguments: product);
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
                child: CachedNetworkImage(
                  imageUrl: product.imageUrl,
                  imageBuilder:
                      (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(radius),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                            colorFilter: const ColorFilter.mode(
                              Colors.black12,
                              BlendMode.darken,
                            ),
                          ),
                        ),
                      ),
                  placeholder:
                      (context, url) => Skeletonizer(
                        enabled: url.isEmpty,
                        child: Container(),
                      ),
                  errorWidget:
                      (context, url, error) => Container(
                        constraints: const BoxConstraints.expand(),
                        child: const Icon(Icons.error_outline_rounded),
                      ),
                  // fit: BoxFit.cover,
                ),
              ),
            ),
            //---------- End item image ------------------------
            //--------------------------------------------------
            const Gap(5),
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
                  Text(
                    product.title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  const Gap(8),
                  _PriceShowWidget(
                    discount: product.discount,
                    price: product.price,
                  ),
                  const Gap(5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //** ------- Add To Cart Button ----------- */
                      AddToCartButton(
                        product: product,
                        backgroundColor: Colors.grey.shade100,
                        boxShape: BoxShape.circle,
                        size: 40,
                      ),
                      RateProductShowWidget(rateValue: 4.5),
                    ],
                  ),
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

class RateProductShowWidget extends StatelessWidget {
  const RateProductShowWidget({
    super.key,
    required this.rateValue,
    this.backgroundColor,
    this.size = 30,
    this.boxShape = BoxShape.circle,
  });
  final double rateValue;
  final Color? backgroundColor;
  final double size;
  final BoxShape boxShape;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: backgroundColor,
        // shape: boxShape,
        borderRadius:
            boxShape == BoxShape.circle
                ? BorderRadius.circular(size / 2)
                : BorderRadius.circular(0),
        border: Border.all(color: Colors.grey.shade300, width: 0.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.star, color: Colors.amber, size: size / 2),
          const Gap(5),
          Text(
            rateValue.toString(),
            style: TextStyle(fontSize: size / 3, color: Colors.grey.shade600),
          ),
        ],
      ),
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
