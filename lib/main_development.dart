import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/di/dependency_injection.dart';
import 'core/router/app_router.dart';
import 'core/utils/shared_prefs.dart';
import 'features/notification/data/service/local_notifications.dart';
import 'features/notification/data/service/firebase_notifications_service.dart';
import 'firebase_options.dart';
import 'im_legends_app.dart';

/// === Initialize core services ===
Future<void> _initServices() async {
  // Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Local notifications
  await LocalNotificationService().initialize();

  // Supabase
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );

  // Dependency Injection
  setupGetIt();
}

/// === Main entry point ===
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load env vars
  await dotenv.load(fileName: ".env");

  // Ensure screen util sizing
  await ScreenUtil.ensureScreenSize();

  // Shared Preferences
  await SharedPrefStorage.instance.init();

  // Register background handler BEFORE runApp
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  // Init services
  await _initServices();

  // Run app
  runApp(IMLegendsApp(router: router));
}

// Run with:
// flutter run --release --flavor development --target lib/main_development.dart
