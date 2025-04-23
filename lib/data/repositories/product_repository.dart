import 'package:store/core/errors/app_errors.dart';
import 'package:store/core/errors/exceptions.dart';
import 'package:store/core/network/network_info.dart';
import 'package:store/core/services/result.dart';
import 'package:store/data/mappers/product_mapper_extension.dart';
import 'package:store/domain/entities/product_entity.dart';

import '../data_sources/product_remote_data_source.dart';

abstract class ProductRepository {
  Future<Result<List<ProductEntity>>> getProducts();
  // Future<ProductEntity> getProductById(String id);
}

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ProductRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Result<List<ProductEntity>>> getProducts() async {
    try {
      // Check if the device is connected to the internet
      // If connected, fetch data from the remote data source
      // If not connected, fetch data from the local data source
      if (await networkInfo.isConnected) {
        // Get from remoteDataSource
        final productModels = await remoteDataSource.getProducts();

        // Map the models to entities
        final productEntities =
            productModels.map((model) => model.toEntity()).toList();

        // Save to localDataSource
        // await localDataSource.saveProducts(productModels);
        return Result.success(productEntities);
      } else {
        //   // Get from localDataSource
        //   // final productModels = await localDataSource.getProducts();
        //   // return productModels.map((model) => model.toEntity()).toList();
        throw ServerException('No internet connection');
      }
    } on NetworkException catch (e) {
      return Result.failure(NetworkError(e.message));
    } catch (e) {
      return Result.failure(UnknownError(e.toString()));
    }
  }
}
