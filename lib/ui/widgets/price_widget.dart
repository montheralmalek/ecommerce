import 'package:flutter/material.dart';
import 'package:store/core/utils/extensions/context_extensions.dart';
import 'package:store/domain/entities/product.dart';

class PriceWidget extends StatelessWidget {
  const PriceWidget({super.key, required this.product})
    : _isLarge = false,
      _isSmall = false;

  const PriceWidget.large({super.key, required this.product})
    : _isLarge = true,
      _isSmall = false;
  const PriceWidget.small({super.key, required this.product})
    : _isLarge = false,
      _isSmall = true;

  final Product product;
  final bool _isLarge;
  final bool _isSmall;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.formattedRealPrice,
          style: TextStyle(
            fontSize: _realPriceFontSize(context),
            color: context.theme.colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
          // textScaler: TextScaler.linear(0.2),
        ),

        if (product.hasDiscount)
          Row(
            children: [
              Text(
                product.formattedOriginalPrice,
                style: TextStyle(
                  fontSize: _discountFontSize(context),
                  color: context.theme.hintColor,
                  decoration: TextDecoration.lineThrough,
                  decorationColor: context.theme.hintColor,
                ),
              ),
              const SizedBox(width: 5),
              Text(
                product.discountString,
                style: TextStyle(
                  fontSize: _discountFontSize(context),
                  color: context.theme.colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
      ],
    );
  }

  double? _realPriceFontSize(BuildContext context) {
    if (_isLarge) {
      return context.textTheme.titleLarge?.fontSize;
    } else if (_isSmall) {
      return context.textTheme.bodySmall?.fontSize;
    }
    return context.textTheme.bodyMedium?.fontSize;
  }

  double? _discountFontSize(BuildContext context) {
    if (_isLarge) {
      return context.textTheme.labelLarge?.fontSize;
    } else if (_isSmall) {
      return context.textTheme.labelSmall?.fontSize;
    }
    return context.textTheme.labelMedium?.fontSize;
  }
}
