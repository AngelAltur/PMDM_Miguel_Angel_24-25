import 'package:flutter/material.dart';

class DarkCardWidget extends StatelessWidget {
  final String title;
  final String description;
  final String imgAlbum;

  const DarkCardWidget({
    Key? key,
    required this.title,
    required this.description,
    required this.imgAlbum,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black54, // Fondo oscuro
      margin: const EdgeInsets.all(16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 8,
      child: Row(
        children: [
          // Imagen de álbum
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                imgAlbum,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Contenido textual
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    description,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
