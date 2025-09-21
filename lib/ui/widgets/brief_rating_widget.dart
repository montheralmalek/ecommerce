import 'package:flutter/material.dart';
import 'package:store/core/utils/extensions/context_extensions.dart';

class BriefRatingWidget extends StatelessWidget {
  const BriefRatingWidget({
    super.key,
    required this.rateValue,
    this.reviewsCount,
    this.backgroundColor,
    this.size = 18,
  });

  /// review count
  final double rateValue;
  final int? reviewsCount;
  final Color? backgroundColor;

  final double size;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
        // border: Border.all(color: context.theme.disabledColor),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
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
