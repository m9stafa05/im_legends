import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:im_legends/core/di/dependency_injection.dart';
import 'package:im_legends/core/router/app_router.dart';
import 'package:im_legends/firebase_options.dart';
import 'package:im_legends/im_legends_app.dart';

void main() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  setupGetIt();
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  runApp(IMLegendsApp(appRouter: AppRouter()));
}

// flutter run --release --flavor production --target lib/main_production.dart
