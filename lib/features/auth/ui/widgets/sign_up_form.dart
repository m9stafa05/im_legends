import 'package:flutter/material.dart';
import "auth_form.dart";
import '../../../../core/utils/spacing.dart';
import '../../../../core/widgets/app_text_form_field.dart';

class SignUpForm extends StatefulWidget {
  final void Function(String name, String email, String password) onSignUp;

  const SignUpForm({super.key, required this.onSignUp});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _nameController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthForm(
      actionText: 'Sign Up',
      onSubmit: (values) {
        final password = values['password']!;
        final confirmPassword = _confirmPasswordController.text.trim();
        if (password != confirmPassword) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Passwords do not match')),
          );
          return;
        }
        widget.onSignUp(
          _nameController.text.trim(),
          values['email']!,
          password,
        );
      },
      extraFields: [
        verticalSpacing(20),
        AppTextFormField(
          controller: _confirmPasswordController,
          hintText: 'Confirm Password',
          isObscureText: true,
          validator: (value) => (value == null || value.length < 6)
              ? 'Confirm password must be at least 6 characters'
              : null,
        ),
        verticalSpacing(20),
        AppTextFormField(
          controller: _nameController,
          hintText: 'Name',
          validator: (value) =>
              (value == null || value.isEmpty) ? 'Name is required' : null,
        ),
        verticalSpacing(20),
      ],
    );
  }
}
