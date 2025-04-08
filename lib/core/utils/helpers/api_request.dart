import 'dart:io';

import 'package:dio/dio.dart';

class ApiRequest {
  final Dio _dio = Dio();
  Response? _response;
  Future<Response> get({required String httpUrl}) async {
    try {
      _response = await _dio.get(httpUrl);

      return _response!;
    } on DioException catch (e) {
      throw Exception('DioException: ${_response?.statusCode} $e');
    } on SocketException {
      throw Exception('Connection Error');
    } catch (e) {
      throw Exception('ERROR: ${_response?.statusCode} $e');
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
}
