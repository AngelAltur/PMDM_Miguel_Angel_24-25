import 'package:comarquesgui/models/comarca.dart';
import 'package:flutter/material.dart';

// TO-DO
// Afegir la propietat comarca, de tipus Comarca i proporcionar-la
// al constructor.

class InfoComarcaGeneral extends StatelessWidget {
  const InfoComarcaGeneral({super.key, required this.comarca});

  final Comarca? comarca;

  @override
  Widget build(BuildContext context) {
    // Ja tenim un Scaffold en InfoComarca, no cal aci
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(16.0),
        decoration:
            const BoxDecoration(color: Color.fromARGB(200, 255, 255, 255)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(height: 80),
            Image.network(comarca?.img ?? ""),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    comarca?.comarca ?? "No trobada",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Capital: ${comarca?.capital}',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    comarca?.desc ?? "",
                    textAlign: TextAlign.justify,
                    style: Theme.of(context).textTheme.bodyMedium,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
