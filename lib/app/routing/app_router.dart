import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/splash_screen.dart';
import '../../features/home/presentation/pages/home_page.dart';

class Routes {
    // Initial & Auth Routes
    static const String splash = '/';
    static const String login = '/login';
    static const String register = '/register';
    
    // Main Routes
    static const String home = '/home';
}

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: Routes.splash,
    routes: [
      // Splash & Auth
      GoRoute(
        path: Routes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: Routes.home,
        builder: (context, state) => const MyHomePage(),
      ),
    ],
  );
}
