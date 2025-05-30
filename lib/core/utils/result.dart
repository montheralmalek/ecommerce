// This file defines a generic Result class that can represent either a success or a failure.
// It provides a way to handle asynchronous operations and their outcomes in a type-safe manner.
// The Result class has two subclasses: Success and Failure.
import 'package:store/core/utils/errors/app_errors.dart';

sealed class Result<T> {
  const Result();

  const factory Result.success(T value) = Success<T>;
  const factory Result.failure(AppError error) = Failure<T>;

  /// Executes the appropriate callback based on whether the result is a success or failure.
  /// - [onSuccess] is called if the result is a success, with the success value.
  /// - [onFailure] is called if the result is a failure, with the error.
  R where<R>({
    required R Function(T) onSuccess,
    required R Function(AppError) onFailure,
  });

  /// Returns `true` if the result is a success.
  bool get isSuccess => this is Success<T>;

  /// Returns `true` if the result is a failure.
  bool get isFailure => this is Failure<T>;

  /// Handles asynchronous callbacks for success and failure cases.
  /// - [onSuccess] is called if the result is a success, with the success value.
  /// - [onFailure] is called if the result is a failure, with the error.
  Future<R> asyncWhere<R>({
    required Future<R> Function(T) onSuccess,
    required Future<R> Function(AppError) onFailure,
  });
}

/// Represents a successful result with a value of type [T].
final class Success<T> extends Result<T> {
  final T value;
  const Success(this.value);

  @override
  R where<R>({
    required R Function(T) onSuccess,
    required R Function(AppError) onFailure,
  }) => onSuccess(value);

  @override
  Future<R> asyncWhere<R>({
    required Future<R> Function(T) onSuccess,
    required Future<R> Function(AppError) onFailure,
  }) => onSuccess(value);
}

/// Represents a failure result with an error of type [AppError].
final class Failure<T> extends Result<T> {
  final AppError error;
  const Failure(this.error);

  @override
  R where<R>({
    required R Function(T) onSuccess,
    required R Function(AppError) onFailure,
  }) => onFailure(error);

  @override
  Future<R> asyncWhere<R>({
    required Future<R> Function(T) onSuccess,
    required Future<R> Function(AppError) onFailure,
  }) => onFailure(error);
}

/// Extension methods for the Result class to provide additional functionality.
/// These methods allow for easier handling of success and failure cases.
/// - `successValue`: Retrieves the success value if present.
/// - `failureValue`: Retrieves the failure error if present.
/// - `mapSuccess`: Maps the success value to a new type.
/// - `getOrElse`: Returns the success value or a default value if failure.
extension ResultExtensions<T> on Result<T> {
  T? get successValue =>
      where(onSuccess: (value) => value, onFailure: (_) => null);

  AppError? get failureValue =>
      where(onSuccess: (_) => null, onFailure: (error) => error);

  Result<R> mapSuccess<R>(R Function(T) mapper) {
    return where(
      onSuccess: (value) => Result.success(mapper(value)),
      onFailure: (error) => Result.failure(error),
    );
  }

  T getOrElse(T Function(AppError) orElse) {
    return where(onSuccess: (value) => value, onFailure: orElse);
  }
}

/// Extension methods for chaining operations on Result.
/// These methods allow for transforming the result or handling failures.
/// - `then`: Transforms the success value to a new Result.
/// - `onFailure`: Handles the failure case with a provided function.
extension ResultChainExtensions<T> on Result<T> {
  Result<R> then<R>(Result<R> Function(T) mapper) {
    return where(onSuccess: mapper, onFailure: Result.failure);
  }

  Result<T> onFailure(Function(AppError) handler) {
    return where(
      onSuccess: Result.success,
      onFailure: (error) {
        handler(error);
        return Result.failure(error);
      },
    );
  }
}
