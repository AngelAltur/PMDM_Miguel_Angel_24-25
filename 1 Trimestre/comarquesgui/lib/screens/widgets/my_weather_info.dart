import 'package:flutter/material.dart';

class MyWeatherInfo extends StatelessWidget {
  const MyWeatherInfo({super.key});

// Definim una referència al BLoC

  @override
  Widget build(BuildContext context) {
    //oratgeBloc.actualitzaOratge();

    return Column(
      children: [
        _obtenirIconaOratge("0"),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.thermostat,
              size: 35,
            ),
            Text(
              "5º",
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
              "20 km/h",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(width: 30),
            obteGinyDireccioVent("0.0", context),
          ],
        ),
      ],
    );
  }

  Widget obteGinyDireccioVent(String direccioVent, BuildContext context) {
    double dir = double.parse(direccioVent);
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
