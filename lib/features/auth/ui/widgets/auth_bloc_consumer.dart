import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../logic/cubit/auth_cubit.dart';
import 'login_form.dart';

import '../../../../core/router/routes.dart';

class AuthBlocConsumer extends StatelessWidget {
  const AuthBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          context.go(Routes.homeScreen);
        } else if (state is AuthFailure) {
          Navigator.pop(context); // Close loading dialog
          _showErrorDialog(context, state.errorMessage);
        }
      },
      builder: (context, state) {
        return LoginForm(
          onLogin: (email, password) {
            context.read<AuthCubit>().emitLogin(
              email: email,
              password: password,
            );
          },
          isLoading: state is AuthLoading,
        );
      },
    );
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Login Failed'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
