import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final IconData icon;
  final String conteo, texto;
  final Color color;

  const InfoCard({
    Key? key,
    required this.icon,
    required this.conteo,
    required this.texto,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(icon, size: 32, color: color),
          const SizedBox(height: 8),
          Text(
            conteo,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color.darker(),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            texto,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: color.darker().withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }
}

extension ColorExtension on Color {
  Color darker([double amount = .1]) {
    final hsl = HSLColor.fromColor(this);
    final newLightness = (hsl.lightness - amount).clamp(0.0, 1.0);
    return hsl.withLightness(newLightness).toColor();
  }
}
