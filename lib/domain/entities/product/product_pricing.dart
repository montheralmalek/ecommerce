class ProductPricing {
  final double originalPrice;
  final double finalPrice;
  final int discountPercentage;
  final String currency;
  final bool hasVariation;
  final String? variantId;
  final PriceRange? range;

  ProductPricing({
    required this.originalPrice,
    required this.finalPrice,
    required this.discountPercentage,
    required this.currency,
    required this.hasVariation,
    this.variantId,
    this.range,
  });

  factory ProductPricing.fromJson(Map<String, dynamic> json) {
    return ProductPricing(
      originalPrice: (json['base_price'] as num).toDouble(),
      finalPrice: (json['final_price'] as num).toDouble(),
      discountPercentage: json['discount_percentage'] ?? 0,
      currency: json['currency'] ?? 'SAR',
      hasVariation: json['has_variation'] ?? false,
      variantId: json['variant_id'],
      range: PriceRange.fromJson(json['range']),
    );
  }
}

class PriceRange {
  final double min;
  final double max;

  PriceRange({required this.min, required this.max});

  factory PriceRange.fromJson(Map<String, dynamic> json) {
    return PriceRange(
      min: (json['min'] as num).toDouble(),
      max: (json['max'] as num).toDouble(),
    );
  }
}
// Price States:
// 1. fixed price (no discount or with discount, has no variants)
// 2. price range (has variants, no discount or with discount)
// 3. variant price (selected variant price, no discount or with discount ) 