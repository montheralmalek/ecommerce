import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:logging/logging.dart';
import 'package:store/routing/routes.dart';
import 'package:store/data/repositories/auth_repository.dart';
import 'package:store/presentation/features/auth/cubits/auth_cubit.dart';

class LoginViewModel {
  LoginViewModel({
    required AuthRepository authRepository,
    required AuthCubit loginCubit,
  }) : _loginCubit = loginCubit,
       _authRepository = authRepository {
    userName = TextEditingController(text: 'johnd');
    password = TextEditingController(text: 'm38rmF\$');
  }

  final AuthRepository _authRepository;
  final AuthCubit _loginCubit;
  final _log = Logger('LoginViewModel');
  // ignore: unused_field
  final formKey = GlobalKey<FormState>();
  late TextEditingController userName;
  late TextEditingController password;

  Future<bool> get isAuthenticated async =>
      await _authRepository.isAuthenticated;

  void login(BuildContext context) async {
    reset();
    _log.info('Login button pressed');
    if (formKey.currentState?.validate() ?? false) {
      _log.info('Logging in with ${userName.text} and ${password.text}');
      await _loginCubit.login(userName.text, password.text);
      _handleLoginStates(context);
    }
  }

  void _handleLoginStates(BuildContext context) {
    switch (_loginCubit.state) {
      case AuthLoading():
        _log.info('Login in progress...');
        break;
      case Authenticated():
        _log.info('Login successful');
        goToHomeScreen(context);
        break;
      case Unauthenticated():
        _log.warning('Login failed');
        break;
      case AuthError():
        _log.severe('Error during login');
        break;
      default:
        _log.warning('Unknown state: ${_loginCubit.state}');
    }
  }

  void reset() {
    _loginCubit.reset();
  }

  void dispose() {
    userName.dispose();
    password.dispose();
  }

  void onCancel(BuildContext context) {
    // _loginCubit.reset();
    goToHomeScreen(context);
  }

  void goToHomeScreen(BuildContext context) {
    _log.info('Navigating to home screen');
    // Navigate to home screen

    context.goNamed(AppRoutes.home);
  }

  void onForgotPassword() {}

  void onSignup() {}

  void onSubmit() {}
}

extension on AuthState {
  void whenOrNull({
    required Null Function(dynamic message) authenticated,
    required Null Function(dynamic message) unauthenticated,
    required Null Function(dynamic message) error,
  }) {}
}
