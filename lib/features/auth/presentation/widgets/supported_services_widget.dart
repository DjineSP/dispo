import 'package:flutter/material.dart';

class SupportedServicesWidget extends StatelessWidget {
  const SupportedServicesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> services = [
      {'image': 'assets/images/logo_orange.png', 'name': 'Orange Money'},
      {'image': 'assets/images/logo_mtn.jpg', 'name': 'MTN Money'},
      {'image': 'assets/images/logo_cellcom.png', 'name': 'Cellcom'},
      {'image': 'assets/images/logo_canal.jpg', 'name': 'Canal+'},
      {'image': 'assets/images/logo_startime.png', 'name': 'StarTimes'},
    ];

    return Expanded(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final double w = constraints.maxWidth;
          final double h = constraints.maxHeight;
          
          // Augmentation de la taille : 35% de la largeur de l'écran
          final double logoSize = w * 0.35; 

          return Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              // 1. Orange Money - Haut Gauche (Ajusté plus près du bord)
              Positioned(
                left: w * 0.02,
                top: h * 0.08,
                child: _buildPuzzlePiece(services[0]['image']!, logoSize, -0.12),
              ),
              
              // 2. Canal+ - Haut Droite
              Positioned(
                right: w * 0.02,
                top: h * 0.02,
                child: _buildPuzzlePiece(services[3]['image']!, logoSize, 0.08),
              ),
              
              // 3. MTN Money - Centre (Légèrement décalé pour le style)
              Positioned(
                top: h * 0.35,
                child: _buildPuzzlePiece(services[1]['image']!, logoSize, 0.05),
              ),
              
              // 4. Cellcom - Bas Gauche
              Positioned(
                left: w * 0.05,
                bottom: h * 0.05,
                child: _buildPuzzlePiece(services[2]['image']!, logoSize, -0.08),
              ),
              
              // 5. StarTimes - Bas Droite
              Positioned(
                right: w * 0.05,
                bottom: h * 0.1,
                child: _buildPuzzlePiece(services[4]['image']!, logoSize, 0.15),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildPuzzlePiece(String imagePath, double size, double rotation) {
    return Transform.rotate(
      angle: rotation,
      child: Container(
        width: size,
        height: size,
        // Padding ajusté pour que le logo soit bien grand dans le cercle
        padding: EdgeInsets.all(size * 0.18), 
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.12),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Image.asset(
          imagePath,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) => 
              const Icon(Icons.image_not_supported, color: Colors.grey),
        ),
      ),
    );
  }
}