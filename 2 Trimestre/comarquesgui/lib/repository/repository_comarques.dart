import 'package:comarquesgui/models/comarca.dart';
import 'package:comarquesgui/models/provincia.dart';
import 'package:comarquesgui/services/comarques_service.dart';

class RepositoryComarques {
  static Future<List<Provincia>> obtenirProvincies()  {
    // Retorna una llista de provincies, obtingudes a partir de la
    // funcionalitat proporcionada per l'API
    return ComarquesService.obtenirProvincies();
  }

  static Future<List> obtenirComarques(String provincia) async {
    // TO-DO 2

    // Retorna una llista d'objectes dinàmics amb el nom i la imatge
    // de cada comarca de la província indicada. Per a això fa ús de
    // la funcionalitat proporcionada al mètode obtenirComarques del
    // servei de ComarquesService.
    var comarques = await ComarquesService.obtenirComarques(provincia);
    List<dynamic> result=comarques.map((comarca) => {
      'nom': comarca['nom']??"no trabada",
      'img': comarca["img"]??"no trobada",
    }).toList();
    return result;
    
  }

  static Future<Comarca?> obtenirInfoComarca(String comarca) async {
    // TO-DO 3

    // Retorna la informació completa de la comarca sol·licitada, 
    // fent ús del mètode infoComarca de la classe sel servei de Comarques.

    return await ComarquesService.infoComarca(comarca); // Caldrà eliminar este return

  }
}
