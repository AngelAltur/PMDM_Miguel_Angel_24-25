
import 'package:comarquesgui/models/comarca.dart';
import 'package:comarquesgui/repository/repository_exemple.dart';
import 'package:flutter/material.dart';

class InfoComarcaGeneral extends StatelessWidget {
  const InfoComarcaGeneral({super.key});

  @override
  Widget build(BuildContext context) {

    // Agafem la comarca del repositori
    Comarca comarca = RepositoryExemple.obtenirInfoComarca();
    
    return Scaffold(
      appBar: AppBar(
        title:Text(comarca.comarca),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child:Column(
            crossAxisAlignment:CrossAxisAlignment.start,
            children:[
              Image.network(
                comarca.img!,
                fit: BoxFit.cover,
                width:double.infinity,
                height:200,
              ),
              SizedBox(height:20),
              Text(
                comarca.comarca,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height:10),
              Text(
                'Capital: ${comarca.capital}',
                style:  TextStyle(fontSize:18),
              ),
              const SizedBox(height:10),
              Text(
                comarca.desc!,
                style:TextStyle(fontSize:16),
              ),
            ],
          ),
        ),
      ),
    );
    // TO-DO
    // Afegir la informació següent sobre la comarca:
    // Imatge, nom, capital i descripció, de forma semblanta com es mostra a l'enunciat

    // Podeu fer ús dels ginys i contenidors que considereu oportuns (Containers, SingleChildScrollView, Columns, etc)
    // Heu de tindre en compte de no sobrepassar els límits i dibuixar fora de l'espai disponible
    // Per comprovar que no se n'eixiu, podeu provar a girar el dispositiu (si esteu fent-ho sobre Android)

   
  }
}
