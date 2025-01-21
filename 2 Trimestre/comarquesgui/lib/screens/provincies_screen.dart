import 'package:comarquesgui/models/provincia.dart';
import 'package:comarquesgui/repository/repository_comarques.dart';
import 'package:comarquesgui/screens/comarques_screen.dart';
import 'package:flutter/material.dart';

class ProvinciesScreen extends StatelessWidget {
  const ProvinciesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: FutureBuilder(
              future: RepositoryComarques.obtenirProvincies(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: _creaLlistaProvincies(snapshot.data ?? []),
                  );
                } else {
                  // Nota: Podeu crear un giny personalitzat
                  // amb aquest contingut, per tindre un
                  // indicador de progrés personalitzat amb
                  // les dimensions correctes i centrat, 
                  // que pugueu reutilitzar en les altres pantalles.
                  return const Center(
                    child: SizedBox(
                        width: 200,
                        height: 200,
                        child: CircularProgressIndicator()),
                  );
                }
              }),
        ),
      ),
    );
  }
}

_creaLlistaProvincies(List<Provincia> provincies) {
  List<Widget> llista = [];
  for (Provincia provincia in provincies) {
    debugPrint("Provincia: ${provincia.nom} amb imatge: ${provincia.imatge}");
    llista.add(
        ProvinciaRoundButton(nom: provincia.nom, img: provincia.imatge ?? ""));
    llista.add(const SizedBox(height: 20));
  }
  return llista;
}

class ProvinciaRoundButton extends StatelessWidget {
  const ProvinciaRoundButton({required this.img, required this.nom, super.key});

  final String img;
  final String nom;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // debugPrint("Clic en ${nom}");
        // Naveguem a la vista de Comarques
        Navigator.push<void>(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => ComarquesScreen(
              provincia: nom,
            ),
          ),
        );
      },
      child: CircleAvatar(
        radius: 110,
        backgroundImage: NetworkImage(img),
        child: Text(
          nom,
          textAlign: TextAlign.end,
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
    );
  }
}
