import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/domain/entities/home_section_entity.dart';
import 'package:store/domain/entities/product_entity.dart';
import 'package:store/domain/use_cases/get_products_use_case.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final GetProductsUseCase getProducts;

  ProductCubit({required this.getProducts}) : super(ProductInitial());

  Future<void> fetchProducts() async {
    // Check if the current state is already loading
    if (state is ProductLoading) {
      return; // Prevent multiple loading states
    }
    // Emit loading state
    setLoading();
    try {
      final result = await getProducts();
      result.where(
        onSuccess: (products) => setLoaded(products),
        onFailure: (error) => setError(error.toString()),
      );
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  void reset() {
    emit(ProductInitial());
  }

  void setLoading() {
    emit(ProductLoading());
  }

  void setError(String error) {
    emit(ProductError(error));
  }

  void setLoaded(List<ProductEntity> products) {
    final populars = products.where((product) => product.isPopular).toList();
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
