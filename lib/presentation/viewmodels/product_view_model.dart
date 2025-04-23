import 'package:store/domain/entities/product_entity.dart';
import 'package:store/presentation/cubits/product_cubit.dart';

class ProductViewModel {
  final ProductCubit productCubit;

  ProductViewModel({required this.productCubit});

  void loadProducts() {
    productCubit.fetchProducts();
  }

  List<ProductEntity> get products {
    if (productCubit.state is ProductLoaded) {
      return (productCubit.state as ProductLoaded).allProducts;
    }
    return [];
  }

  bool get isLoading => productCubit.state is ProductLoading;
  String? get error =>
      productCubit.state is ProductError
          ? (productCubit.state as ProductError).message
          : null;
}
