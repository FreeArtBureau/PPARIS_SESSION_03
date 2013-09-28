// Variable stockant le nombre total de secondes par jour.
float secondeMax;

void setup(){
  // Crée une fenêtre de 600 par 600
  size(600,600);
  
  // 24 heures, en secondes
  secondeMax = 24*3600; 
}


void draw(){
  // colore le fond en fonction de l'HEURE actuelle
  // de minuit (noir) à midi (blanc), puis minuit (noir)
  
  // on crée la variable stockant le nombre représentant la valeur de gris recherchée
  int couleur = 0;
  // la fonction "map()" sert à transposer une valeur numérique dans un autre ordre de grandeur
  // ici nous voulons transformer une valeur allant de 0 à 24 (les heures) en valeur
  // allant de 0 à 255 (une couleur)
  // Rappel :  map ( valeur , min , max , new_min , new_max );
  
  float secondeTotal = hour()*3600 + minute()*60 + second();
  println(secondeTotal);
  if( hour() < 12 )       couleur = color( map( secondeTotal,      0       , secondeMax/2, 0  , 255) );
  else if( hour() >= 12 ) couleur = color( map( secondeTotal, secondeMax/2 , secondeMax,   255, 0  ) );
  
  // on colore le BACKGROUND avec la valeur de gris définie plus haut
  background( couleur );
}
