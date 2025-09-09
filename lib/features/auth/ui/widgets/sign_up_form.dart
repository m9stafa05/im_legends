import 'dart:io';
import 'package:flutter/material.dart';
import 'upload_image_field.dart';
import '../../../../core/utils/spacing.dart';
import '../../../../core/widgets/app_text_form_field.dart';

import '../../data/models/user_data.dart';
import 'auth_form.dart';

class SignUpForm extends StatefulWidget {
  final void Function(UserData userData, String password, File? profileImage)
  onSignUp;

  const SignUpForm({super.key, required this.onSignUp});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _ageController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  File? _profileImage;
  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _ageController.dispose();
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

        final userData = UserData(
          name: _nameController.text.trim(),
          email: values['email']!,
          phoneNumber: _phoneController.text.trim(),
          age: int.tryParse(_ageController.text.trim()) ?? 0,
          profileImageUrl: null,
        );

        widget.onSignUp(userData, password, _profileImage);
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
        AppTextFormField(
          controller: _phoneController,
          hintText: 'Phone Number',
          validator: (value) => (value == null || value.isEmpty)
              ? 'Phone number is required'
              : null,
        ),
        verticalSpacing(20),
        AppTextFormField(
          controller: _ageController,
          hintText: 'Age',
          validator: (value) => (value == null || int.tryParse(value) == null)
              ? 'Valid age is required'
              : null,
        ),
        verticalSpacing(20),
        const UploadImageField(),
      ],
    );
  }
}
