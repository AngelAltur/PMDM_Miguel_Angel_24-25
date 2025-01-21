import 'dart:convert'; // Per realitzar conversions entre tipus de dades
import 'dart:io';
import 'package:comarquescli/comarca.dart';
import 'package:comarquescli/provincia.dart';
import 'package:http/http.dart' as http;

class ComarquesService {

    static Future<List<Provincia>> obtenirProvincies() async {
    // Obté la llista de províncies
    try {
      String url =
          "https://node-comarques-rest-server-production.up.railway.app/api/comarques/provincies";
      var data = await http.get(Uri.parse(url));

      // Preparem la llista de províncies a retornar
      List<Provincia> llistaProvincies = [];

      if (data.statusCode == 200) {
        // Si hi ha resposta la processem per retornar-la com
        // a llista de províncies

        String body = utf8.decode(data.bodyBytes);
        final bodyJSON = jsonDecode(body) as List;

        // Forma 1. Recorrem el JSON i creem la llista de provincies
        /*for (var provinciaJSON in bodyJSON) {
          // Amb el constructor per defecte
          llistaProvincies.add(Provincia(
            nom: provinciaJSON["provincia"],
            imatge: provinciaJSON["img"],
          ));

          // Alternativa: Amb el constructor amb nom
           //llistaProvincies.add(Provincia.fromJSON(provinciaJSON));
        }*/

        // Forma 2: Fem ús del mapat d'estructures
        llistaProvincies = bodyJSON.map((provinciaJSON) {
          // Amb el constructor per defecte
          return Provincia(
            nom: provinciaJSON["provincia"],
            imatge: provinciaJSON["img"],
          );
          // Amb el constructor amb nom
          //return Provincia.fromJSON(provinciaJSON);
        }).toList();
      }
      // I finalment retornem la llista
      return llistaProvincies;
    } catch (except) {
      print(except.toString());
      return [];
    }
  }



  static Future<List<dynamic>> obtenirComarques(String provincia) async {
    // TO-DO
     try {
      String url =
          "https://node-comarques-rest-server-production.up.railway.app/api/comarques/$provincia";
      var data = await http.get(Uri.parse(url));
      

      if (data.statusCode == 200) {
        String body = utf8.decode(data.bodyBytes);
        final bodyJSON = jsonDecode(body) as List;
        return bodyJSON;
      }
      else{
        return [];
      }

    } catch (except) {
      print(except.toString());
      return [];
    }
  }

  static Future<Comarca?> infoComarca(String comarca) async {
    // TO-DO
    try {
      String url =
          "https://node-comarques-rest-server-production.up.railway.app/api/$comarca/";
      var data = await http.get(Uri.parse(url));
      

      if (data.statusCode == 200) {
        String body = utf8.decode(data.bodyBytes);
        final bodyJSON = jsonDecode(body);
        return Comarca.fromJSON(bodyJSON);
    }
    } catch (except) {
      print(except.toString());
      return null;
    }
    return null;
  }

}