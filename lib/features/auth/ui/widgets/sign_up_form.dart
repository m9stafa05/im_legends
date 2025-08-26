import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../core/utils/spacing.dart';
import '../../../../core/widgets/app_text_form_field.dart';
import '../../../../core/widgets/custom_text_button.dart';
import '../../data/models/user_data.dart';
import 'auth_form.dart';

class SignUpForm extends StatefulWidget {
  final void Function(UserData userData, String password) onSignUp;

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

  /// Pick image using ImagePicker
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 75,
    );

    if (pickedFile != null) {
      setState(() => _profileImage = File(pickedFile.path));
    }
  }

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
          
        );

        widget.onSignUp(userData, password);
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
        Column(
          children: [
            CircleAvatar(
              radius: 40.r,
              backgroundColor: Colors.grey.shade300,
              backgroundImage: _profileImage != null
                  ? FileImage(_profileImage!)
                  : null,
              child: _profileImage == null
                  ? Icon(Icons.person, size: 40.r, color: Colors.grey)
                  : null,
            ),
            verticalSpacing(10),
            CustomTextButton(
              buttonWidth: 150.w,
              backgroundColor: AppColors.greyColor,
              borderRadius: 20.r,
              buttonText: 'Upload Profile Image',
              onPressed: _pickImage,
            ),
          ],
        ),
      ],
    );
  }
}
