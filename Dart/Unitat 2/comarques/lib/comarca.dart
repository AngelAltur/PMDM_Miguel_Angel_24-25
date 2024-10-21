class Comarca {
  late String comarca;
  String? capital;
  String? poblacio;
  String? img;
  String? desc;
  double? latitud;
  double? longitud;


  Comarca({
    required this.comarca,
    this.capital,
    this.poblacio,
    this.img,
    this.desc,
    this.latitud,
    this.longitud
  });

  Comarca.fromJSON(Map<String,dynamic> objecteJSON){
    comarca = objecteJSON['comarca'] as String;
    capital = objecteJSON['capital'] as String?;
    poblacio= objecteJSON['poblacio'] as String?;
    img = objecteJSON['img'] as String?;
    desc= objecteJSON['desc'] as String?;
    latitud= objecteJSON['latitud'] as double?;
    longitud= objecteJSON['longitud'] as double?;
  }
  @override
  String toString() {
    return '''\nom: \t$comarca
    capital:  \t$capital
    poblacio: \t$poblacio
    \n
    Imatge:   \t$img
    descriopció:  \t$desc
    Coordenades:  \t($latitud,$longitud)
    ''';
  }
}
