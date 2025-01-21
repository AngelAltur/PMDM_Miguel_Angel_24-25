import 'dart:io';
import 'dart:convert'; // Per realitzar conversions entre tipus de dades
import 'package:http/http.dart' as http; // Per realitzar peticions HTTP

class WeatherService {
  static Future<dynamic> obteClima(
      {required double longitud, required double latitud}) async {
        // TO-DO 1a:
        // Obtenir el clima des de l'API d'OpenMeteo
        // Per a això feu ús de la implementació d'aquesta
        // mateixa classe en l'exemple d'informació meteorològica.
        final url=Uri.parse(
          'https://api.open-meteo.com/v1/forecast?latitude=$latitud&longitude=$longitud&hourly=temperature_2m');
        try{
          final response = await http.get(url);

          if (response.statusCode == 200){
            final data=json.decode(response.body);
            return data;
          }else{
            return {'error':'Error obtenint la informacio del clima'};
          }
        }catch(e){
          return{'error':'Error de xarxa: $e'};
        }
      }
}
