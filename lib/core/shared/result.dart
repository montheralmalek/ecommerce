import 'app_error.dart';

class Result<T> {
  // Holds the data for a successful result
  T? _data;
  // Holds the error information if the result is a failure.
  AppError? _error;

  bool get isSuccessful => _error == null;

  Result.success({T? data}) : _data = data;

  Result.failure(AppError error) : _error = error;

  /// Executes either the `success` or `failure` callback based on the result state.
  ///
  /// If the result is successful, the `success` callback is executed with the data.
  /// If the result is a failure, the `failure` callback is executed with the error.
  void when({
    required void Function(T? data) success,
    required void Function(AppError error) failure,
  }) {
    if (isSuccessful) {
      success(_data);
    } else {
      failure(_error as AppError);
    }
  }
}
