part of 'get_product_by_id_cubit.dart';

abstract class GetProductByIdState {
  const GetProductByIdState();
  Product get product;
}

class GetProductByIdInitial extends GetProductByIdState {
  const GetProductByIdInitial();

  @override
  Product get product => Product.empty();
}

class GetProductByIdLoading extends GetProductByIdState {
  const GetProductByIdLoading();

  @override
  Product get product => Product.loading();
}

class GetProductByIdLoaded extends GetProductByIdState {
  const GetProductByIdLoaded({required this.product});

  @override
  final Product product;
}

class GetProductByIdError extends GetProductByIdState {
  const GetProductByIdError({required this.message});

  final String message;

  @override
  Product get product => Product.empty();
}
