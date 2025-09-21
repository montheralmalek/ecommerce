import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:store/domain/entities/product.dart';
import 'package:store/domain/use_cases/get_products_use_case.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final GetProductsUseCase _getProducts;

  ProductCubit({required GetProductsUseCase getProducts})
    : _getProducts = getProducts,
      super(ProductInitial());
  final _log = Logger('Product Cubit');
  Future<void> fetchProducts() async {
    // Check if the current state is already loading
    if (state is ProductLoading) {
      return; // Prevent multiple loading states
    }
    // Emit loading state
    setLoading();
    try {
      final result = await _getProducts.execute();
      result.where(
        onSuccess: (products) => setLoaded(products),
        onFailure: (error) => setError(error.toString()),
      );
    } catch (e) {
      setError(e.toString());
    }
  }

  void reset() {
    emit(ProductInitial());
  }

  void setLoading() {
    emit(ProductLoading());
  }

  void setError(String error) {
    _log.warning(error);
    emit(ProductError(error));
  }

  void setLoaded(List<Product> products) {
    final populars = products.where((product) => product.isNew).toList();
    final onSales = products.where((product) => product.isOnSale).toList();
    emit(
      ProductLoaded(
        products,
        popularProducts: populars,
        onSaleProducts: onSales,
      ),
    );
  }
}
