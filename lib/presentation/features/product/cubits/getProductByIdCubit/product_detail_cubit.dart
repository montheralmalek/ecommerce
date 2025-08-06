import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/data/repositories/product_repository/product_repository.dart';
import 'package:store/domain/entities/product.dart';

part 'product_detail_state.dart';

class ProductDetailCubit extends Cubit<ProductDetailState> {
  final ProductRepository _productRepository;
  ProductDetailCubit({required ProductRepository productRepository})
    : _productRepository = productRepository,
      super(ProductDetailInitial());
  void loadProductDetail(int productId) async {
    if (state is ProductDetailLoading) return;
    emit(ProductDetailLoading());
    try {
      final result = await _productRepository.getProductById(
        productId.toString(),
      );

      result.where(
        onSuccess: (product) {
          emit(ProductDetailLoaded(product: product));
        },
        onFailure: (error) {
          emit(ProductDetailError(message: error.message));
        },
      );
    } catch (e) {
      emit(ProductDetailError(message: e.toString()));
    }
  }
}
