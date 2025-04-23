import 'dart:io';

import 'package:dio/dio.dart';
import 'package:store/core/constants/constant.dart';
import 'package:store/core/errors/app_errors.dart';
import 'package:store/core/errors/exceptions.dart';

class ApiRequest {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: kBaseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    ),
  );
  Response? _response;
  Future<Response> get(String endpoint, {Map<String, dynamic>? params}) async {
    try {
      _response = await _dio.get(endpoint, queryParameters: params);

      return _response!;
    } on DioException catch (e) {
      throw _handleDioError(e);
    } on SocketException {
      throw NetworkException(NetworkErrorType.noInternet, 'Connection Error');
    } catch (e) {
      throw UnknownError('ERROR: ${_response?.statusCode} $e');
    }
  }

  Future<Response> post({required String url, required Object data}) async {
    try {
      _response = await _dio.post(url, data: data);
      return _response!;
    } on DioException catch (e) {
      throw Exception('ERROR: ${_response?.statusCode} $e');
    } on SocketException {
      throw Exception('Connection Error');
    } catch (e) {
      throw Exception('ERROR: ${_response?.statusCode} $e');
    }
  }

  // Handle error function
  NetworkException _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return TimeoutException();
      case DioExceptionType.sendTimeout:
        return TimeoutException();
      case DioExceptionType.receiveTimeout:
        return TimeoutException();
      // case DioExceptionType.cancel:
      //   return BusinessException('Request cancelled');
      case DioExceptionType.connectionError:
        return NoInternetException();
      case DioExceptionType.badResponse:
        return ServerException(
          '${e.response?.statusCode ?? 500}, ${e.response?.statusMessage ?? 'Server error'}',
        );
      case DioExceptionType.unknown:
        return NetworkException(
          NetworkErrorType.noInternet,
          e.message ?? 'Unknown network error',
        );
      default:
        return NetworkException(
          NetworkErrorType.noInternet,
          e.message ?? 'Unknown network error',
        );
    }
  }
}


// class DioClient {
//   final Dio _dio = Dio(BaseOptions(
//     baseUrl: AppConstants.baseUrl,
//     connectTimeout: const Duration(seconds: 30),
//     receiveTimeout: const Duration(seconds: 30),
//   ));

//   Future<Response> get(String endpoint, {Map<String, dynamic>? params}) async {
//     try {
//       return await _dio.get(endpoint, queryParameters: params);
//     } on DioException catch (e) {
//       throw _handleError(e);
//     }
//   }

//   // Add POST, PUT, DELETE methods

  // dynamic _handleError(DioException error) {
  //   // Handle different error types
  //   throw ServerException(message: error.message ?? 'Unknown error');
  // }
// }