// Importació de llibreries

import 'dart:io';
import 'package:comarquescli/comarca.dart';
import 'package:comarquescli/comarques_service.dart';
import 'package:comarquescli/provincia.dart';

void main(List<String> arguments) {

  // Comprovem el nombre d'arguments
  if (arguments.isEmpty) {
    print("\x1B[31m Nombre d'arguments incorrectes\x1B[0m");
    exit(-1);
  }

  // Parsegem la llista d'arguments
  List<String> llistaArgs = List.from(arguments);
  String? ordre;
  String? args;

  // Separem l'ordre (provincies, comarques, infocomarca) de la llista d'arguments
  ordre = llistaArgs[0];
  llistaArgs.removeAt(0);
  args = llistaArgs.join(" ");

  switch (ordre) {
    case "provincies":
      mostraProvincies();        // Implementació amb Future
      // mostraProvinciesSync(); // Implementació amb async/await
      break;

    case "comarques":
      if (arguments.length != 2) {
        print(
            "\x1B[31m Nombre d'arguments incorrectes. Cal especificat la província.\x1B[0m");
        exit(-1);
      }
      mostraComarques(args);
      break;

    case "infocomarca":
      if (arguments.length < 2) {
        print(
            "\x1B[31m Nombre d'arguments incorrectes. Cal especificat la Comarca.\x1B[0m");
        exit(-1);
      }
      mostraInfoComarca(args);
      break;
    default:
      print("\x1B[31mOrdre desconeguda\x1B[0m");
  }
}

// Implementació de mostraProvincies fent ús del Future

mostraProvincies() {
  // La llista de províncies vindrà en un Future
  Future<List<Provincia>> respostaFuture = ComarquesService.obtenirProvincies();

  // Preparem el callback
  respostaFuture.then((resposta) {
    if (resposta.isNotEmpty) {
      // Recorrem la llista per mostrar els resultats
      for (var provincia in resposta) {
        print(provincia.toString());
      }
    } else {
      print("\x1B[31mNo s'ha obtingut cap resposta\x1B[0m");
    }
  });
}

// Implementació de mostraProvincies amb async/await

mostraProvinciesSync() async {
  // La llista de províncies s'obté directament
  List<Provincia> provincies = await ComarquesService.obtenirProvincies();

  if (provincies.isNotEmpty) {
    for (var provincia in provincies) {
      print(provincia.toString());
    }
  } else {
    print("\x1B[31mNo s'ha obtingut cap resposta\x1B[0m");
  }
}

mostraComarques(String provincia) {
  // TO-DO
Future<List> respostaFuture = ComarquesService.obtenirComarques(provincia);

respostaFuture.then((resposta) {
    if (resposta.isNotEmpty) {
      // Recorrem la llista per mostrar els resultats
      for (var comarca in resposta) {
        print(comarca.toString());
      }
    } else {
      print("\x1B[31mNo s'ha obtingut cap resposta\x1B[0m");
    }
  });
  
  print("\x1B[35m Funció pendent d'implementació \x1B[0m");

}

mostraInfoComarca(String comarca) async {
  // TO-DO
  // La llista de comarques s'obté directament
  Comarca? com = (await ComarquesService.infoComarca(comarca));
    if (com != null){
      print(com.toString());
    }else{
      print("No se ha encontrado la comarca.");
    }
}



