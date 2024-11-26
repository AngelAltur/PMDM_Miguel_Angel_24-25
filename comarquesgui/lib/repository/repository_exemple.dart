import 'package:comarquesgui/models/comarca.dart';
import 'package:comarquesgui/models/provincia.dart';

/*
Aquesta classe ens proporciona informació estàtica d'exemple sobre les províncies i comarques.

 */

class RepositoryExemple{

  static List<Provincia> obtenirProvincies(){
    var provincies=[{"provincia":"València","img":"https://upload.wikimedia.org/wikipedia/commons/5/5d/LA_ALBUFERA_DE_VALENCIA_02.jpg"},{"provincia":"Alacant","img":"https://upload.wikimedia.org/wikipedia/commons/thumb/8/85/Alicante%2C_Spain.jpg/640px-Alicante%2C_Spain.jpg"},{"provincia":"Castelló","img":"https://upload.wikimedia.org/wikipedia/commons/thumb/5/55/Pe%C3%B1%C3%ADscola_-_aerial_view.jpg/640px-Pe%C3%B1%C3%ADscola_-_aerial_view.jpg"}];
    return provincies.map((provincia) => Provincia.fromJSON(provincia)).toList();
  }    


  static List<dynamic> obtenirComarques(){
    // Compte, que no es tracta d'objectes de tipus Comarca, 
    // ja que només tenim el nom i la imatge.
    // Es tracta d'un JSON, i per tant és una List<dynamic>
    var comarques=[{"nom":"El Comtat","img":"https://upload.wikimedia.org/wikipedia/commons/a/a5/Senda_hacia_el_Montcabrer.JPG"},{"nom":"L'alcoià","img":"https://upload.wikimedia.org/wikipedia/commons/thumb/1/12/Ull_del_Moro._Alcoi.JPG/1024px-Ull_del_Moro._Alcoi.JPG"},{"nom":"La Marina Alta","img":"https://upload.wikimedia.org/wikipedia/commons/a/a9/Montgo.jpg"},{"nom":"La Marina Baixa","img":"https://upload.wikimedia.org/wikipedia/commons/thumb/0/0c/Puig_Campana.jpg/1024px-Puig_Campana.jpg"},{"nom":"L'Alt Vinalopó","img":"https://upload.wikimedia.org/wikipedia/commons/8/8a/Iglesia_de_Santa_Mar%C3%ADa_y_Castillo_de_Villena.jpg"},{"nom":"El Vinalopó Mitjà","img":"https://upload.wikimedia.org/wikipedia/commons/2/23/Elda-Petrel.jpg"},{"nom":"El Baix Vinalopó","img":"https://upload.wikimedia.org/wikipedia/commons/8/89/Rio_vinalopo_elche_2006-09-04.jpg"},{"nom":"L'alacantí","img":"https://upload.wikimedia.org/wikipedia/commons/f/ff/Alacantivista.jpg"},{"nom":"El baix Segura","img":"https://upload.wikimedia.org/wikipedia/commons/b/bf/Paseo_mar%C3%ADtimo_Torrevieja.JPG"}];
    return comarques;
  }    

  static Comarca obtenirInfoComarca(){
    var comarca={"comarca":"El baix Segura","capital":"Oriola","poblacio":"325.278","img":"https://upload.wikimedia.org/wikipedia/commons/b/bf/Paseo_mar%C3%ADtimo_Torrevieja.JPG","desc":"El Baix Segura (en castellà i cooficialment La Vega Baja) és una comarca del sud del País Valencià amb capital a Oriola. És una comarca de llengua castellana excepte al municipi de Guardamar del Segura, al sud del riu, i la pedania oriolana de Barba-roja, que conserven el valencià. El castellà de la comarca però, igual que a Múrcia, hi té nombrosos préstecs del català. Això es deu al fet que esta comarca era, al segle XV, completament valencianoparlant, però ciutats com Oriola es van castellanitzar pels repoblaments des del segle XVII endavant. ","latitud":38.0856891,"longitud":-0.9448805};
    return Comarca.fromJSON(comarca);
  }    

}