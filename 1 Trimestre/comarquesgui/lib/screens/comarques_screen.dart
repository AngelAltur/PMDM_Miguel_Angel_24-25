import 'package:comarquesgui/models/comarca.dart';
import 'package:comarquesgui/repository/repository_exemple.dart';
import 'package:flutter/material.dart';

class ComarquesScreen extends StatelessWidget {
  const ComarquesScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          // Proporciona a _creaLlistaComarques la llista de comarques d'Alacant
          child:
              _creaLlistaComarques(RepositoryExemple.obtenirComarques())), ////
    );
  }

  _creaLlistaComarques(List<dynamic> comarques) {
    // Rebem la llista de JSON amb el nom i la imatge (img) de cada comarca

    // TO-DO
    // Caldrà fer ús d'un ListView.builder per recórrer la llista
    // i generar un giny personalitzat de tipus ComarcaCard, amb la imatge i el nom.
      ListView.builder(
        itemCount: comarques.length,
        itemBuilder: (BuildContext context, int index) {
          final comarca= Comarca.fromJSON(comarques[index]);
          return ComarcaCard(img:comarca.img!, comarca: comarca.comarca);
        },
      );
  }
}

class ComarcaCard extends StatelessWidget {
  // Aquest giny rebrà dos arguments amb nom per construir-se:
  // la imatge (img) i el nom de la comarca (comarca)
  const ComarcaCard({
    super.key,
    required this.img,
    required this.comarca,
  });

  final String img;
  final String comarca;

  @override
  Widget build(BuildContext context) {
    // TO-DO
    // Retorna un giny de tipus Card, amb el disseny que desitgeu, però
    // que mostre la imatge (obtinguda d'Internet a partir de la url)
    // i el nom de la comarca.
    
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
          Image.network(
            img,
            fit: BoxFit.cover,
          ),
        Padding(
          padding:const EdgeInsets.all(10),
          child: Text(
            comarca,
            style: const TextStyle(
              fontSize:18,
              fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
