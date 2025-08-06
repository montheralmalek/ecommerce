import 'package:store/core/utils/errors/app_errors.dart';
import 'package:store/core/utils/result.dart';

abstract class AuthRepository {
  /// Returns true when the user is logged in
  /// Returns [Future] because it will load a stored auth state the first time.
  Future<bool> get isAuthenticated;

  /// Perform login
  Future<Result<void>> login({
    required String userName,
    required String password,
  });

  /// Perform logout
  Future<Result<void>> logout();
}

class AuthRepositoryDev implements AuthRepository {
  /// User is always authenticated in dev scenarios
  @override
  Future<bool> get isAuthenticated => Future.value(true);

  /// Login is always successful in dev scenarios
  @override
  Future<Result<void>> login({
    required String userName,
    required String password,
  }) async {
    return const Result.success(null);
  }

  /// Logout is always successful in dev scenarios
  @override
  Future<Result<void>> logout() async {
    return const Result.success(null);
  }
}
