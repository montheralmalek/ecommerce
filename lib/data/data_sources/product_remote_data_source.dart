import 'package:dio/dio.dart';
import 'package:store/core/constants/constant.dart';
import 'package:store/core/network/api_request.dart';

import '../../core/errors/exceptions.dart';
import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts();
  // Future<ProductModel> getProductById(String id);
  // Future<List<ProductModel>> searchProducts(String query);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  // final Dio dio;
  final ApiRequest _apiRequest;

  ProductRemoteDataSourceImpl(this._apiRequest);

  @override
  Future<List<ProductModel>> getProducts() async {
    try {
      final response = await _apiRequest.get(kGetProducts);
      return (response.data['products'] as List)
          .map((json) => ProductModel.fromJson(json))
          .toList();
    } on DioException catch (e) {
      throw e.toAppException();
    } on NetworkException catch (e) {
      rethrow;
    } on Exception catch (e) {
      throw e.toAppException();
    } catch (e) {
      throw ServerException('Unknown error occurred: $e');
    }
  }
}
