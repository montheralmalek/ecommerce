import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/data/repositories/product_repository/product_repository.dart';
import 'package:store/domain/entities/product/product.dart';

part 'get_product_by_id_state.dart';

class GetProductByIdCubit extends Cubit<GetProductByIdState> {
  final ProductRepository _productRepository;
  GetProductByIdCubit({required ProductRepository productRepository})
    : _productRepository = productRepository,
      super(GetProductByIdInitial());
  void loadProductDetail(int productId) async {
    if (state is GetProductByIdLoading) return;
    emit(GetProductByIdLoading());
    try {
      final result = await _productRepository.getProductById(
        productId.toString(),
      );

      result.where(
        onSuccess: (product) {
          emit(GetProductByIdLoaded(product: product));
        },
        onFailure: (error) {
          emit(GetProductByIdError(message: error.message));
        },
      );
    } catch (e) {
      emit(GetProductByIdError(message: e.toString()));
    }
  }
}
