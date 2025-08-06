import 'package:store/core/utils/result.dart';
import 'package:store/domain/entities/product.dart';

abstract class ProductRepository {
  Future<Result<List<Product>>> getProducts();
  Future<Result<Product>> getProductById(String id);
  Future<Result<List<Product>>> getProductsBySection(
    String section, {
    int limit = 10,
  });
}
