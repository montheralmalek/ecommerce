import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:store/domain/entities/product.dart';

part 'add_to_cart_state.dart';

class AddToCartCubit extends Cubit<AddToCartState> {
  AddToCartCubit({required Product product})
    : super(AddToCartState(product: product, totalPrice: product.realPrice)) {
    _log.info('AddToCartCubit initialized with product: ${product.title}');
  }
  final _log = Logger('AddToCartCubit');

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
