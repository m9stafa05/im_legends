import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/spacing.dart';
import '../../../../core/widgets/app_text_form_field.dart';
import '../../../../core/widgets/custom_text_button.dart';

class AuthForm extends StatefulWidget {
  final String actionText;
  final Function(Map<String, String> values) onSubmit;
  final List<Widget> extraFields;

  const AuthForm({
    super.key,
    required this.actionText,
    required this.onSubmit,
    this.extraFields = const [],
  });

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  final _controllers = <String, TextEditingController>{
    'email': TextEditingController(),
    'password': TextEditingController(),
  };

  @override
  void dispose() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      widget.onSubmit({
        'email': _controllers['email']!.text.trim(),
        'password': _controllers['password']!.text.trim(),
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
            controller: _controllers['email'],
            hintText: 'Email',
            validator: _validateEmail,
          ),
          verticalSpacing(20),
          AppTextFormField(
            controller: _controllers['password'],
            hintText: 'Password',
            isObscureText: true,
            validator: _validatePassword,
          ),
          ...widget.extraFields,
          verticalSpacing(30),
          SizedBox(
            width: 250.w,
            child: CustomTextButton(
              borderRadius: 20.r,
              buttonText: widget.actionText,
              onPressed: _submit,
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
    final trimmedValue = value.trim();
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
    );
    if (!emailRegex.hasMatch(trimmedValue)) {
      return 'Enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }
}
