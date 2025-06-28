import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:store/core/utils/extensions/context_extensions.dart';
import 'package:store/presentation/features/product/widgets/custom_linear_progress_indicator.dart';
import 'package:store/presentation/features/product/widgets/rating_bar.dart';
import 'package:store/routing/routes.dart';

class ProductRatingDetailWidget extends StatelessWidget {
  const ProductRatingDetailWidget({
    super.key,
    required this.rateValue,
    required this.reviewsCount,
    required this.starRatings,
  });
  final double rateValue;
  final int reviewsCount;
  final List<double> starRatings;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(AppRoutes.productRating);
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  spacing: 5,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      TextSpan(
                        text: rateValue.toStringAsFixed(1),
                        style: context.textTheme.titleMedium?.copyWith(
                          fontSize: 24,
                        ),
                        children: [
                          TextSpan(
                            text: ' /5',
                            style: context.textTheme.bodyMedium?.copyWith(
                              color: context.theme.hintColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    PlatformText('Based on $reviewsCount Reviews'),
                    // stars rating
                    RatingBar.star(
                      rateValue: rateValue,
                      spacing: 4.0,
                      allowHalfRating: true,
                      ratedColor: Colors.amber,
                      unratedColor: context.theme.disabledColor,
                      itemBuilder:
                          (context, _) => Icon(Icons.star_rate_rounded),
                    ),
                    // _buildStarRatingIcons(context),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  spacing: 5,
                  children: [
                    ...starRatings.asMap().entries.map((entry) {
                      final index = entry.key;
                      final value = entry.value;
                      return CustomLinearProgressIndicator(
                        value: value,
                        title: Text('${5 - index} star'),
                        color: context.colorScheme.primary,
                        backgroundColor: context.theme.disabledColor,
                      );
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
