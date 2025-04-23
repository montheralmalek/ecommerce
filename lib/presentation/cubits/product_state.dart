part of 'product_cubit.dart';

abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<ProductEntity> allProducts;
  final List<ProductEntity> popularProducts;
  final List<ProductEntity> onSaleProducts;

  ProductLoaded(
    this.allProducts, {
    this.popularProducts = const [],
    this.onSaleProducts = const [],
  });
  List<HomeSectionEntity> get sections {
    return [
      HomeSectionEntity(
        type: HOMESECTIONTYPE.horizontalItems,
        title: 'Popular Products',
        data: popularProducts,
        actionText: 'See All',
        targetId: 'popular',
      ),
      HomeSectionEntity(
        type: HOMESECTIONTYPE.horizontalItems,
        title: 'On Sale Products',
        data: onSaleProducts,
        actionText: 'See All',
        targetId: 'onSale',
      ),
      HomeSectionEntity(
        type: HOMESECTIONTYPE.itemsGrid,
        title: 'All Products',
        data: allProducts,
      ),
    ];
  }
}

class ProductError extends ProductState {
  final String message;

  ProductError(this.message);
}
