import 'package:store/core/services/result.dart';
import 'package:store/data/repositories/product_repository.dart';
import 'package:store/domain/entities/product_entity.dart';

class GetProductsUseCase {
  final ProductRepository repository;

  GetProductsUseCase(this.repository);

  Future<Result<List<ProductEntity>>> call() async {
    return await repository.getProducts();
  }
}
