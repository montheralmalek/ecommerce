import 'dart:io';

import 'package:dio/dio.dart';

/// Base class for all custom exceptions
abstract class AppException implements Exception {
  final String message;
  final StackTrace? stackTrace;

  const AppException(this.message, [this.stackTrace]);

  @override
  String toString() => message;
}

/// Network-related exceptions
class NetworkException extends AppException {
  final NetworkErrorType type;

  const NetworkException(this.type, String message, [StackTrace? stackTrace])
    : super(message, stackTrace);
}

enum NetworkErrorType {
  noInternet,
  timeout,
  badRequest,
  unauthorized,
  forbidden,
  notFound,
  conflict,
}

class NoInternetException extends NetworkException {
  const NoInternetException([StackTrace? stackTrace])
    : super(
        NetworkErrorType.noInternet,
        'No internet connection available',
        stackTrace,
      );
}

class TimeoutException extends NetworkException {
  const TimeoutException([StackTrace? stackTrace])
    : super(NetworkErrorType.timeout, 'Request timed out', stackTrace);
}

class BadRequestException extends NetworkException {
  const BadRequestException([StackTrace? stackTrace])
    : super(NetworkErrorType.badRequest, 'Bad request', stackTrace);
}

class UnauthorizedException extends NetworkException {
  const UnauthorizedException([StackTrace? stackTrace])
    : super(NetworkErrorType.unauthorized, 'Authentication failed', stackTrace);
}

class ForbiddenException extends NetworkException {
  const ForbiddenException([StackTrace? stackTrace])
    : super(NetworkErrorType.forbidden, 'Access denied', stackTrace);
}

class NotFoundException extends NetworkException {
  const NotFoundException([StackTrace? stackTrace])
    : super(
        NetworkErrorType.notFound,
        'Requested resource not found',
        stackTrace,
      );
}

class ConflictException extends NetworkException {
  const ConflictException([StackTrace? stackTrace])
    : super(
        NetworkErrorType.conflict,
        'Resource conflict occurred',
        stackTrace,
      );
}

class ServerException extends NetworkException {
  final int? statusCode;

  const ServerException(
    String message, [
    this.statusCode,
    StackTrace? stackTrace,
  ]) : super(NetworkErrorType.conflict, message, stackTrace);

  @override
  String toString() {
    return 'ServerException: $message (statusCode: $statusCode)';
  }
}

/// Data-related exceptions
class DataException extends AppException {
  const DataException(super.message, [super.stackTrace]);
}

class CacheException extends DataException {
  const CacheException(super.message, [super.stackTrace]);
}

class ParsingException extends DataException {
  const ParsingException(super.message, [super.stackTrace]);
}

class DatabaseException extends DataException {
  const DatabaseException(super.message, [super.stackTrace]);
}

/// Business logic exceptions
class BusinessException extends AppException {
  const BusinessException(super.message, [super.stackTrace]);
}

class ValidationException extends BusinessException {
  const ValidationException(super.message, [super.stackTrace]);
  // final Map<String, String> errors;

  // const ValidationException(
  //   this.errors, {
  //   String message = 'Validation failed',
  //   StackTrace? stackTrace,
  // }) : super(message, stackTrace);

  @override
  String toString() {
    return 'ValidationException: $message';
  }
}

class InsufficientPermissionsException extends BusinessException {
  const InsufficientPermissionsException([StackTrace? stackTrace])
    : super('Insufficient permissions', stackTrace);
}

class OperationNotAllowedException extends BusinessException {
  const OperationNotAllowedException([StackTrace? stackTrace])
    : super('Operation not allowed', stackTrace);
}

/// UI-related exceptions
class UIException extends AppException {
  const UIException(super.message, [super.stackTrace]);
}

class RouteException extends UIException {
  const RouteException(super.message, [super.stackTrace]);
}

/// Specialized exceptions
class PlatformSpecificException extends AppException {
  final String platform;

  const PlatformSpecificException(
    this.platform,
    String message, [
    StackTrace? stackTrace,
  ]) : super(message, stackTrace);
}

/// Extension for Exception to convert to our custom exceptions
extension ExceptionExtension on Exception {
  AppException toAppException() {
    if (this is DioException) {
      return (this as DioException).toAppException();
    } else if (this is SocketException) {
      return NoInternetException();
    } else if (this is TimeoutException) {
      return TimeoutException();
    } else if (this is FormatException) {
      return ParsingException('Invalid format');
    } else if (this is HttpException) {
      return ServerException('HTTP error');
    } else {
      return CacheException('Unknown error');
    }
  }
}

/// Extension for DioException to convert to our custom exceptions
extension DioExceptionExtension on DioException {
  AppException toAppException() {
    switch (type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return TimeoutException(stackTrace);
      case DioExceptionType.badResponse:
        return _handleBadResponse(this);
      case DioExceptionType.cancel:
        return BusinessException('Request cancelled', stackTrace);
      case DioExceptionType.connectionError:
        return NoInternetException(stackTrace);
      case DioExceptionType.unknown:
      default:
        return NetworkException(
          NetworkErrorType.noInternet,
          message ?? 'Unknown network error',
          stackTrace,
        );
    }
  }

  /// Handle DioException with a bad response
  AppException _handleBadResponse(DioException e) {
    final statusCode = e.response?.statusCode;
    final message =
        e.response?.statusMessage ?? 'Server error (statusCode: $statusCode)';

    switch (statusCode) {
      case 400:
        return BadRequestException(stackTrace);
      case 401:
        return UnauthorizedException(stackTrace);
      case 403:
        return ForbiddenException(stackTrace);
      case 404:
        return NotFoundException(stackTrace);
      case 409:
        return ConflictException(stackTrace);
      case 500:
      case 501:
      case 502:
      case 503:
        return ServerException(message, statusCode, stackTrace);
      default:
        return ServerException(
          'Server responded with $statusCode',
          statusCode,
          stackTrace,
        );
    }
  }
}
