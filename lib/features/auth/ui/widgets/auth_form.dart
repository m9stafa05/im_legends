import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:im_legends/core/utils/regex.dart';
import 'package:im_legends/core/utils/spacing.dart';
import 'package:im_legends/core/widgets/app_text_form_field.dart';
import 'package:im_legends/core/widgets/custom_text_button.dart';

class AuthForm extends StatefulWidget {
  final String actionText;
  final Function(Map<String, String>) onSubmit;
  final List<Widget> extraFields;
  final bool isLoading;

  const AuthForm({
    super.key,
    required this.actionText,
    required this.onSubmit,
    this.extraFields = const [],
    this.isLoading = false,
  });

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      widget.onSubmit({
        'email': _emailController.text.trim(),
        'password': _passwordController.text.trim(),
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          AppTextFormField(

            controller: _emailController,
            hintText: 'Email',
            validator: _validateEmail,
            keyboardType: TextInputType.emailAddress,
          ),
          verticalSpacing(16.h),
          AppTextFormField(
            controller: _passwordController,
            hintText: 'Password',
            isObscureText: true,
            validator: _validatePassword,
            keyboardType: TextInputType.visiblePassword,
          ),
          ...widget.extraFields,
          verticalSpacing(24.h),
          SizedBox(
            width: double.infinity,
            child: CustomTextButton(
              borderRadius: 12.r,
              buttonText: widget.actionText,
              onPressed: widget.isLoading ? null : _submit,
              isLoading: widget.isLoading,
            ),
          ),
        ],
      ),
    );
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }

    if (!AppRegex.isEmailValid(value.trim())) {
      return 'Enter a valid email';
    }

    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }
}
