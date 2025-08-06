import 'dart:convert';

import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:store/core/constants/api_endpoints.dart';
import 'package:store/core/constants/app_assets.dart';
import 'package:store/core/network/dio_client.dart';
import 'package:store/data/services/remote/models/ad_banner_model.dart';
import 'package:store/data/services/remote/models/home_section_model.dart';

import '../../../core/utils/errors/exceptions.dart';
import 'models/product_api_model.dart';

abstract class ApiService {
  Future<List<ProductApiModel>> getProducts({int limit});
  Future<ProductApiModel> getProductById(String id);

  //
  // Future<List<CategoryApiModel>> getCategories({int limit});
  // Future<List<ProductApiModel>> getCategoryProducts(String categoryId, {int limit});
  ///
  Future<List<HomeSectionApiModel>> getHomeSections();
  Future<List<ProductApiModel>> getSectionProducts(
    String section, {
    int limit = 10,
  });
  Future<List<AdBannerModel>> getBanners();
  Future<List<ProductApiModel>> getBannerProducts(String banner);
}

class ApiServiceImpl implements ApiService {
  // final Dio dio;
  final DioClient _apiRequest;

  ApiServiceImpl(this._apiRequest) {
    _apiRequest.dio.options.baseUrl = ApiEndpoints.baseUrl;
    _apiRequest.dio.options.connectTimeout = const Duration(seconds: 30);
    _apiRequest.dio.options.receiveTimeout = const Duration(seconds: 30);
  }

  @override
  Future<List<ProductApiModel>> getProducts({int limit = 20}) async {
    try {
      final Map<String, dynamic> param = {'limit': 20};
      final response = await _apiRequest.get(
        ApiEndpoints.getProducts,
        params: param,
      );
      return (response.data['products'] as List)
          .map((json) => ProductApiModel.fromJson(json))
          .toList();
    } catch (e) {
      throw _handleException(e);
    }
  }

  @override
  Future<ProductApiModel> getProductById(String id) async {
    try {
      final response = await _apiRequest.get(ApiEndpoints.getProductById(id));
      return ProductApiModel.fromJson(response.data['product']);
    } catch (e) {
      throw _handleException(e);
    }
  }

  @override
  Future<List<HomeSectionApiModel>> getHomeSections() async {
    try {
      await Future.delayed(const Duration(seconds: 3));
      final jsonString = await rootBundle.loadString(JsonAssets.homeSections);
      final List<dynamic> jsonList = json.decode(jsonString);
      return jsonList.map((json) {
        return HomeSectionApiModel.fromJson(json);
      }).toList();
    } catch (e) {
      throw _handleException(e);
    }
  }

  @override
  Future<List<ProductApiModel>> getSectionProducts(
    String section, {
    int limit = 10,
  }) async {
    try {
      // fetch products based on section
      return getProducts(limit: limit);
    } catch (e) {
      throw _handleException(e);
    }
  }

  @override
  Future<List<ProductApiModel>> getBannerProducts(String banner) {
    try {
      // fetch products based on section
      return getProducts(limit: 20);
    } catch (e) {
      throw _handleException(e);
    }
  }

  @override
  Future<List<AdBannerModel>> getBanners() async {
    try {
      await Future.delayed(const Duration(seconds: 3));
      final jsonString = await rootBundle.loadString(JsonAssets.banner);
      final List<dynamic> jsonList = json.decode(jsonString);

      return jsonList.map((json) {
        return AdBannerModel.fromJson(json);
      }).toList();
    } catch (e) {
      throw _handleException(e);
    }
  }

  ///
  AppException _handleException(Object e) {
    if (e is AppException) {
      return e;
    } else if (e is Exception) {
      return e.toAppException();
    } else {
      return AppException.custom('Unknown error occurred: $e');
    }
  }
}
