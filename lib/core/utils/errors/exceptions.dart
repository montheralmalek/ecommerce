import 'dart:io';

import 'package:dio/dio.dart';

/// Base class for all custom exceptions
abstract class AppException implements Exception {
  final String message;
  final StackTrace? stackTrace;

  const AppException(this.message, [this.stackTrace]);

  // Factory constructors for specific exceptions

  const factory AppException.networkException(
    ErrorType type,
    String message, [
    StackTrace? stackTrace,
  ]) = NetworkException;
  const factory AppException.dataException(
    String message, [
    StackTrace? stackTrace,
  ]) = DataException;
  const factory AppException.businessException(
    String message, [
    StackTrace? stackTrace,
  ]) = BusinessException;
  const factory AppException.uiException(
    String message, [
    StackTrace? stackTrace,
  ]) = UIException;
  const factory AppException.platformSpecificException(
    String platform,
    String message, [
    StackTrace? stackTrace,
  ]) = PlatformSpecificException;

  const factory AppException.custom(String message, [StackTrace? stackTrace]) =
      CustomException;
  @override
  String toString() => message;
}

/// Custom exception
/// This exception is used to handle custom errors
/// that do not fall into any of the other categories.
/// It can be used to represent any error that occurs
/// in the application.
class CustomException extends AppException {
  const CustomException(super.message, [super.stackTrace]);

  @override
  String toString() => 'CustomException: $message';
}

/// Specialized exceptions [AppException]
///
/// These exceptions are used to handle errors that occur
/// in specific platforms or environments.
/// They are typically used to indicate that a specific
/// platform-specific error has occurred.
class PlatformSpecificException extends AppException {
  final String platform;
  const PlatformSpecificException(
    this.platform,
    String message, [
    StackTrace? stackTrace,
  ]) : super(message, stackTrace);
}
// -----------------------------------------------
// Network-related exceptions
// -----------------------------------------------

/// Enum for network error types
/// This enum categorizes different types of network errors
/// that can occur during API requests.
enum ErrorType {
  noInternet,
  timeout,
  badRequest,
  unauthorized,
  forbidden,
  notFound,
  conflict,
  server,
  unknown,
}

/// Network-related exceptions
class NetworkException extends AppException {
  final ErrorType type;

  const NetworkException(this.type, String message, [StackTrace? stackTrace])
    : super(message, stackTrace);

  /// Factory constructors for specific network exceptions
  const factory NetworkException.noInternet([
    String? message,
    StackTrace? stackTrace,
  ]) = NoInternetException;
  const factory NetworkException.timeout([
    String? message,
    StackTrace? stackTrace,
  ]) = TimeoutException;
  const factory NetworkException.badRequest([
    String? message,
    StackTrace? stackTrace,
  ]) = BadRequestException;
  const factory NetworkException.unauthorized([
    String? message,
    StackTrace? stackTrace,
  ]) = UnauthorizedException;
  const factory NetworkException.forbidden([
    String? message,
    StackTrace? stackTrace,
  ]) = ForbiddenException;
  const factory NetworkException.notFound([
    String? message,
    StackTrace? stackTrace,
  ]) = NotFoundException;
  const factory NetworkException.conflict([
    String? message,
    StackTrace? stackTrace,
  ]) = ConflictException;
  const factory NetworkException.server(
    String message, [
    int? statusCode,
    StackTrace? stackTrace,
  ]) = ServerException;
  const factory NetworkException.custom(
    ErrorType type,
    String message, [
    StackTrace? stackTrace,
  ]) = NetworkException;
  @override
  String toString() {
    return 'NetworkException: $message (type: $type)';
  }
}

/// No internet connection exception [NetworkException]
///
/// This exception is used to handle errors that occur
/// when there is no internet connection available.
class NoInternetException extends NetworkException {
  const NoInternetException([String? message, StackTrace? stackTrace])
    : super(
        ErrorType.noInternet,
        message ?? 'No internet connection available',
        stackTrace,
      );
}

/// Timeout exception [NetworkException]
///
/// This exception is used to handle errors that occur
/// when a request times out.
class TimeoutException extends NetworkException {
  const TimeoutException([String? message, StackTrace? stackTrace])
    : super(ErrorType.timeout, message ?? 'Request timed out', stackTrace);
}

///// Bad request exception [NetworkException]
///
/// This exception is used to handle errors that occur
/// when a request is invalid or malformed.
class BadRequestException extends NetworkException {
  const BadRequestException([String? message, StackTrace? stackTrace])
    : super(ErrorType.badRequest, message ?? 'Bad request', stackTrace);
}

///// Unauthorized exception [NetworkException]
///
/// This exception is used to handle errors that occur
/// when authentication fails or the user is not authorized
/// to access a resource.
class UnauthorizedException extends NetworkException {
  const UnauthorizedException([String? message, StackTrace? stackTrace])
    : super(
        ErrorType.unauthorized,
        message ?? 'Authentication failed',
        stackTrace,
      );
}

/// Forbidden exception [NetworkException]
///
/// This exception is used to handle errors that occur
/// when the user does not have permission to access a resource.
/// It typically indicates that the user is authenticated
/// but does not have the necessary permissions to perform
/// the requested action.
class ForbiddenException extends NetworkException {
  const ForbiddenException([String? message, StackTrace? stackTrace])
    : super(ErrorType.forbidden, message ?? 'Access denied', stackTrace);
}

/// Not found exception [NetworkException]
///
/// This exception is used to handle errors that occur
/// when a requested resource is not found.
/// It typically indicates that the requested resource
/// does not exist or is not available.
class NotFoundException extends NetworkException {
  const NotFoundException([String? message, StackTrace? stackTrace])
    : super(
        ErrorType.notFound,
        message ?? 'Requested resource not found',
        stackTrace,
      );
}

/// Conflict exception [NetworkException]
///
/// This exception is used to handle errors that occur
/// when there is a conflict with the current state
/// of the resource.
/// It typically indicates that the request could not
/// be completed due to a conflict with the current
/// state of the resource.
/// For example, trying to update a resource that has
/// been modified by another user or process.
/// This exception is typically used in scenarios
/// where multiple users or processes are trying to
/// modify the same resource at the same time.
class ConflictException extends NetworkException {
  const ConflictException([String? message, StackTrace? stackTrace])
    : super(
        ErrorType.conflict,
        message ?? 'Resource conflict occurred',
        stackTrace,
      );
}

/// Server exception [NetworkException]
///
/// This exception is used to handle errors that occur
/// when the server responds with an error.
/// It typically indicates that the server encountered
/// an error while processing the request.
/// This exception is typically used in scenarios
/// where the server is unable to fulfill the request
/// due to an internal error or misconfiguration.
class ServerException extends NetworkException {
  final int? statusCode;

  const ServerException(
    String message, [
    this.statusCode,
    StackTrace? stackTrace,
  ]) : super(ErrorType.server, message, stackTrace);
}

// -----------------------------------------------
// Data-related exceptions
// -----------------------------------------------
/// Data-related exceptions
/// These exceptions are used to handle errors that occur
/// during data processing, such as parsing errors,
/// database errors, or cache-related errors.
class DataException extends AppException {
  const DataException(super.message, [super.stackTrace]);

  /// Factory constructors for specific data exceptions
  const factory DataException.cache(String message, [StackTrace? stackTrace]) =
      CacheException;
  const factory DataException.parsing(
    String message, [
    StackTrace? stackTrace,
  ]) = ParsingException;
  const factory DataException.database(
    String message, [
    StackTrace? stackTrace,
  ]) = DatabaseException;

  @override
  String toString() {
    return 'DataException: $message';
  }
}

/// Cache-related exceptions [DataException]
///
/// These exceptions are used to handle errors that occur
/// during cache operations, such as reading or writing
/// data to the cache.
class CacheException extends DataException {
  const CacheException(super.message, [super.stackTrace]);
}

/// Parsing-related exceptions [DataException]
///
/// These exceptions are used to handle errors that occur
/// during data parsing, such as JSON parsing errors
/// or data format errors.
class ParsingException extends DataException {
  const ParsingException(super.message, [super.stackTrace]);
}

/// Database-related exceptions[DataException]
///
/// These exceptions are used to handle errors that occur
/// during database operations, such as reading or writing
/// data to the database.
class DatabaseException extends DataException {
  const DatabaseException(super.message, [super.stackTrace]);
}

// --------------------------------------------------------
// Business logic exceptions
// --------------------------------------------------------
/// Business logic exceptions
/// These exceptions are used to handle errors that occur
/// during business logic operations, such as validation
/// errors or insufficient permissions.
/// They are typically used to indicate that a specific
/// business rule has been violated or that the user
/// does not have the necessary permissions to perform
/// a certain action.
class BusinessException extends AppException {
  const BusinessException(super.message, [super.stackTrace]);

  // Factory constructors for specific business exceptions

  const factory BusinessException.validation(
    String message, [
    StackTrace? stackTrace,
  ]) = ValidationException;
  const factory BusinessException.insufficientPermissions([
    StackTrace? stackTrace,
  ]) = InsufficientPermissionsException;
  const factory BusinessException.operationNotAllowed([
    StackTrace? stackTrace,
  ]) = OperationNotAllowedException;
  const factory BusinessException.custom(
    String message, [
    StackTrace? stackTrace,
  ]) = BusinessException;

  @override
  String toString() {
    return 'BusinessException: $message';
  }
}

//// Validation exceptions [BusinessException]
///
/// These exceptions are used to handle errors that occur
/// when the input data does not meet the required
/// validation criteria.
class ValidationException extends BusinessException {
  const ValidationException(super.message, [super.stackTrace]);

  @override
  String toString() {
    return 'ValidationException: $message';
  }
}

/// Insufficient permissions exceptions [BusinessException]
/// These exceptions are used to handle errors that occur
/// when a user does not have the necessary permissions
/// to perform a certain action.
/// They are typically used to indicate that the user
/// does not have the required role or access level
/// to perform a specific operation.
/// For example, trying to access a resource
/// that the user does not have permission to access
class InsufficientPermissionsException extends BusinessException {
  const InsufficientPermissionsException([StackTrace? stackTrace])
    : super('Insufficient permissions', stackTrace);
}

/// Operation not allowed exceptions [BusinessException]
/// These exceptions are used to handle errors that occur
/// when a specific operation is not allowed.
/// They are typically used to indicate that the user
/// is trying to perform an operation that is not
/// permitted by the system or business rules.
/// For example, trying to delete a resource that is
/// protected or trying to access a resource that is
/// not available.
class OperationNotAllowedException extends BusinessException {
  const OperationNotAllowedException([StackTrace? stackTrace])
    : super('Operation not allowed', stackTrace);
}

// --------------------------------------------------------
// UI-related exceptions
// --------------------------------------------------------
/// UI-related exceptions [AppException]
class UIException extends AppException {
  const UIException(super.message, [super.stackTrace]);

  /// Factory constructors for specific UI exceptions
  const factory UIException.route(String message, [StackTrace? stackTrace]) =
      RouteException;
  const factory UIException.custom(String message, [StackTrace? stackTrace]) =
      UIException;

  @override
  String toString() {
    return 'UIException: $message';
  }
}

/// Route-related exceptions [UIException]
///
/// These exceptions are used to handle errors that occur
/// during routing operations, such as navigation errors
/// or invalid route parameters.
class RouteException extends UIException {
  const RouteException(super.message, [super.stackTrace]);
}

// --------------------------------------------------------
// Extensions
// --------------------------------------------------------

/// Extension for Exception to convert to our custom exceptions
extension ExceptionExtension on Exception {
  AppException toAppException() {
    if (this is DioException) {
      return (this as DioException).toAppException();
    } else if (this is SocketException) {
      return NoInternetException();
    } else if (this is FormatException) {
      return ParsingException('Invalid format');
    } else if (this is HttpException) {
      return ServerException('HTTP error');
    } else if (this is AppException) {
      return this as AppException;
    } else {
      return CacheException('Unknown error 22');
    }
  }
}

/// Extension for DioException to convert to our custom exceptions
extension DioExceptionExtension on DioException {
  AppException toAppException() {
    switch (type) {
      case DioExceptionType.connectionTimeout:
        return TimeoutException(null, stackTrace);
      case DioExceptionType.sendTimeout:
        return TimeoutException(null, stackTrace);
      case DioExceptionType.receiveTimeout:
        return TimeoutException(null, stackTrace);
      case DioExceptionType.badResponse:
        return _handleBadResponse(this);
      case DioExceptionType.cancel:
        return BusinessException('Request cancelled', stackTrace);
      case DioExceptionType.connectionError:
        return NoInternetException(null, stackTrace);
      case DioExceptionType.unknown:
        return NetworkException(
          ErrorType.noInternet,
          message ?? 'Unknown Dio  error',
          stackTrace,
        );
      default:
        return NetworkException(
          ErrorType.noInternet,
          message ?? 'Unknown error',
          stackTrace,
        );
    }
  }

  /// Handle DioException with a bad response
  AppException _handleBadResponse(DioException e) {
    final statusCode = e.response?.statusCode;
    final message =
        e.response?.data ?? 'Server error (statusCode: $statusCode)';

    switch (statusCode) {
      case 400:
        return BadRequestException(message, stackTrace);
      case 401:
        return UnauthorizedException(message, stackTrace);
      case 403:
        return ForbiddenException(message, stackTrace);
      case 404:
        return NotFoundException(message, stackTrace);
      case 409:
        return ConflictException(message, stackTrace);
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
