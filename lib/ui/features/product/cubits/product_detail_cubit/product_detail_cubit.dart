import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:store/domain/entities/product.dart';

part 'product_detail_state.dart';

class ProductDetailCubit extends Cubit<ProductDetailState> {
  ProductDetailCubit({required Product product})
    : super(
        ProductDetailState(product: product, totalPrice: product.realPrice),
      ) {
    _log.info('ProductDetailCubit initialized with product: ${product.title}');
  }
  final _log = Logger('ProductDetailCubit');

  void updateQuantity(int newQuantity) {
    final newTotalPrice = state.product.realPrice * newQuantity;
    emit(state.copyWith(quantity: newQuantity, totalPrice: newTotalPrice));
  }

  void selectColor(String color) {
    emit(state.copyWith(selectedColor: color));
  }

  void selectSize(String size) {
    emit(state.copyWith(selectedSize: size));
  }
}
