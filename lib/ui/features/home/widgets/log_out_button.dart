import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:store/ui/features/auth/cubits/auth_cubit.dart';
import 'package:store/routing/routes.dart';

class LogOutButton extends StatelessWidget {
  const LogOutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? _buildCupertinoLogoutButton(context)
        : _buildMaterialLogoutButton(context);
  }

  // On press method
  void _onPressed(BuildContext context) {
    BlocProvider.of<AuthCubit>(
      context,
    ).logout().then((_) => context.goNamed(AppRoutes.login));
  }

  // Material button
  Widget _buildMaterialLogoutButton(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.zero,
      onPressed: () => _onPressed(context),
      icon: const Icon(Icons.logout_outlined),
    );
  }

  // Cupertino button
  Widget _buildCupertinoLogoutButton(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () => _onPressed(context),
      child: const Icon(Icons.logout_outlined),
    );
  }
}
