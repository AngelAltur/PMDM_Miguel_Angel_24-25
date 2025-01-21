import 'package:comarquesgui/services/weather_service.dart';

class RepositoryWeather {
  
   // Ofereix un mètode obteClima per accedir al servei

  static Future<dynamic> obteClima(
      {required double longitud, required double latitud}) async {
        // TO-DO:
        // retorna la informació del clima a partir de la classe de servei,
        // proporcionant-li la longitud i la latitud
        var clima= await WeatherService.obteClima(longitud: longitud, latitud: latitud);
         return clima; // Cal modificar aquest return      
      }
}