import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:im_legends/core/di/dependency_injection.dart';
import 'package:im_legends/core/router/app_router.dart';
import 'package:im_legends/im_legends_app.dart';



void main() async {
  setupGetIt();
  await ScreenUtil.ensureScreenSize();
  runApp(IMLegendsApp(appRouter: AppRouter()));
}
// flutter run --release --flavor production --target lib/main_production.dart