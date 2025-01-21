import 'package:comarquesgui/models/comarca.dart';
import 'package:comarquesgui/repository/repository_comarques.dart';
import 'package:comarquesgui/screens/infocomarca_detall.dart';
import 'package:comarquesgui/screens/infocomarca_general.dart';
import 'package:flutter/material.dart';

class InfoComarcaScreen extends StatefulWidget {
  const InfoComarcaScreen({super.key, required this.nomComarca});

  final String nomComarca;

  @override
  State<InfoComarcaScreen> createState() => _InfoComarcaScreenState();
}

class _InfoComarcaScreenState extends State<InfoComarcaScreen> {
  Future<Comarca?>? comarcaFuture;


  int indexPantallaActual = 0;

  @override
  void initState() {
    super.initState();
    // TO-DO 5a
    
    comarcaFuture = RepositoryComarques.obtenirInfoComarca(widget.nomComarca);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: [
        const Text("Informació General",
            style: TextStyle(
              fontFamily: "LeckerliOne",
              fontSize: 30,
            )),
        const Text("Població i oratge",
            style: TextStyle(
              fontFamily: "LeckerliOne",
              fontSize: 30,
            ))
      ][indexPantallaActual]),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            indexPantallaActual = index;
          });
        },
        selectedIndex: indexPantallaActual,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.info_outline),
            selectedIcon: Icon(Icons.info),
            label: 'Informació general',
          ),
          NavigationDestination(
            icon: Icon(Icons.wb_sunny_outlined),
            selectedIcon: Icon(Icons.sunny),
            label: 'Informació detallada',
          ),
        ],
      ),
      body: FutureBuilder(
        future: comarcaFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final Comarca? comarca = snapshot.data;
            return IndexedStack(
              index: indexPantallaActual,
              children: [
                InfoComarcaGeneral(comarca: comarca), // A modificar per la info que rebem a l'snapshot quan es resol el Future
                InfoComarcaDetall(comarca: comarca)  // A modificar per la info que rebem a l'snapshot quan es resol el Future
              ],
            );
          }
        },
      ),
    );
  }
}
