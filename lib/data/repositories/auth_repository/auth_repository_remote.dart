import 'package:logging/logging.dart';
import 'package:store/core/utils/errors/app_errors.dart';
import 'package:store/core/utils/errors/exceptions.dart';
import 'package:store/core/utils/result.dart';
import 'package:store/data/repositories/auth_repository/auth_repository.dart';
import 'package:store/data/services/remote/auth_api_client.dart';
import 'package:store/data/services/remote/models/login_request.dart';
import 'package:store/data/shared_preferences_service.dart';

class AuthRepositoryRemote implements AuthRepository {
  final AuthApi _remoteAuthService;
  final SharedPreferencesService _sharedPreferencesService;
  AuthRepositoryRemote({
    required AuthApi remoteAuthService,
    required SharedPreferencesService sharedPreferencesService,
  }) : _remoteAuthService = remoteAuthService,
       _sharedPreferencesService = sharedPreferencesService;

  bool _isAuthenticated = false;

  String? _authToken;
  final _log = Logger('AuthRepositoryRemote');

  /// Fetch token from shared preferences
  Future<void> _fetch() async {
    final result = await _sharedPreferencesService.fetchToken();
    switch (result) {
      case Success<String?>():
        _authToken = result.value;
        _isAuthenticated = result.value != null;
      case Failure<String?>():
        _log.severe(
          'Failed to fech Token from SharedPreferences',
          result.error,
        );
    }
  }

  @override
  Future<bool> get isAuthenticated async {
    await _fetch();
    return _isAuthenticated;
  }

  @override
  Future<Result<void>> login({
    required String userName,
    required String password,
  }) async {
    try {
      final loginRequest = LoginRequest(username: userName, password: password);
      final loginResponse = await _remoteAuthService.login(loginRequest);

      return loginResponse.asyncWhere(
        onSuccess: (value) async {
          _log.info('User logged in');
          // Set auth status
          _isAuthenticated = true;
          _authToken = loginResponse.successValue?.token;
          // Store in Shared preferences
          return await _sharedPreferencesService.saveToken(_authToken);
        },
        onFailure: (error) async {
          _log.warning('Error logging in: ${error.message}');
          return Result.failure(error);
        },
      );
    } on Exception catch (e) {
      _log.warning('Error logging in: ${e.toString()}');
      return Result.failure(e.toAppException().toError());
    }
  }

  @override
  Future<Result<void>> logout() async {
    try {
      // await _remoteAuthService.logout();
      // Clear stored auth token
      final result = await _sharedPreferencesService.saveToken(null);
      if (result is Failure<void>) {
        _log.severe('Failed to clear stored auth token');
      }

      // Clear token in ApiClient
      _authToken = null;

      // Clear authenticated status
      _isAuthenticated = false;
      return result;
    } catch (e) {
      return Result.failure(NetworkError('Failed to log out'));
    }
  }
}

// class AuthRepositoryRemote extends AuthRepository {
//   AuthRepositoryRemote({
//     required ApiClient apiClient,
//     required AuthApiClient authApiClient,
//     required SharedPreferencesService sharedPreferencesService,
//   }) : _apiClient = apiClient,
//        _authApiClient = authApiClient,
//        _sharedPreferencesService = sharedPreferencesService {
//     _apiClient.authHeaderProvider = _authHeaderProvider;
//   }

//   final AuthApiClient _authApiClient;
//   final AuthApi _apiClient;
//   final SharedPreferencesService _sharedPreferencesService;

//   bool? _isAuthenticated;
//   String? _authToken;
//   final _log = Logger('AuthRepositoryRemote');

//   // /// Fetch token from shared preferences
//   // Future<void> _fetch() async {
//   //   final result = await _sharedPreferencesService.fetchToken();
//   //   switch (result) {
//   //     case Ok<String?>():
//   //       _authToken = result.value;
//   //       _isAuthenticated = result.value != null;
//   //     case Error<String?>():
//   //       _log.severe(
//   //         'Failed to fech Token from SharedPreferences',
//   //         result.error,
//   //       );
//   //   }
//   // }

//   // @override
//   // Future<bool> get isAuthenticated async {
//   //   // Status is cached
//   //   if (_isAuthenticated != null) {
//   //     return _isAuthenticated!;
//   //   }
//   //   // No status cached, fetch from storage
//   //   await _fetch();
//   //   return _isAuthenticated ?? false;
//   // }

//   @override
//   Future<Result<void>> login({
//     required String email,
//     required String password,
//   }) async {
//     try {
//       final result = await _authApiClient.login(
//         LoginRequest(email: email, password: password),
//       );
//       switch (result) {
//         case Ok<LoginResponse>():
//           _log.info('User logged int');
//           // Set auth status
//           _isAuthenticated = true;
//           _authToken = result.value.token;
//           // Store in Shared preferences
//           return await _sharedPreferencesService.saveToken(result.value.token);
//         case Error<LoginResponse>():
//           _log.warning('Error logging in: ${result.error}');
//           return Result.error(result.error);
//       }
//     } finally {
//       notifyListeners();
//     }
//   }

//   @override
//   Future<Result<void>> logout() async {
//     _log.info('User logged out');
//     try {
//       // Clear stored auth token
//       final result = await _sharedPreferencesService.saveToken(null);
//       if (result is Error<void>) {
//         _log.severe('Failed to clear stored auth token');
//       }

//       // Clear token in ApiClient
//       _authToken = null;

//       // Clear authenticated status
//       _isAuthenticated = false;
//       return result;
//     } finally {
//       notifyListeners();
//     }
//   }

//   String? _authHeaderProvider() =>
//       _authToken != null ? 'Bearer $_authToken' : null;
// }
