import 'package:comarquesgui/screens/comarques_screen.dart';
import 'package:comarquesgui/screens/infocomarca_detall.dart';
import 'package:comarquesgui/screens/infocomarca_general.dart';
import 'package:comarquesgui/screens/provincies_screen.dart';
import 'package:flutter/material.dart';

class LauncherScreen extends StatelessWidget {
  const LauncherScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
              onPressed: () {
                Navigator.push<void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const ProvinciesScreen(),
                  ),
                );
              },
              child: const Text("Pantalla Provincies")),
          ElevatedButton(
              onPressed: () {
                Navigator.push<void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const ComarquesScreen(),
                  ),
                );
              },
              child: const Text("Pantalla Comarques")),
          ElevatedButton(
              onPressed: () {
                Navigator.push<void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) =>
                        const InfoComarcaGeneral(),
                  ),
                );
              },
              child: const Text(
                  "Pantalla amb informació de \n general de la comarca.")),
          ElevatedButton(
              onPressed: () {
                Navigator.push<void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) =>
                        const InfoComarcaDetall(),
                  ),
                );
              },
              child: const Text(
                  "Pantalla amb informació \n detallada de la comarca"))
        ],
      ),
    );
  }
}
