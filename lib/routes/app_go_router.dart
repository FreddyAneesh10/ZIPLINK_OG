import 'package:file_sharing_app/views/pages/home_page.dart';
import 'package:file_sharing_app/views/pages/receive_file_page.dart';
import 'package:file_sharing_app/views/pages/send_file_page.dart';
import 'package:file_sharing_app/views/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'app_routes.dart';

class AppGoRouter {
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.splashPage,

    routes: [
      GoRoute(
        path: AppRoutes.splashPage,
        builder: (context, state) => const SplashPage(),
      ),

      GoRoute(
        path: AppRoutes.homePage,
        builder: (context, state) => HomePage(),
      ),
      GoRoute(
        path: AppRoutes.sendFilePage,
        builder: (context, state) => SendFilePage(),
      ),
      GoRoute(
        path: AppRoutes.receiveFilePage,
        builder: (context, state) => ReceiveFilePage(),
      ),
    ],

    errorBuilder: (context, state) => const Scaffold(
      body: Center(
        child: Text('Route not found', style: TextStyle(fontSize: 16)),
      ),
    ),
  );
}
