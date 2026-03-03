import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _slideAnimation;
  late Animation<double> _revealAnimation;
  
  // --- PARAMÈTRES DE DIMENSION ---
  final double logoHeight = 120.0;
  final double logoWidth = 360.0;
  
  // Ajuster ce ratio si le 'D' n'est pas parfaitement centré au départ
  final double dWidthRatio = 0.35; 

  @override
  void initState() {
    super.initState();
    
    // Durée de la transition
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000), 
    );

    // Une courbe douce pour un effet naturel
    final curve = CurvedAnimation(parent: _controller, curve: Curves.easeOutQuart);

    _slideAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(curve);
    _revealAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(curve);

    _startScenario();
  }

  void _startScenario() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FlutterNativeSplash.remove();
      
      Future.delayed(const Duration(milliseconds: 400), () {
        if (mounted) _controller.forward();
      });

      Future.delayed(const Duration(milliseconds: 3000), () {
        if (mounted) {
          context.go('/home');
        }
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    final double dWidth = logoWidth * dWidthRatio;
    final double textWidth = logoWidth - dWidth;
    final double initialXOffset = textWidth / 2;
    
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Center(
        child: SizedBox(
          width: logoWidth,
          height: logoHeight,
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  // Le logo glisse vers la gauche
                  Transform.translate(
                    offset: Offset(initialXOffset * (1 - _slideAnimation.value), 0),
                    child: Image.asset(
                      'assets/logo_2.png',
                      height: logoHeight,
                      width: logoWidth,
                      fit: BoxFit.contain,
                    ),
                  ),

                  // Le masque blanc/noir réduit sa largeur pour révéler le reste du logo
                  Positioned(
                    right: 0,
                    top: 0,
                    bottom: 0,
                    width: textWidth * (1 - _revealAnimation.value),
                    child: Container(
                      color: theme.scaffoldBackgroundColor, 
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}