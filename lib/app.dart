import 'package:file_sharing_app/routes/app_go_router.dart';
import 'package:file_sharing_app/theme/app_theme/app_theme_data.dart';
import 'package:file_sharing_app/views/pages/splash_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppThemeData.lightTheme,
      routerConfig: AppGoRouter.router,
    );
  }
}
