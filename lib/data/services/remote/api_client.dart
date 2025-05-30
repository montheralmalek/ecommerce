import 'package:dio/dio.dart';
import 'package:store/core/constants/constant.dart';
import 'package:store/core/network/dio_client.dart';

import '../../../core/utils/errors/exceptions.dart';
import 'models/product_api_model.dart';

abstract class ApiClient {
  Future<List<ProductApiModel>> getProducts();
  Future<ProductApiModel> getProductById(String id);
  // Future<List<ProductModel>> searchProducts(String query);
}

class ApiClientImpl implements ApiClient {
  // final Dio dio;
  final DioClient _apiRequest;

  ApiClientImpl(this._apiRequest) {
    _apiRequest.dio.options.baseUrl = kBaseUrl;
    _apiRequest.dio.options.connectTimeout = const Duration(seconds: 30);
    _apiRequest.dio.options.receiveTimeout = const Duration(seconds: 30);
  }

  @override
  Future<List<ProductApiModel>> getProducts() async {
    try {
      final response = await _apiRequest.get(kGetProducts);
      return (response.data['products'] as List)
          .map((json) => ProductApiModel.fromJson(json))
          .toList();
    } on AppException {
      rethrow;
    } on Exception catch (e) {
      throw e.toAppException();
    } catch (e) {
      throw AppException.custom('Unknown error occurred: $e');
    }
  }

  @override
  Future<ProductApiModel> getProductById(String id) async {
    try {
      final response = await _apiRequest.get('$kGetProducts/$id');
      return ProductApiModel.fromJson(response.data['product']);
    } on AppException {
      rethrow;
    } on Exception catch (e) {
      throw e.toAppException();
    } catch (e) {
      throw ServerException('Unknown error occurred: $e');
    }
  }
}
