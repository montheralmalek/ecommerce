import 'package:store/domain/domain_models/product.dart';
import 'package:store/presentation/features/home/cubits/getProductsCubit/product_cubit.dart';

class ProductViewModel {
  final ProductCubit productCubit;

  ProductViewModel({required this.productCubit});

  void loadProducts() {
    productCubit.fetchProducts();
  }

  List<Product> get products {
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
