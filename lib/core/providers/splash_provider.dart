import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Un provider simple pour savoir si l'animation initiale du Splash Screen
/// est complètement terminée (les 3 secondes).
/// Cela permet de séparer totalement l'UI (le splash) de la logique de routage.
class SplashAnimationCompletedNotifier extends Notifier<bool> {
  @override
  bool build() => false;

  void complete() {
    state = true;
  }
}

final splashAnimationCompletedProvider = NotifierProvider<SplashAnimationCompletedNotifier, bool>(
  SplashAnimationCompletedNotifier.new,
);
