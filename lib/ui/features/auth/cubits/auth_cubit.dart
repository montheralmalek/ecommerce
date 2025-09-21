import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/data/repositories/auth_repository/auth_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;

  AuthCubit({required AuthRepository authRepository})
    : _authRepository = authRepository,
      super(AuthInitial());

  Future<void> login(String userName, String password) async {
    if (state is AuthLoading) {
      return; // Prevent multiple loading states
    }
    emit(AuthLoading());
    try {
      final result = await _authRepository.login(
        userName: userName,
        password: password,
      );
      result.where(
        onSuccess: (data) => emit(Authenticated('Login successful')),
        onFailure: (error) => emit(AuthError(error.toString())),
      );
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> logout() async {
    if (state is AuthLoading) {
      return; // Prevent multiple loading states
    }
    emit(AuthLoading());
    try {
      final result = await _authRepository.logout();
      result.where(
        onSuccess: (data) => emit(Unauthenticated('Logedout successful')),
        onFailure: (error) => emit(AuthError(error.toString())),
      );
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  void reset() {
    emit(AuthInitial());
  }
}
