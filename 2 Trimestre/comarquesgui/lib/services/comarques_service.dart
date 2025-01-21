import 'dart:convert'; // Per realitzar conversions entre tipus de dades
import 'dart:io';
import 'package:comarquesgui/models/comarca.dart';
import 'package:comarquesgui/models/provincia.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ComarquesService {

  static Future<List<Provincia>> obtenirProvincies() async {
    // Obté la llista de províncies
    try {
      String url =
          "https://node-comarques-rest-server-production.up.railway.app/api/comarques";
      var data = await http.get(Uri.parse(url));

      // Preparem la llista de províncies a retornar
      List<Provincia> llistaProvincies = [];

      if (data.statusCode == 200) {
        // Si hi ha resposta la processem per retornar-la com
        // a llista de províncies

        String body = utf8.decode(data.bodyBytes);
        final bodyJSON = jsonDecode(body) as List;

        // Fem ús del mapat d'estructures
        llistaProvincies = bodyJSON.map((provinciaJSON) {
          // Amb el constructor per defecte
          return Provincia(
            nom: provinciaJSON["provincia"],
            imatge: provinciaJSON["img"],
          );
        }).toList();
      }
      // I finalment retornem la llista
      return llistaProvincies;
    } catch (except) {
      debugPrint(except.toString());
      return [];
    }
  }

  static Future<List<dynamic>> obtenirComarques(String provincia) async {
    // Obté la llista de Comarques
    String url =
        'https://node-comarques-rest-server-production.up.railway.app/api/comarques/comarquesAmbImatge/$provincia';

    http.Response data = await http.get(Uri.parse(url));
    if (data.statusCode == HttpStatus.ok) {
      String body = utf8.decode(data.bodyBytes);
      final bodyJSON = jsonDecode(body) as List;
      return bodyJSON;
    } else {
      return [];
    }
  }

  static Future<Comarca?> infoComarca(String comarca) async {
    // Obté informació sobre una comarca concreta
    
    String url =
        'https://node-comarques-rest-server-production.up.railway.app/api/comarques/infoComarca/$comarca';

    var data = await http.get(Uri.parse(url));

    if (data.statusCode == 200) {
      String body = utf8.decode(data.bodyBytes);
      final bodyJSON = jsonDecode(body);

      Comarca comarca = Comarca(
        comarca: bodyJSON["comarca"],
        capital: bodyJSON["capital"],
        poblacio: int.parse(bodyJSON["poblacio"].replaceAll(".", "")),
        img: bodyJSON["img"],
        desc: bodyJSON["desc"],
        latitud: bodyJSON["latitud"],
        longitud: bodyJSON["longitud"],
      );
      return comarca;
    } else {
      return null;
    }
  }

  
}
