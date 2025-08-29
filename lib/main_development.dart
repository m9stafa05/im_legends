import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:im_legends/core/di/dependency_injection.dart';
import 'package:im_legends/core/router/app_router.dart';
import 'package:im_legends/im_legends_app.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

const supabaseUrl = 'https://flutiryhpfdlpizyxqix.supabase.co';
// const supabaseKey = String.fromEnvironment('SUPABASE_KEY');
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: supabaseUrl,
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZsdXRpcnlocGZkbHBpenl4cWl4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTYxNTQ3NzIsImV4cCI6MjA3MTczMDc3Mn0.UhojXOtOrnvbwDKvyBVZn3Cl1gdUkr-NYuGBLQXIRi0",
  );
  setupGetIt();
  await ScreenUtil.ensureScreenSize();
  runApp(IMLegendsApp(appRouter: AppRouter()));
}

// flutter run --release --flavor development --target lib/main_development.dart
