part of 'product_detail_cubit.dart';

abstract class ProductDetailState {
  const ProductDetailState();
  Product get product;
}

class ProductDetailInitial extends ProductDetailState {
  const ProductDetailInitial();

  @override
  Product get product => Product.empty();
}

class ProductDetailLoading extends ProductDetailState {
  const ProductDetailLoading();

  @override
  Product get product => Product.loading();
}

class ProductDetailLoaded extends ProductDetailState {
  const ProductDetailLoaded({required this.product});

  @override
  final Product product;
}

class ProductDetailError extends ProductDetailState {
  const ProductDetailError({required this.message});

  final String message;

  @override
  Product get product => Product.empty();
}
