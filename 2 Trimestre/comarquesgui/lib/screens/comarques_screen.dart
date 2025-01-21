import 'package:comarquesgui/models/comarca.dart';
import 'package:comarquesgui/repository/repository_comarques.dart';
import 'package:comarquesgui/screens/infocomarca_screen.dart';
import 'package:comarquesgui/services/comarques_service.dart'; 
import 'package:flutter/material.dart';

class ComarquesScreen extends StatelessWidget {
  const ComarquesScreen({super.key, required this.provincia});

  final String provincia;

  @override
  Widget build(BuildContext context) {
    String prefix = "Comarques de ";
    if (provincia.startsWith(RegExp(r'[AaEeIiOoUu]'))) {
      prefix = "Comarques d'";
    }

    return Scaffold(
        appBar: AppBar(
          title: Text("$prefix$provincia",
              style: const TextStyle(
                fontFamily: "LeckerliOne",
                fontSize: 30,
              )),
        ),
        body: Center(
          // TO-DO 4: Afig un giny FutureBuilder, que depenga del
          // Future proporcionat pel mètode d'obteció de comarques
          // del repositori corresponent. Quan es dispose
          // d'aquesta informació es crearà la llista de comarques,
          // i mentre aquesta no es tinga, mostrarem un indicador de progrés.
          child: FutureBuilder(
            future: RepositoryComarques.obtenirComarques(provincia), 
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return _creaLlistaComarques(snapshot.data ?? []);
              }
            },
          ),
        ));
  }

  _creaLlistaComarques(List<dynamic> comarques) {
    return ListView.builder(
      itemCount: comarques.length,
      itemBuilder: (BuildContext context, int index) {
        if (comarques.isNotEmpty) {
          String img = comarques[index]["img"];
          String comarca = comarques[index]["nom"];

          return ComarcaCard(img: img, comarca: comarca);
        } else {
          return const Center(
            child: Text("La llista és buida"),
          );
        }
      },
    );
  }
}

class ComarcaCard extends StatelessWidget {
  const ComarcaCard({
    super.key,
    required this.img,
    required this.comarca,
  });

  final String img;
  final String comarca;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push<void>(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => InfoComarcaScreen(
              nomComarca: comarca,
            ),
          ),
        );
      },
      child: Card(
        child: Container(
            height: 150,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(image: NetworkImage(img), fit: BoxFit.cover),
            ),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                comarca,
                style: const TextStyle(
                    fontFamily: "LeckerliOne",
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20,
                    shadows: [
                      Shadow(
                          offset: Offset(2, 2),
                          color: Colors.black,
                          blurRadius: 3),
                    ]),
              ),
            )),
      ),
    );
  }
}

