import 'package:store/core/utils/result.dart';
import 'package:store/data/repositories/product_repository/product_repository.dart';
import 'package:store/domain/entities/product.dart';

class GetProductsUseCase {
  final ProductRepository _repository;

  GetProductsUseCase(this._repository);

  Future<Result<List<Product>>> execute() async =>
      await _repository.getProducts();
}
