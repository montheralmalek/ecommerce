import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/ui/features/auth/cubits/auth_cubit.dart';
import 'package:store/ui/features/auth/widgets/auth_card.dart';
import 'package:store/ui/features/auth/viewmodel/login_viewmodel.dart';

import '../../../../core/widgets/widgets.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key, required this.loginViewModel});
  final LoginViewModel loginViewModel;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is Authenticated) {}

        return AuthCard(
          formKey: loginViewModel.formKey,
          onSubmit: () {
            loginViewModel.login(context);
          },
          errorMessage: state is AuthError ? state.message : null,

          onCancel:
              kDebugMode ? () => loginViewModel.goToHomeScreen(context) : null,
          cancelText: 'Later',
          subTitle: 'Please use your account to login',
          title: 'Login',
          submitText: 'Login',
          actions: _actions,
          fields: _fields,
        );
      },
    );
  }

  List<Widget> get _fields {
    return [
      //**-------------------- User name ---------------- */
      CustomTextFormField(
        //validator: validateEmail,
        controller: loginViewModel.userName,
        hintText: 'User Name',
        labelText: 'User Name',
        prefixicon: const Icon(Icons.person_outline),
        radius: 8,
      ),

      //**------------------- Password ---------------- */
      PasswordTextFormField(controller: loginViewModel.password, radius: 8),
      Row(
        children: [
          TextButton(onPressed: () {}, child: const Text('Forgot password')),
        ],
      ),
    ];
  }

  List<Widget> get _actions {
    return [
      TextWithLinkWidget(
        unlinkText: 'Don\'t have an account?',
        linkText: 'SignUp',
        onTap: () {},
      ),
    ];
  }
}
