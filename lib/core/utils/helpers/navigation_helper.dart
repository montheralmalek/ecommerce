import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:store/domain/entities/product/product.dart';
import 'package:store/routing/routes.dart';

class NavigationHelper {
  final BuildContext context;

  NavigationHelper.of(this.context);

  /// Navigate to Home Screen
  void goToHomeScreen() {
    context.pushNamed(AppRoutes.home);
  }

  /// Navigate to Add To Cart Screen
  void goToAddToCartScreen(Product product) {
    context.pushNamed(AppRoutes.addToCart, extra: product);
  }
}
