import 'package:flutter/material.dart';
import 'package:comarquesgui/services/weather_service.dart';

// TO-DO 7b: Converteix la classe en StateFull,
// (es pot fer amb les ajudes de codi, amb Ctrl+"." damunt el nom de classe)
// i defineix dins l'estat una propietat (dynamic)
// que contindrà la informació futura amb l'oratge.
// Després inicialitza l'estat (initState), de manera que
// obtinga aquesta informació de forma asíncrona 
// a través del mètode obteClima del repositori corresponent.
// Tingueu en compte que aquest mètode requereix de latitud
// i longitud, i que aquestes propietats s'ho troben al widget
// (és a dir, cal accedir a widget.latitud, etc.)

class MyWeatherInfo extends StatefulWidget {
  // TO-DO 7a: Incorpora les propietats latitud i longitud 
  // a aquesta classe (com a Double) i modifica el 
  // constructor per a que les reba com a arguments amb nom

  const MyWeatherInfo({super.key, required this.latitud, required this.longitud});

  final double latitud;
  final double longitud;

  @override
  _MyWeatherInfoState createState() => _MyWeatherInfoState();
}

class _MyWeatherInfoState extends State<MyWeatherInfo> {
  dynamic oratge;

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  Future<void> _fetchWeather() async {
  final clima = await WeatherService.obteClima(
    latitud: widget.latitud ?? 0,
    longitud: widget.longitud ?? 0,
  );
  setState(() {
    oratge = clima;
  });
}


  @override
  Widget build(BuildContext context) {
    // TO-DO 7c: Modifica la construcció d'aquest giny
    // fent ús d'un FutureBuilder, de manera que quan la
    // informació estiga disponible el genere amb les 
    // dades obtingudes.
    
    return FutureBuilder(
      future: WeatherService.obteClima(
        latitud: widget.latitud ?? 0,
        longitud: widget.longitud ?? 0,
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final oratge = snapshot.data;
          return Column(
            children: [
              _obtenirIconaOratge(oratge['weather_code'].toString()),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.thermostat,
                    size: 35,
                  ),
                  Text(
                    "${oratge['temperature']}º",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.wind_power, size: 35),
                  const SizedBox(width: 30),
                  Text(
                    "${oratge['wind_speed']} km/h",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(width: 30),
                  obteGinyDireccioVent(oratge['wind_direction'].toString(), context),
                ],
              ),
            ],
          );
        }
      },
    );
  }

  Widget obteGinyDireccioVent(String? direccioVent, BuildContext context) {
  double dir = 0; // Valor predeterminado para evitar excepciones.
  if (direccioVent != null && direccioVent.isNotEmpty) {
    try {
      dir = double.parse(direccioVent);
    } catch (e) {
      print('Error: $e');
    }
  }
    late Icon icona;
    late String nomVent;

    if (dir > 22.5 && dir < 65.5) {
      icona = const Icon(Icons.north_east);
      nomVent = "Gregal";
    } else if (dir > 67.5 && dir < 112.5) {
      icona = const Icon(Icons.east);
      nomVent = "Llevant";
    } else if (dir > 112.5 && dir < 157.5) {
      icona = const Icon(Icons.south_east);
      nomVent = "Xaloc";
    } else if (dir > 157.5 && dir < 202.5) {
      icona = const Icon(Icons.south);
      nomVent = "Migjorn";
    } else if (dir > 202.5 && dir < 247.5) {
      icona = const Icon(Icons.south_west);
      nomVent = "Llebeig/Garbí";
    } else if (dir > 247.5 && dir < 292.5) {
      icona = const Icon(Icons.west);
      nomVent = "Ponent";
    } else if (dir > 292.5 && dir < 337.5) {
      icona = const Icon(Icons.north_west);
      nomVent = "Mestral";
    } else {
      icona = const Icon(Icons.north);
      nomVent = "Tramuntana";
    }
    return Row(children: [
      Text(
        nomVent,
        style: Theme.of(context).textTheme.headlineSmall,
      ),
      icona,
    ]);
  }

  // Codis de https://open-meteo.com/en/docs/dwd-api

  Widget _obtenirIconaOratge(String value) {
    Set<String> sol = <String>{"0"};
    Set<String> pocsNuvols = <String>{"1", "2", "3"};
    Set<String> nuvols = <String>{"45", "48"};
    Set<String> plujasuau = <String>{"51", "53", "55"};
    Set<String> pluja = <String>{
      "61",
      "63",
      "65",
      "66",
      "67",
      "80",
      "81",
      "82",
      "95",
      "96",
      "99"
    };
    Set<String> neu = <String>{"71", "73", "75", "77", "85", "86"};

    if (sol.contains(value)) {
      return Image.asset("assets/icons/png/soleado.png");
    }
    if (pocsNuvols.contains(value)) {
      return Image.asset("assets/icons/png/poco_nublado.png");
    }
    if (nuvols.contains(value)) {
      return Image.asset("assets/icons/png/nublado.png");
    }
    if (plujasuau.contains(value)) {
      return Image.asset("assets/icons/png/lluvia_debil.png");
    }
    if (pluja.contains(value)) {
      return Image.asset("assets/icons/png/lluvia.png");
    }
    if (neu.contains(value)) {
      return Image.asset("assets/icons/png/nieve.png");
    }

    return Image.asset("assets/icons/png/poco_nublado.png");
  }
}
