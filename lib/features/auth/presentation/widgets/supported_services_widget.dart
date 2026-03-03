import 'package:flutter/material.dart';

class SupportedServicesWidget extends StatelessWidget {
  const SupportedServicesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final services = [
      {'name': 'Orange Money', 'image': 'assets/images/logo_orange.png'},
      {'name': 'MTN Money', 'image': 'assets/images/logo_mtn.jpg'},
      {'name': 'Cellcom', 'image': 'assets/images/logo_cellcom.jpeg'},
      {'name': 'Canal+', 'image': 'assets/images/logo_canal.jpg'},
      {'name': 'StarTimes', 'image': 'assets/images/logo_startime.jpg'},
    ];

    // Disposition type "Puzzle" occupant le maximum de place
    return Expanded(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final w = constraints.maxWidth;
          final h = constraints.maxHeight;

          return Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              // Haut Gauche - Orange Money
              Positioned(
                left: w * 0.05,
                top: h * 0.1,
                child: _buildPuzzlePiece('assets/images/logo_orange.png', w * 0.28, -0.1),
              ),
              
              // Haut Droite - Canal+
              Positioned(
                right: w * 0.02,
                top: h * 0.05,
                child: _buildPuzzlePiece('assets/images/logo_canal.jpg', w * 0.25, 0.15),
              ),
              
              // Centre - MTN (Le plus gros, mis en valeur)
              Positioned(
                child: _buildPuzzlePiece('assets/images/logo_mtn.jpg', w * 0.40, 0),
              ),
              
              // Bas Gauche - Cellcom
              Positioned(
                left: w * 0.1,
                bottom: h * 0.08,
                child: _buildPuzzlePiece('assets/images/logo_cellcom.webp', w * 0.25, -0.2),
              ),
              
              // Bas Droite - StarTimes
              Positioned(
                right: w * 0.08,
                bottom: h * 0.12,
                child: _buildPuzzlePiece('assets/images/logo_startime.jpg', w * 0.28, 0.08),
              ),
            ],
          );
        },
      ),
    );
  }

  // Helper pour construire une "pièce" sans bordure ni fond, juste l'image d'origine
  Widget _buildPuzzlePiece(String imagePath, double size, double rotation) {
    return Transform.rotate(
      angle: rotation,
      child: SizedBox(
        width: size,
        height: size,
        child: Image.asset(
          imagePath,
          fit: BoxFit.contain, // Assure que le logo est entièrement visible
        ),
      ),
    );
  }
}
