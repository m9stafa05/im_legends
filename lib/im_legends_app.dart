import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:im_legends/core/router/app_router.dart';
import 'package:im_legends/core/router/routes.dart';

class IMLegendsApp extends StatelessWidget {
  const IMLegendsApp({super.key, required this.appRouter});
  final AppRouter appRouter;
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      // ToDo :App Main Size
      designSize: const Size(393, 852),
      minTextAdapt: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.homeScreen,
        onGenerateRoute: AppRouter().generateRoute,
        title: 'IM Legends App',
        theme: ThemeData(scaffoldBackgroundColor: const Color(0xFF000000)),
      ),
    );
  }
}
