part of 'auth_cubit.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class LoginSuccess extends AuthState {
  final String message;
  LoginSuccess(this.message);
}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}

class LogoutSuccess extends AuthState {
  final String message;
  LogoutSuccess(this.message);
}

class Authenticated extends AuthState {
  final String token;
  Authenticated(this.token);
}

class Unauthenticated extends AuthState {
  final String message;
  Unauthenticated(this.message);
}
