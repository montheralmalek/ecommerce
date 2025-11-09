import 'package:store/domain/entities/product/base/base_product.dart';
import 'package:store/domain/entities/product/product_pricing.dart';

class ProductListing extends BaseProduct {
  final ProductPricing pricing;
  final ProductRating rating;
  final ProductAvailability availability;
  // final ProductVariantsMeta variantsMeta;
  final List<String> tags;
  // final List<String> badges;
  // final ProductMetadata metadata;

  ProductListing({
    required super.id,
    required super.name,
    required super.description,
    required super.category,
    required super.image,
    super.brand,
    super.model,
    super.baseSlug = '',
    required this.pricing,
    required this.rating,
    required this.availability,
    // required this.variantsMeta,
    required this.tags,
    // required this.badges,
    // required this.metadata,
  });

  factory ProductListing.fromJson(Map<String, dynamic> json) {
    return ProductListing(
      id: json['id'],
      name: json['name'],
      description: json['short_description'] ?? '',
      category: json['category'],
      pricing: ProductPricing.fromJson(json['pricing']),
      image: json['image'],
      brand: json['brand'],
      model: json['model'],
      baseSlug: json['slug'] ?? '',
      rating: ProductRating.fromJson(json['rating']),
      availability: ProductAvailability.fromJson(json['availability']),
      // variantsMeta: ProductVariantsMeta.fromJson(json['variants_meta']),
      tags: List<String>.from(json['tags'] ?? []),
      // badges: List<String>.from(json['badges'] ?? []),
      // metadata: ProductMetadata.fromJson(json['metadata'] ?? {}),
    );
  }

  // دوال مساعدة مفيدة
  String get displayPrice {
    if (pricing.range != null && pricing.hasVariation) {
      return '${pricing.finalPrice} - ${pricing.range!.max} ${pricing.currency}';
    }
    return '${pricing.finalPrice} ${pricing.currency}';
  }

  bool get hasDiscount => pricing.discountPercentage > 0;

  bool get isLowStock => availability.stockStatus == StockStatus.lowStock;

  bool get isRangePrice => pricing.range != null && pricing.hasVariation;
}

/// Stock status Enum
/// - in_stock: in stock can be purchased
/// - out_of_stock: out of stock cannot be purchased
/// - low_stock: low stock warning
/// - pre_order: available for pre-order
enum StockStatus {
  inStock('in_stock'),
  outOfStock('out_of_stock'),
  lowStock('low_stock'),
  preOrder('pre_order');

  final String value;
  const StockStatus(this.value);
  @override
  String toString() => value;

  static StockStatus fromString(String status) {
    return StockStatus.values.firstWhere(
      (e) => e.value == status,
      orElse: () => StockStatus.inStock,
    );
  }
}

// نموذج التقييم
class ProductRating {
  /// Average rating value
  final double rateValue;

  /// Total number of ratings
  final int count;

  /// Distribution of ratings (e.g., [5, 10, 3, 2, 1] for 5-star to 1-star)
  /// where index 0 is 5-star, index 1 is 4-star, ..., index 4 is 1-star
  final List<int> distribution;

  ProductRating({
    required this.rateValue,
    required this.count,
    required this.distribution,
  });

  factory ProductRating.fromJson(Map<String, dynamic> json) {
    return ProductRating(
      rateValue: (json['average'] as num).toDouble(),
      count: json['count'] ?? 0,
      distribution: List<int>.from(json['distribution'] ?? []),
    );
  }
}

// نموذج التوفر
class ProductAvailability {
  final bool isAvailable;
  final StockStatus stockStatus;
  final int lowStockThreshold;

  ProductAvailability({
    required this.isAvailable,
    required this.stockStatus,
    required this.lowStockThreshold,
  });

  factory ProductAvailability.fromJson(Map<String, dynamic> json) {
    return ProductAvailability(
      isAvailable: json['is_available'],
      stockStatus: StockStatus.fromString(json['stock_status'] ?? ''),
      lowStockThreshold: json['low_stock_threshold'] ?? 5,
    );
  }
}

// // نموذج متغيرات المنتج
// class ProductVariantsMeta {
//   final bool hasVariants;
//   final int totalVariants;
//   final int availableVariants;
//   final VariantDefaultSelection defaultSelection;

//   ProductVariantsMeta({
//     required this.hasVariants,
//     required this.totalVariants,
//     required this.availableVariants,
//     required this.defaultSelection,
//   });

//   factory ProductVariantsMeta.fromJson(Map<String, dynamic> json) {
//     return ProductVariantsMeta(
//       hasVariants: json['has_variants'],
//       totalVariants: json['total_variants'] ?? 0,
//       availableVariants: json['available_variants'] ?? 0,
//       defaultSelection: VariantDefaultSelection.fromJson(
//         json['default_selection'] ?? {},
//       ),
//     );
//   }
// }

// class VariantDefaultSelection {
//   final String variantId;
//   final int colorId;
//   final int sizeId;
//   final double price;

//   VariantDefaultSelection({
//     required this.variantId,
//     required this.colorId,
//     required this.sizeId,
//     required this.price,
//   });

//   factory VariantDefaultSelection.fromJson(Map<String, dynamic> json) {
//     return VariantDefaultSelection(
//       variantId: json['variant_id'] ?? '',
//       colorId: json['color_id'] ?? 0,
//       sizeId: json['size_id'] ?? 0,
//       price: (json['price'] as num?)?.toDouble() ?? 0.0,
//     );
//   }
// }

// // نموذج البيانات الوصفية
// class ProductMetadata {
//   final String sku;
//   final String brand;
//   final DateTime createdAt;
//   final DateTime updatedAt;

//   ProductMetadata({
//     required this.sku,
//     required this.brand,
//     required this.createdAt,
//     required this.updatedAt,
//   });

//   factory ProductMetadata.fromJson(Map<String, dynamic> json) {
//     return ProductMetadata(
//       sku: json['sku'] ?? '',
//       brand: json['brand'] ?? '',
//       createdAt: DateTime.parse(
//         json['created_at'] ?? DateTime.now().toIso8601String(),
//       ),
//       updatedAt: DateTime.parse(
//         json['updated_at'] ?? DateTime.now().toIso8601String(),
//       ),
//     );
//   }
// }
// ///-------------------
// class ProductAvailability {
//   static Widget buildAvailabilityWidget(ProductListing product) {
//     if (!product.isAvailable) {
//       return Container(
//         padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//         decoration: BoxDecoration(
//           color: Colors.grey[300],
//           borderRadius: BorderRadius.circular(4),
//         ),
//         child: Text(
//           'غير متوفر',
//           style: TextStyle(color: Colors.grey[600], fontSize: 12),
//         ),
//       );
//     }
    
//     if (product.hasVariants) {
//       return Container(
//         padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//         decoration: BoxDecoration(
//           color: Colors.blue[50],
//           borderRadius: BorderRadius.circular(4),
//         ),
//         child: Text(
//           'خيارات متعددة',
//           style: TextStyle(color: Colors.blue[700], fontSize: 12),
//         ),
//       );
//     }
    
//     return SizedBox.shrink(); // لا شيء إذا كان منتج عادي متوفر
//   }
// }

// ///===========
// class PriceHelper {
//   static String getDisplayPrice(ProductListing product) {
//     if (product.discountPercentage > 0) {
//       return '''
//       <span style="text-decoration: line-through; color: gray;">${product.basePrice} ر.س</span>
//       <span style="color: red; font-weight: bold;">${product.finalPrice} ر.س</span>
//       ''';
//     } else if (product.hasVariants) {
//       return 'بدءاً من ${product.finalPrice} ر.س';
//     } else {
//       return '${product.finalPrice} ر.س';
//     }
//   }
  
//   static Widget buildPriceWidget(ProductListing product) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         if (product.discountPercentage > 0) ...[
//           Text(
//             '${product.basePrice} ر.س',
//             style: TextStyle(
//               decoration: TextDecoration.lineThrough,
//               color: Colors.grey,
//             ),
//           ),
//           Text(
//             '${product.finalPrice} ر.س',
//             style: TextStyle(
//               color: Colors.red,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ] else if (product.hasVariants) 
//           Text('بدءاً من ${product.finalPrice} ر.س'),
//         else
//           Text('${product.finalPrice} ر.س'),
//       ],
//     );
//   }
// }