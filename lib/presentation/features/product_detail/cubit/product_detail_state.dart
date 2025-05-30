part of 'product_detail_cubit.dart';

class ProductDetailState {
  const ProductDetailState();
}

class ProductDetailInitial extends ProductDetailState {
  const ProductDetailInitial();
}

class ProductDetailLoading extends ProductDetailState {
  const ProductDetailLoading();
}

class ProductDetailLoaded extends ProductDetailState {
  const ProductDetailLoaded({required this.product});

  final Product product;
}

class ProductDetailError extends ProductDetailState {
  const ProductDetailError({required this.message});

  final String message;
}
