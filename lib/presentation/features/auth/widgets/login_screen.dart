import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:store/core/config/dependency_injection.dart';
import 'package:store/data/repositories/auth_repository.dart';
import 'package:store/presentation/features/auth/cubits/auth_cubit.dart';
import 'package:store/presentation/features/auth/widgets/login_form.dart';
import 'package:store/presentation/features/auth/viewmodel/login_viewmodel.dart';

class LoginScreen extends StatelessWidget {
  static const id = '/login';
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final viewmodel = LoginViewModel(
      authRepository: getIt<AuthRepository>(),
      loginCubit: context.read<AuthCubit>(),
    );

    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: context.watch<AuthCubit>().state is AuthLoading,
        progressIndicator:
            Platform.isIOS
                ? const CupertinoActivityIndicator()
                : const CircularProgressIndicator(),
        child: SafeArea(
          minimum: EdgeInsets.all(10),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                spacing: 20,
                children: [
                  ///----------------------------------------------
                  /// -------------- Image ---------------------------
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    child: Icon(
                      Icons.lock_outline,
                      size: 70,
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                  ),
                  Text(
                    'Welcome Back',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),

                  ///----------------------------------------------
                  /// -------------- login form ---------------------------
                  LoginForm(loginViewModel: viewmodel),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
