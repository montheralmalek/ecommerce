part of 'add_to_cart_cubit.dart';

@immutable
class AddToCartState {
  final Product product;
  final int quantity;
  final String? selectedColor;
  final String? selectedSize;
  final double totalPrice;

  const AddToCartState({
    required this.product,
    this.quantity = 1,
    this.selectedColor,
    this.selectedSize,
    required this.totalPrice,
  });

  AddToCartState copyWith({
    int? quantity,
    String? selectedColor,
    String? selectedSize,
    double? totalPrice,
  }) {
    return AddToCartState(
      product: product,
      quantity: quantity ?? this.quantity,
      selectedColor: selectedColor ?? this.selectedColor,
      selectedSize: selectedSize ?? this.selectedSize,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }
}
