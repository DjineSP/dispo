import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/routing/app_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../widgets/supported_services_widget.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 48), // Espace en haut
              
              // 1. Logo en haut (taille identique au splash screen pour éviter le redimensionnement)
              Center(
                child: Image.asset(
                  'assets/logo_2.png',
                  height: 120, // Identique à logoHeight du SplashScreen
                  width: 360,  // Identique à logoWidth du SplashScreen
                ),
              ),

              const SizedBox(height: 8),
              
              // 2. Phrase d'accroche avec un texte plus petit
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  "Gérez vos services clients simplement",
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: AppColors.secondary,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                ),
              ),
              
              const SizedBox(height: 16),
              
              // 3. Widget des services (Orange, MTN, etc.) qui prendra le reste de l'espace disponible
              const SupportedServicesWidget(),
              
              const SizedBox(height: 32),
              
              // 4. Actions principales (Hiérarchie UI/UX forte)
              ElevatedButton(
                onPressed: () => context.push(Routes.login),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accent,
                  foregroundColor: Colors.white,
                  elevation: 0, // Design plat et moderne
                  minimumSize: const Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  'Se connecter',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              OutlinedButton(
                onPressed: () => context.push(Routes.register),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 56),
                  side: BorderSide(
                    color: theme.colorScheme.primary, 
                    width: 2.0,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  'Créer un compte',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
