import 'package:store/domain/entities/product/product_listing.dart';

class ProductVariant {
  final String id;
  final int colorId;
  final int sizeId;
  final String slug;
  final double price;
  final StockStatus stockStatus;
  // TODO: Add specificImages support for product variants in future updates.
  // final List<String> specificImages;

  const ProductVariant({
    required this.id,
    required this.colorId,
    required this.sizeId,
    required this.slug,
    required this.price,
    required this.stockStatus,
    // this.specificImages = const [],
  });

  /// Returns true if the variant is available in stock.
  bool get available => stockStatus == StockStatus.inStock;
}
