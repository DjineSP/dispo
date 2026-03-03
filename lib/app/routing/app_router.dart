import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers/auth_provider.dart';
import '../../core/providers/splash_provider.dart';
import '../../features/splash_screen.dart';
import '../../features/auth/presentation/pages/landing_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/home/presentation/pages/home_page.dart';

class Routes {
    // Initial & Auth Routes
    static const String splash = '/';
    static const String landing = '/landing';
    static const String login = '/login';
    static const String register = '/register';
    
    // Main Routes
    static const String home = '/home';
}

final routerProvider = Provider<GoRouter>((ref) {
  final notifier = ValueNotifier<dynamic>(null);
  
  ref.listen(authProvider, (_, next) => notifier.value = next);
  ref.listen(splashAnimationCompletedProvider, (_, next) => notifier.value = next);

  return GoRouter(
    initialLocation: Routes.splash,
    refreshListenable: notifier,
    redirect: (BuildContext context, GoRouterState state) {
      final authStatus = ref.read(authProvider);
      final isSplashAnimCompleted = ref.read(splashAnimationCompletedProvider);

      final isSplash = state.matchedLocation == Routes.splash;
      final isLanding = state.matchedLocation == Routes.landing;
      final isLogin = state.matchedLocation == Routes.login;
      final isRegister = state.matchedLocation == Routes.register;

      final isAuthRoute = isLanding || isLogin || isRegister;

      // 1. Si l'animation du splash n'est pas terminée, on empêche toute navigation
      // et on reste bloqué sur le Splash Screen pour laisser l'animation jouer.
      if (!isSplashAnimCompleted) {
        return isSplash ? null : Routes.splash;
      }

      // 2. Si l'animation est finie, mais que l'état d'authentification est encore
      // au stade initial (connexion en cours de vérification), on attend sur le splash.
      if (authStatus == AuthStatus.initial) {
        return isSplash ? null : Routes.splash;
      }

      // 3. À ce stade, le Splash est fini ET l'authentification est résolue !
      switch(authStatus) {
        case AuthStatus.initial:
          return null; // Géré par le if au-dessus
          
        case AuthStatus.unauthenticated:
          // Utilisateur non connecté : on l'envoie sur Landing (sauf s'il est déjà sur Login/Register/Landing)
          if (!isAuthRoute) return Routes.landing;
          return null;

        case AuthStatus.authenticated:
          // Utilisateur connecté : on l'envoie sur Home (s'il était sur Splash, Landing, Login, etc.)
          if (isSplash || isAuthRoute) return Routes.home;
          return null;
      }
    },
    routes: [
      GoRoute(
        path: Routes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: Routes.landing,
        builder: (context, state) => const LandingPage(),
      ),
      GoRoute(
        path: Routes.login,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: Routes.register,
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        path: Routes.home,
        builder: (context, state) => const MyHomePage(),
      ),
    ],
  );
});
