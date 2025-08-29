import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/functions/image_picker.dart';
import '../../../../core/utils/spacing.dart';

class UploadImageField extends StatefulWidget {
  const UploadImageField({super.key});

  @override
  State<UploadImageField> createState() => _UploadImageFieldState();
}

class _UploadImageFieldState extends State<UploadImageField> {
  File? _profileImage;
  Future<void> _pickImage() async {
    final pickedImage = await ImagePickerHelper.showImageSourceActionSheet(
      context,
    );
    if (pickedImage != null) {
      setState(() {
        _profileImage = pickedImage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: _pickImage,
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              // Profile image or placeholder
              CircleAvatar(
                radius: 50.r,
                backgroundColor: Colors.grey.shade200,
                backgroundImage: _profileImage != null
                    ? FileImage(_profileImage!)
                    : null,
                child: _profileImage == null
                    ? Icon(
                        Icons.person,
                        size: 50.r,
                        color: Colors.grey.shade600,
                      )
                    : null,
              ),

              // Small edit icon
              Container(
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                padding: EdgeInsets.all(6.r),
                child: const Icon(Icons.edit, color: Colors.white, size: 16),
              ),
            ],
          ),
        ),
        verticalSpacing(12),

        // Subtle secondary button
        TextButton.icon(
          onPressed: _pickImage,
          style: TextButton.styleFrom(
            foregroundColor: Colors.blueAccent,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.r),
            ),
          ),
          icon: const Icon(Icons.upload, size: 18),
          label: const Text(
            'Upload Profile Image',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}
