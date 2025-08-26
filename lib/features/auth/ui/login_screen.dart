import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../logic/cubit/auth_cubit.dart';
import 'widgets/login_form.dart';
import '../../../core/utils/extensions.dart';
import '../../../core/router/routes.dart';
import '../../../core/themes/app_texts_style.dart';
import '../../../core/utils/spacing.dart';
import '../../../core/widgets/logo_top_bar.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                LogoTopBar(),
                verticalSpacing(50),
                Text(
                  'Login to IM Legends',
                  style: AppTextStyles.text20WhiteBold,
                ),
                verticalSpacing(50),
                BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is AuthSuccess) {
                      Navigator.pop(context); // Close loading
                      context.pushReplacementNamed(Routes.homeScreen);
                    } else if (state is AuthFailure) {
                      Navigator.pop(context);
                      _showErrorDialog(context, state.errorMessage);
                    } else if (state is AuthLoading) {
                      _showLoadingDialog(context);
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
                    );
                  },
                ),
                verticalSpacing(20),
                TextButton(
                  onPressed: () =>
                      context.pushReplacementNamed(Routes.signUpScreen),
                  child: const Text('Create Account'),
                ),
              ],
            ),
          ),
        ),
      ),
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

  void _showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );
  }
}
