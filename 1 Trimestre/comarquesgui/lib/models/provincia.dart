class Provincia {
  late String nom; // Declarem el nom, i indiquem que l'inicialitzarem després
  String? imatge; // La url a la imatge és nul·lable

  /* 
  Constructor amb arguments amb nom: 
   - nom és obligatori, i 
   - imatge opcional.
  */
  Provincia({
    required this.nom,
    this.imatge,
  });

  /* 
  Constructor amb nom a partir d'un diccionari.
  */

  Provincia.fromJSON(Map<String, dynamic> objecteJSON) {
    nom = objecteJSON["provincia"] ?? "";
    imatge = objecteJSON["img"] ?? "";
  }

  @override
  String toString() => '''\x1B[34mNom:\t\x1B[36m$nom\x1B[0m
\x1B[34mImatge:\t\x1B[36m$imatge\n\x1B[0m''';
}