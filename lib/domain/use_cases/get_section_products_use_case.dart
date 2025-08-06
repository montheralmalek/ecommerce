import 'package:store/core/utils/result.dart';
import 'package:store/data/repositories/product_repository/product_repository.dart';
import 'package:store/domain/entities/product.dart';

class GetSectionProductsUseCase {
  final ProductRepository _repository;

  GetSectionProductsUseCase(this._repository);

  Future<Result<List<Product>>> execute(
    String section, {
    int limit = 10,
  }) async => await _repository.getProductsBySection(section, limit: limit);
}
