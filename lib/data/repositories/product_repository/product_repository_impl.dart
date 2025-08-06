import 'package:store/core/network/network_info.dart';
import 'package:store/core/utils/errors/app_errors.dart';
import 'package:store/core/utils/errors/exceptions.dart';
import 'package:store/core/utils/result.dart';
import 'package:store/data/mappers/product_mapper_extension.dart';
import 'package:store/data/repositories/product_repository/product_repository.dart';
import 'package:store/data/services/remote/api_service.dart';
import 'package:store/domain/entities/product.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ApiService _remoteDataSource;
  final NetworkInfo _networkInfo;
  // final LocalDataBase _localDataSource;

  ProductRepositoryImpl({
    required ApiService remoteDataSource,
    required NetworkInfo networkInfo,
  }) : _networkInfo = networkInfo,
       _remoteDataSource = remoteDataSource;

  @override
  Future<Result<List<Product>>> getProducts() async {
    try {
      // Check if the device is connected to the internet
      // If connected, fetch data from the remote data source
      // If not connected, fetch data from the local data source
      if (await _networkInfo.isConnected) {
        // Get from remoteDataSource
        final productModels = await _remoteDataSource.getProducts();

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
        throw NetworkException.noInternet();
      }
    } on AppException catch (e) {
      return Result.failure(e.toError());
    } on Exception catch (e) {
      return Result.failure(AppError.fromException(e));
    }
  }

  @override
  Future<Result<Product>> getProductById(String id) {
    return _networkInfo.isConnected.then((isConnected) async {
      if (isConnected) {
        try {
          final productModel = await _remoteDataSource.getProductById(id);
          final productEntity = productModel.toEntity();
          return Result.success(productEntity);
        } on AppException catch (e) {
          return Result.failure(e.toError());
        } on Exception catch (e) {
          return Result.failure(AppError.fromException(e));
        } catch (e) {
          return Result.failure(CustomError(e.toString()));
        }
      } else {
        return Failure(NetworkException.noInternet().toError());
      }
    });
  }

  @override
  Future<Result<List<Product>>> getProductsBySection(
    String section, {
    int limit = 10,
  }) async {
    try {
      // if (await _networkInfo.isConnected) {
      // Get from remoteDataSource
      final productModels = await _remoteDataSource.getSectionProducts(
        section,
        limit: limit,
      );

      // Map the models to entities
      final productEntities =
          productModels.map((model) => model.toEntity()).toList();

      // Save to localDataSource
      // await localDataSource.saveProducts(productModels);
      return Result.success(productEntities);
      // } else {
      //   //   // Get from localDataSource

      //   throw NetworkException.noInternet();
      // }
    } on AppException catch (e) {
      return Result.failure(e.toError());
    } on Exception catch (e) {
      return Result.failure(AppError.fromException(e));
    }
  }
}
