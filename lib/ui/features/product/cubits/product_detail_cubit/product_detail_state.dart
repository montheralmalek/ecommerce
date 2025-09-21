part of 'product_detail_cubit.dart';

@immutable
class ProductDetailState {
  final Product product;
  final int quantity;
  final String? selectedColor;
  final String? selectedSize;
  final double totalPrice;

  const ProductDetailState({
    required this.product,
    this.quantity = 1,
    this.selectedColor,
    this.selectedSize,
    required this.totalPrice,
  });

  ProductDetailState copyWith({
    int? quantity,
    String? selectedColor,
    String? selectedSize,
    double? totalPrice,
  }) {
    return ProductDetailState(
      product: product,
      quantity: quantity ?? this.quantity,
      selectedColor: selectedColor ?? this.selectedColor,
      selectedSize: selectedSize ?? this.selectedSize,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }
}
