import 'exceptions.dart';

abstract class AppError {
  final String message;
  final StackTrace? stackTrace;

  const AppError(this.message, [this.stackTrace]);

  @override
  String toString() => message;
}

class NetworkError extends AppError {
  const NetworkError(super.message, [super.stackTrace]);
}

class CacheError extends AppError {
  const CacheError(super.message, [super.stackTrace]);
}

class ServerError extends AppError {
  final int? statusCode;

  const ServerError(super.message, [this.statusCode, super.stackTrace]);

  @override
  String toString() {
    return 'ServerFailure: $message (statusCode: $statusCode)';
  }
}

class ValidationError extends AppError {
  // final Map<String, String> errors;

  const ValidationError(super.message, [super.stackTrace]);
  // (
  //   this.errors, {
  //   String message = 'Validation failed',
  //   StackTrace? stackTrace,
  // }) : super(message, stackTrace);

  @override
  String toString() {
    return 'ValidationError: $message';
  }
}

class UnknownError extends AppError {
  const UnknownError(super.message, [super.stackTrace]);
}

// Conversion from exceptions to failures
extension ExceptionToErrorMapper on AppException {
  AppError toError() {
    if (this is NetworkException) {
      return NetworkError(message, stackTrace);
    } else if (this is CacheException) {
      return CacheError(message, stackTrace);
    } else if (this is ServerException) {
      return ServerError(
        message,
        (this as ServerException).statusCode,
        stackTrace,
      );
    } else if (this is ValidationException) {
      return ValidationError((this as ValidationException).message, stackTrace);
    }
    return UnknownError(message, stackTrace);
  }
}
