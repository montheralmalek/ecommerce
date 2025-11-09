import 'dart:io';

import 'package:dio/dio.dart';
import 'package:store/core/utils/exceptions/dio_exception_mapper.dart';
import 'package:store/core/utils/exceptions/app_exceptions.dart';

class DioClient {
  final Dio dio;

  Response? _response;
  DioClient(this.dio) {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.headers['Content-Type'] = 'application/json';
          options.headers['Accept'] = 'application/json';
          return handler.next(options);
        },
      ),
    );
  }
  Future<Response> get(String endpoint, {Map<String, dynamic>? params}) async {
    try {
      _response = await dio.get(endpoint, queryParameters: params);

      return _response!;
    } on Exception catch (e) {
      throw e.toAppException();
    } catch (e) {
      throw AppException.custom('Exception: ${_response?.statusCode} $e');
    }
  }

  // Post request
  Future<Response> post(String endpoint, {Map<String, dynamic>? data}) async {
    try {
      _response = await dio.post(endpoint, data: data);
      return _response!;
    } on Exception catch (e) {
      throw e.toAppException();
    } catch (e) {
      throw AppException.custom('ERROR00: $e');
    }
  }
}
