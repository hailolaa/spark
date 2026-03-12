import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../../features/splash/presentation/pages/splash_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';


class AppRouter {
  AppRouter._();
  static final GoRouter router = GoRouter(
    initialLocation: AppConstants.routeSplash,
    routes: [
      GoRoute(
        path: AppConstants.routeSplash,
        builder: (context, state) => const SplashPage(),
      ),

      //AUTH Routes
      GoRoute(
        path: AppConstants.routeLogin,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: AppConstants.routeRegister,
        builder: (context, state) => const RegisterPage(),
      ),

      //MAIN Routes
       GoRoute(
        path: AppConstants.routeHome,
        builder: (context, state) => const Scaffold(
          body: Center(child: Text("Home Page Placeholder", style: TextStyle(color: Colors.white))),
        ),
      ),
      GoRoute(
        path: AppConstants.routeAdminDashboard,
        builder: (context, state) => const Scaffold(
          body: Center(child: Text("Admin Dashboard Placeholder", style: TextStyle(color: Colors.white))),
        ),
      ),
    ],

    ///Error Page
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text(
          'Page not found',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    ),
  );
}
