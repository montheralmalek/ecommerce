import 'package:logging/logging.dart';
import 'package:store/core/network/dio_client.dart';
import 'package:store/core/utils/errors/app_errors.dart';
import 'package:store/core/utils/errors/exceptions.dart';
import 'package:store/core/utils/result.dart';
import 'package:store/data/services/remote/models/login_request.dart';
import 'package:store/data/services/remote/models/login_response.dart';

abstract class AuthApi {
  Future<Result<LoginResponse>> login(LoginRequest loginRequest);
}

class AuthApiImp extends AuthApi {
  final DioClient _apiRequest;
  AuthApiImp(this._apiRequest) {
    _apiRequest.dio.options.baseUrl = 'https://fakestoreapi.com/auth';
    _apiRequest.dio.options.connectTimeout = const Duration(seconds: 30);
    _apiRequest.dio.options.receiveTimeout = const Duration(seconds: 30);
  }
  final _log = Logger('AuthApiImp');
  @override
  Future<Result<LoginResponse>> login(LoginRequest loginRequest) async {
    try {
      final response = await _apiRequest.post(
        '/login',
        data: loginRequest.toJson(),
      );
      _log.info('User logged in: ${response.data}');
      if (response.statusCode == 400) {
        return Result.failure(
          AppException.networkException(
            ErrorType.badRequest,
            'Login failed',
          ).toError(),
        );
      }
      return Result.success(LoginResponse.fromJson(response.data));
    } on Exception catch (error) {
      _log.severe('Failed to login', error);
      final AppError appError = AppError.fromException(error);
      _log.severe('Error: ${appError.toString()}');
      return Result.failure(appError);
    }
  }
}
