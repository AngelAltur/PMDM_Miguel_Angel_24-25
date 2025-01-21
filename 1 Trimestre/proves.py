import 'package:flutter/material.dart';

// En primer lloc, definim el giny com a un giny amb estat
class ExempleForms2 extends StatefulWidget {
  const ExempleForms2({super.key});

  // Sobreescrivim el mètode createState() per crear l'estat
  @override
  State<ExempleForms2> createState() => _ExempleForms2State();
}

// Classe per a l'estat
class _ExempleForms2State extends State<ExempleForms2> {
  // Definim el contingut com a propietat
  String? contingut;

  @override
  void initState() {
    super.initState();
    // Inicialitzem el contingut
    contingut = "";
  }

  // Construim el giny

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onChanged: (text) {
            // Quan canvie el contingut, actualitzarem
            // la propietat corresponent de l'estat i
            // ho notificarem a Flutter amb setStat
            setState(() {
              contingut = text;
            });
          },
        ),
        const Divider(),
        // Afegim un segon giny de tipus text que
        // mostra el contingut
        Text("$contingut"),
      ]),
    );
  }
}