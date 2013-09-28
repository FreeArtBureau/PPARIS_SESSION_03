/**
  Exemple de représentation linéaire du temps en décompte
Dans ce contexte nous devons définir plusieurs chose :
- l'heure actuelle
- un objectif temporel à atteindre
- un bloc visuel dont la taille nous permettra de visualiser le décompte

Pour cela nous devons stocker sous formes de variables plusieurs éléments stratégiques :
- la longueur du bloc
- ce qu'il représente en minutes ou en heures (afin de placer des éléments sur sa longueur)

**/

// Définition des variables temporelles
float goal_sec, goal_min, goal_hour, goal_tmstmp; // l'OBJECTIF à atteindre
float ini_sec, ini_min, ini_hour, ini_tmstmp;     // l'heure à laquelle l'application démarre
float now_sec, now_min, now_hour, now_tmstmp;     // l'heure actuelle, redéfinie à chaque passage du "draw()"

// Définition des variables spaciales
float margin;           // la marge, appliquée à droite et à gauche du bloc visuel
float frise_width;      // la largeur du bloc, en fonction de la taille de l'écran et de la marge
float frise_total_time; // ce que représente le bloc en secondes (si 2 heure; alors 2*3600 = 7200 secondes
float centre_y;         // position en Y, référence pour tous les objets visuels

void setup() {
  // taille de la fenêtre
  size(600, 300);

  // définition de l'objectif
  goal_sec    = 0;
  goal_min    = 52;
  goal_hour   = 13;
  goal_tmstmp = getInSecondes(goal_hour, goal_min, goal_sec); // on transforme une heure HH:MM:SS en secondes uniquement

  // définition de l'heure de départ
  ini_sec    = second();
  ini_min    = minute();
  ini_hour   = hour();
  ini_tmstmp = getInSecondes(ini_hour, ini_min, ini_sec); // on transforme une heure HH:MM:SS en secondes uniquement

  // définition des valeurs spaciales
  margin           = 20;
  frise_width      = width - margin*2; // longueur du bloc en pixels
  frise_total_time = 2 * 3600;         // en secondes; 2heures
  
  // on stocke dans une varibale la position en Y du bloc
  // cette valeur étant la référence à tous les objets dessinés par la suite
  // il est inutile de la recalculer pour chaque élément
  centre_y = height - 50 ;  
}



void draw() {
  // on colorie le fond de la scène en blanc (255)
  background(255);
  
  // redéfinition des valeurs actuelles de temps
  now_sec  = second();
  now_min  = minute();
  now_hour = hour();
  now_tmstmp = getInSecondes(now_hour, now_min, now_sec); // en secondes uniquement

  //dessin du bloc
  fill(0); // remplissage en noir
  textAlign(CENTER); // les textes seront centrés

  rect( margin, centre_y, frise_width, 40); // dessin du rectangle
  
  
  // position dans le temps de l'heure de notre OBJECTIF
  // on dessine ici un trait + un texte
  float pos_x_bar = map( goal_tmstmp, 
                         ini_tmstmp, ini_tmstmp + frise_total_time, 
                         margin, margin + frise_width );
  text("OBJECTIF", pos_x_bar, centre_y-135);
  text(round(goal_hour)+":"+round(goal_min), pos_x_bar, centre_y-123);
  line( pos_x_bar, centre_y, pos_x_bar, centre_y-120);

  
  // on dessine la position actuelle dans le temps, de la même manière
  float pos_x_now = map( now_tmstmp, 
                         ini_tmstmp, ini_tmstmp + frise_total_time, 
                         margin, margin + frise_width );
  text("NOW", pos_x_now, centre_y-60);
  line( pos_x_now, centre_y, pos_x_now, centre_y-60);

}


// Cette fonction nous donne la valeur d'une valeur temporelle composée de l'heure, des minutes, et des secondes
// uniquement en secondes.
float getInSecondes(float h, float m, float s) {
  float ret = h*3600 + m*60 + s;
  return ret; // nous revoie la valeur en secondes
}


