import 'package:comarquesgui/models/comarca.dart';
import 'package:comarquesgui/repository/repository_exemple.dart';
import 'package:comarquesgui/screens/widgets/my_weather_info.dart';
import 'package:flutter/material.dart';
class InfoComarcaDetall extends StatelessWidget {
  const InfoComarcaDetall({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Comarca comarca = RepositoryExemple.obtenirInfoComarca();

    return Scaffold(
      appBar: AppBar(
        title: Text(comarca.comarca),
      ),
      body:Padding(
        padding: const EdgeInsets.all(16),
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[
            MyWeatherInfo(),
            SizedBox(height:20),
            Text(
              'Informació de la comarca',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Row(
              children:[
                Text('Poblacio:', style:TextStyle(fontWeight: FontWeight.bold)),
                Text(comarca.poblacio?.toString() ?? 'No se encuentra'),
              ],
            ),
            Row(
              children:[
                Text('Latitud:', style:TextStyle(fontWeight: FontWeight.bold)),
                Text(comarca.latitud?.toString()?? 'No se encuentra'),
              ],
            ),
            Row(
              children:[
                Text('Longitud:', style: TextStyle(fontWeight: FontWeight.bold)),
                Text(comarca.longitud?.toString()?? 'No se encuentra'),
              ],
            ),
          ],
        ),
      ),
    );
    
    // TO-DO
    // Afegir la informació següent sobre la comarca:
    // Població (num. d'habitants), latitud i longitud.
    // Podeu combinar Column i Row per mostrar la informació tabulada

    // Abans de la informació, caldrà mostrar la informació sobre l'oratge a la comarca,
    // mitjançant el widget personalitzat MyWeatherInfo(), que se us proporciona ja implementat
    
  }
}
