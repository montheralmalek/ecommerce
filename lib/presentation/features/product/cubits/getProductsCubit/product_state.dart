part of 'product_cubit.dart';

abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<Product> allProducts;
  final List<Product> popularProducts;
  final List<Product> onSaleProducts;

  ProductLoaded(
    this.allProducts, {
    this.popularProducts = const [],
    this.onSaleProducts = const [],
  });
  // List<HomeSection> get sections {
  //   return [
  //     HomeSection(
  //       type: HOMESECTIONTYPE.horizontalItems,
  //       title: 'Popular Products',
  //       data: popularProducts,
  //       actionText: 'See All',
  //       targetId: 'popular',
  //     ),
  //     HomeSection(
  //       type: HOMESECTIONTYPE.horizontalItems,
  //       title: 'On Sale Products',
  //       data: onSaleProducts,
  //       actionText: 'See All',
  //       targetId: 'onSale',
  //     ),
  //     HomeSection(
  //       type: HOMESECTIONTYPE.itemsGrid,
  //       title: 'All Products',
  //       data: allProducts,
  //     ),
  //   ];
  // }
}

class ProductError extends ProductState {
  final String message;

  ProductError(this.message);
}
