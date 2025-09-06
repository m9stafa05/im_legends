import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:im_legends/core/di/dependency_injection.dart';
import 'package:im_legends/core/router/app_router.dart';
import 'package:im_legends/features/notification/data/service/firebase_notifications.dart';
import 'package:im_legends/firebase_options.dart';
import 'package:im_legends/im_legends_app.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

const supabaseUrl = 'https://flutiryhpfdlpizyxqix.supabase.co';
const supabaseAnonKey =
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZsdXRpcnlocGZkbHBpenl4cWl4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTYxNTQ3NzIsImV4cCI6MjA3MTczMDc3Mn0.UhojXOtOrnvbwDKvyBVZn3Cl1gdUkr-NYuGBLQXIRi0";

Future<void> _initServices() async {
  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseNotifications().initialize();

  // Initialize Supabase
  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseAnonKey);

  // Setup DI
  setupGetIt();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();

  runApp(
    FutureBuilder(
      future: _initServices(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return IMLegendsApp(router: router);
        }

        // Simple splash screen while initializing
        return const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            backgroundColor: Colors.black,
            body: Center(child: CircularProgressIndicator(color: Colors.white)),
          ),
        );
      },
    ),
  );
}

// flutter run --release --flavor development --target lib/main_development.dart
