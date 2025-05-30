import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final Connectivity connectivity;
  final Dio dio;
  NetworkInfoImpl(this.connectivity, {Dio? dio}) : dio = dio ?? Dio() {
    this.dio.options.connectTimeout = const Duration(seconds: 10);
    this.dio.options.receiveTimeout = const Duration(seconds: 10);
  }

  // NetworkInfoImpl(this.connectivity);

  @override
  Future<bool> get isConnected async {
    final connectivityResult = await connectivity.checkConnectivity();
    for (var connect in connectivityResult) {
      final result = _handelConnectivityResult(connect);

      return result ? await _checkInternetConnection() : false;
    }
    return false;
  }

  bool _handelConnectivityResult(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.none:
        return false;
      default:
        return true;
    }
  }

  Future<bool> _checkInternetConnection() async {
    try {
      Dio dio = Dio();
      final response = await dio.get('https://www.google.com');
      if (response.statusCode == 200) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
    return false;
  }
}
