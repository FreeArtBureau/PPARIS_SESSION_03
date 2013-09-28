// convertit une chaine de caractère de type "00h00m00s" sous la forme 
// d'un nombre entier représentant le temps en nombre de seconde
// Exemple :
//    si on donne "12h00m00s" , nous obtiendrons un nombre égal à 12 x 3600 = 43200
float getTimeFromString(String heure_str){
  if(heure_str.length() != 9
     && heure_str.indexOf("h") == 2
     && heure_str.indexOf("m") == 5
     && heure_str.indexOf("s") == 8
     ){
     println("ERROR getTimeFromString : le format d'heure n'est pas sous la forme 00h00m00s");
     return -1;
  }
  
  float h = Integer.parseInt( heure_str.substring(0, 2) );
  float m = Integer.parseInt( heure_str.substring(3, 5) );
  float s = Integer.parseInt( heure_str.substring(6, 8) );
  
  return ( (h*3600) + (m*60) + s );
}

////////////////////////////////////////////////////////////////////////////////////////////
// Crée un objet easy_Date affichant la date exacte relativement à votre date de naissance
easy_Date getRelativeDateFrom( easy_Date _now, easy_Date _relative ){
  String url_request = "http://www.mixtur.es/_testDev/get_date.php?";
  
  // nous complétons l'url de la requête en y ajoutant les valeurs
  // des deux dates à comparer
  // y0 , m0 , d0 : l'année, le mois, et le jour de la date actuelle
  url_request += "y0="  + _now._year;
  url_request += "&m0=" + _now._month;
  url_request += "&d0=" + _now._day;
  
  // y1 , m1 , d1 : l'année, le mois, et le jour de la nouvelle référence
  url_request += "&y1="  + _relative._year;
  url_request += "&m1=" + _relative._month;
  url_request += "&d1=" + _relative._day;
  
  // on transmet la requête, et on récupère ce que PHP nous renvoit
  // sous la forme de plusieurs lignes de texte
  // Dans notre cas actuel, il n'y aura qu'une seule ligne de texte
  // à laquelle nous accéderons par  "resultat[0]"
  String[] resultat = loadStrings(url_request);
  
  
  // La nouvelle date nous arrive sous cette forme : 1900y01m30d
  // il faut donc isoler ces éléments en fonction des caractrères "y", "m", et "d"
  int annee, mois, jour;
  annee = Integer.parseInt( resultat[0].substring( 0,                          resultat[0].indexOf("y"))) ;
  mois  = Integer.parseInt( resultat[0].substring( resultat[0].indexOf("y")+1, resultat[0].indexOf("m"))) ;
  jour  = Integer.parseInt( resultat[0].substring( resultat[0].indexOf("m")+1, resultat[0].indexOf("d"))) ;

  easy_Date retour = new easy_Date(annee, mois, jour);
  return retour; // on transmet la nouvelle date.
}


