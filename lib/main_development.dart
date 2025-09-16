import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'core/di/dependency_injection.dart';
import 'core/router/app_router.dart';
import 'core/utils/shared_prefs.dart';
import 'features/notification/data/service/local_notifications.dart';
import 'features/notification/data/service/firebase_notifications_service.dart';
import 'firebase_options.dart';
import 'im_legends_app.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Global notifications plugin
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

/// Initialize core services
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

/// Main entry point
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load env vars
  await dotenv.load(fileName: ".env");

  // ScreenUtil
  await ScreenUtil.ensureScreenSize();

  // SharedPrefs
  await SharedPrefStorage.instance.init();

  // Register background handler BEFORE runApp
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  // Run app after async init
  runApp(
    FutureBuilder(
      future: _initServices(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return IMLegendsApp(router: router);
        }
        // Splash/loading screen
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

// Run with:
// flutter run --release --flavor development --target lib/main_development.dart
