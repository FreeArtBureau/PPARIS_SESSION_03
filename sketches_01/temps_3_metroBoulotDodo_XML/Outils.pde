//--------------------------------------------------------------------------
// Fonction définissant la couleur par position de l'action dans la liste XML
// Il est nécessaire d'écrire une fonction isolée comme celle-ci, car la légende comme
// le dessin des arcs de cercles doivent avoir la même couleur.
int getColorByID(int id){
  int couleur = round(255.0 * (float(id) / float(liste_actions.getChildCount())));
  return couleur;
}


//--------------------------------------------------------------------------
// Convertit une chaine de caractère de type "00h00m00s" sous la forme 
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

//--------------------------------------------------------------------------
// Fonction générant la liste des actions en cours, sous la forme d'une chaîne de caractère
// Ex. : "Mon action", ou "Mon action, mon autre action"
String getCurrentActionName(int now_time){
  // on parcourt la liste des actions pour déterminer quelle action est en cours.
  // sous la forme "action" ou "action1, action2, etc., actionN" 
  String action_names = "";
  int action_count = 0;
  
  float start, end;
  for(int i=0; i<liste_actions.getChildCount(); i++){
    start = getTimeFromString(liste_actions.getChild(i).getChild("period").getString("start"));
    end   = getTimeFromString(liste_actions.getChild(i).getChild("period").getString("end"));
    
    if( start > end && now_time > end) end += 24*3600;
    if( start > end && now_time < end) start -= 24*3600;
    
    
    if(start < now_time 
    && end >= now_time){
      if(action_count > 0) action_names += ", ";
      action_names += liste_actions.getChild(i).getChild("name").getContent();
      action_count++;
    }
  }
  
  return action_names;
}


