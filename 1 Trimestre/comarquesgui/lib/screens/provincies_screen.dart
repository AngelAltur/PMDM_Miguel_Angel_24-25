import 'package:comarquesgui/models/provincia.dart';
import 'package:comarquesgui/repository/repository_exemple.dart';
import 'package:flutter/material.dart';

/* Pantalla ProvinciesScreen: mostra tres CircleAvatar amb les diferents províncies */

class ProvinciesScreen extends StatelessWidget {
  const ProvinciesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(                  // Estructura de la pantalla Material Design
      body: Center(                   // Centrem el contingut
        child: SingleChildScrollView( // Contenidor amb scroll per si ens n'eixim de l'espai disponible
          child: Column(              // Organitzem les provincies en forma de columna
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children:               // Obtindrem la llista de widgets amb les provincies amb la 
                                      // funció privada _creaLlistaProvincies.
                  _creaLlistaProvincies(RepositoryExemple.obtenirProvincies())),
        ),
      ),
    );
  }
}

List <Widget> _creaLlistaProvincies(List<Provincia> provincies) {
  // Retornarem una llista de widgets
  List<Widget> llista = [];

  // Recorrem la llista de províncies
  for (Provincia provincia in provincies) {
    llista.add( // I afegim a la llista un widget personalitzat de tipus ProvinciaRoundButton
        ProvinciaRoundButton(nom: provincia.nom, img: provincia.imatge ?? ""));
    llista.add(const SizedBox(height: 20)); // Afegim un espai després del widget amb la província
  }
  return llista;
}

class ProvinciaRoundButton extends StatelessWidget {
  const ProvinciaRoundButton({required this.img, required this.nom, super.key});

  final String img;
  final String nom;

  @override
  Widget build(BuildContext context) {
    // TO-DO
    
    // retornarem un widget de tipus CircleAvatar amb les següents propietats
    // radi: 110
    // imatge de fons: la imatge que ens han proporcionat. Aquesta imatge s'obté d'Internet
    // Aquest giny contindrà com a fill un Text, amb el nom de la província
    // Per donar-li estil al text, pots utilitzar: style: Theme.of(context).textTheme.displayMedium,
    // (al Main, hem definit ja un estil personalitzat pe a l'aplicació, per tant, d'aci fem referència a eixe tema)

    return CircleAvatar(
      radius:110,
      backgroundImage: NetworkImage(img),
      child:Text(
        nom,
        style: Theme.of(context).textTheme.displayMedium,
      ),
    );
  }
}
