import 'package:dio/dio.dart';
import 'package:store/core/utils/exceptions/app_exceptions.dart';

/// Extension for DioException to convert to our custom exceptions
extension DioExceptionExtension on DioException {
  AppException toAppException() {
    switch (type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return TimeoutException();
      case DioExceptionType.badResponse:
        return _handleBadResponse(this);
      case DioExceptionType.cancel:
        return NetworkException.requestCanceled();
      case DioExceptionType.connectionError:
        return NoInternetException();
      case DioExceptionType.unknown:
        return NetworkException.unknown();
      default:
        return NetworkException.unknown();
    }
  }

  /// Handle DioException with a bad response
  AppException _handleBadResponse(DioException e) {
    final statusCode = e.response?.statusCode;

    switch (statusCode) {
      case 400:
        return BadRequestException();
      case 401:
        return UnauthorizedException();
      case 403:
        return ForbiddenException();
      case 404:
        return NotFoundException();
      case 409:
        return ConflictException();
      case 500:
      case 501:
      case 502:
      case 503:
        return ServerException();
      default:
        return UnknownNetworkException();
    }
  }
}
