import 'exceptions.dart';

abstract class AppError {
  final String message;

  final StackTrace? stackTrace;

  const AppError(this.message, [this.stackTrace]);
  factory AppError.fromException(Exception exception) =>
      exception.toAppException().toError();

  @override
  String toString() => message;
}

class NetworkError extends AppError {
  const NetworkError(super.message, [super.stackTrace]);
}

class DataError extends AppError {
  const DataError(super.message, [super.stackTrace]);
}

class BusinessError extends AppError {
  const BusinessError(super.message, [super.stackTrace]);
}

class UIError extends AppError {
  const UIError(super.message, [super.stacTrace]);
}

class UnknownError extends AppError {
  const UnknownError(super.message, [super.stackTrace]);
}

class CustomError extends AppError {
  const CustomError(super.message, [super.stackTrace]);
}

// Conversion from exceptions to failures
extension ExceptionToErrorMapper on AppException {
  AppError toError() {
    switch (this) {
      case NetworkException _:
        return NetworkError(message, stackTrace);
      case DataException _:
        return DataError(message, stackTrace);
      case BusinessException _:
        return BusinessError(message, stackTrace);
      case UIException _:
        return UIError(message, stackTrace);
      case CustomException _:
        return CustomError(message, stackTrace);
      default:
        return UnknownError(message, stackTrace);
    }
  }
}
