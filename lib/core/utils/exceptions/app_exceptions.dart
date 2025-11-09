import 'dart:io';

import 'package:dio/dio.dart';
import 'package:store/core/utils/exceptions/dio_exception_mapper.dart';
import 'package:store/core/utils/errors/errors_messages.dart';

/// Base class for all custom exceptions
abstract class AppException implements Exception {
  final String message;
  final StackTrace? stackTrace;

  const AppException(this.message, [this.stackTrace]);

  // Factory constructors for specific exceptions

  const factory AppException.networkException(
    ErrorType type,
    String message, [
    int? statusCode,
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
  requestCanceled,
  unknown,
}

/// Network-related exceptions
class NetworkException extends AppException {
  final ErrorType type;
  final int? statusCode;

  const NetworkException(this.type, String message, [this.statusCode])
    : super(message);

  /// Factory constructors for specific network exceptions
  factory NetworkException.noInternet() = NoInternetException;
  factory NetworkException.timeout() = TimeoutException;
  factory NetworkException.badRequest() = BadRequestException;
  factory NetworkException.unauthorized() = UnauthorizedException;
  factory NetworkException.forbidden() = ForbiddenException;
  factory NetworkException.notFound() = NotFoundException;
  factory NetworkException.conflict() = ConflictException;
  factory NetworkException.server() = ServerException;
  factory NetworkException.requestCanceled() = RequestCanceledException;
  factory NetworkException.unknown() = UnknownNetworkException;

  //
  @override
  String toString() {
    return 'NetworkException: $message (type: $type)';
  }
}

/// No internet connection exception [NetworkException]
///
/// This exception is used to handle errors that occur
/// when there is no internet connection available.
class NoInternetException implements NetworkException {
  @override
  String get message => ErrorsMessages.noInternet;

  @override
  StackTrace? get stackTrace => throw UnimplementedError();

  @override
  // TODO: implement statusCode
  int? get statusCode => throw UnimplementedError();

  @override
  ErrorType get type => ErrorType.server;
}

/// Timeout exception [NetworkException]
///
/// This exception is used to handle errors that occur
/// when a request times out.
class TimeoutException implements NetworkException {
  @override
  String get message => ErrorsMessages.timeout;

  @override
  StackTrace? get stackTrace => throw UnimplementedError();

  @override
  // TODO: implement statusCode
  int? get statusCode => throw UnimplementedError();

  @override
  ErrorType get type => ErrorType.server;
}

///// Bad request exception [NetworkException]
///
/// This exception is used to handle errors that occur
/// when a request is invalid or malformed.
class BadRequestException implements NetworkException {
  @override
  String get message => ErrorsMessages.badRequest;

  @override
  StackTrace? get stackTrace => throw UnimplementedError();

  @override
  // TODO: implement statusCode
  int? get statusCode => throw UnimplementedError();

  @override
  ErrorType get type => ErrorType.server;
}

///// Unauthorized exception [NetworkException]
///
/// This exception is used to handle errors that occur
/// when authentication fails or the user is not authorized
/// to access a resource.
class UnauthorizedException implements NetworkException {
  @override
  String get message => ErrorsMessages.unauthorized;

  @override
  StackTrace? get stackTrace => throw UnimplementedError();

  @override
  // TODO: implement statusCode
  int? get statusCode => throw UnimplementedError();

  @override
  ErrorType get type => ErrorType.server;
}

/// Forbidden exception [NetworkException]
///
/// This exception is used to handle errors that occur
/// when the user does not have permission to access a resource.
/// It typically indicates that the user is authenticated
/// but does not have the necessary permissions to perform
/// the requested action.
class ForbiddenException implements NetworkException {
  @override
  String get message => ErrorsMessages.forbidden;

  @override
  StackTrace? get stackTrace => throw UnimplementedError();

  @override
  // TODO: implement statusCode
  int? get statusCode => throw UnimplementedError();

  @override
  ErrorType get type => ErrorType.server;
}

/// Not found exception [NetworkException]
///
/// This exception is used to handle errors that occur
/// when a requested resource is not found.
/// It typically indicates that the requested resource
/// does not exist or is not available.
class NotFoundException implements NetworkException {
  @override
  String get message => ErrorsMessages.notFound;

  @override
  StackTrace? get stackTrace => throw UnimplementedError();

  @override
  // TODO: implement statusCode
  int? get statusCode => throw UnimplementedError();

  @override
  ErrorType get type => ErrorType.server;
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
class ConflictException implements NetworkException {
  @override
  String get message => ErrorsMessages.conflict;

  @override
  StackTrace? get stackTrace => throw UnimplementedError();

  @override
  // TODO: implement statusCode
  int? get statusCode => throw UnimplementedError();

  @override
  ErrorType get type => ErrorType.server;
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
class ServerException implements NetworkException {
  @override
  String get message => ErrorsMessages.serverError;

  @override
  StackTrace? get stackTrace => throw UnimplementedError();

  @override
  // TODO: implement statusCode
  int? get statusCode => throw UnimplementedError();

  @override
  ErrorType get type => ErrorType.server;
}

/// UnknownNetworkException
class RequestCanceledException implements NetworkException {
  @override
  String get message => ErrorsMessages.canceled;

  @override
  StackTrace? get stackTrace => null;

  @override
  int? get statusCode => 0; // TODO: implement code

  @override
  ErrorType get type => ErrorType.requestCanceled;
}

/// UnknownNetworkException
class UnknownNetworkException implements NetworkException {
  @override
  String get message => ErrorsMessages.unknownError;

  @override
  StackTrace? get stackTrace => null;

  @override
  int? get statusCode => 0; // TODO: implement code

  @override
  ErrorType get type => ErrorType.unknown;
}

// Authentication exceptions
class AuthenticationException extends AppException {
  AuthenticationException(super.message);
}

class InvalidCredentialsException extends AuthenticationException {
  InvalidCredentialsException([StackTrace? stackTrace])
    : super(ErrorsMessages.invalidLoginData);
}

class TokenExpiredException extends AuthenticationException {
  TokenExpiredException([StackTrace? stackTrace])
    : super(ErrorsMessages.tokenExpired);
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

/// Extension for Exception to convert to AppException
extension ExceptionExtension on Exception {
  AppException toAppException() {
    if (this is AppException) return this as AppException;
    if (this is DioException) {
      return (this as DioException).toAppException();
    } else if (this is SocketException) {
      return NoInternetException();
    } else if (this is FormatException) {
      return ParsingException('Invalid format');
    } else if (this is HttpException) {
      return ServerException();
    } else if (this is AppException) {
      return this as AppException;
    } else {
      return CacheException('Unknown error 22');
    }
  }
}
