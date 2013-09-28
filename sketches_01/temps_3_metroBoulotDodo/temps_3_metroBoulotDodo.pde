/**
Une frise chronologique d'évènements prédéfinis défile/tourne autour d'un cadran, fixe.
Contrairement à une montre, dont les aiguilles tournent pour indiquer l'heure, ici nous faisons
tourner les évènements pour les aligner à une aiguille fixe.

Les évènements sont stockés dans des variables comprenant :
- un label : le nom de l'action à entreprendre
- une heure de début
- une heure de fin
**/

// Définition des variables globales
float cadran_rayon; // taille du cadran
float cadran_temps_total; // ce que répresente un tour de cadran, en temps
float action_weight; // épaisseur de l'arc() des actions
float rotation_generale; // indice de rotation générale de l'emploi du temps
XMLElement liste_actions; // emploi du temps : liste des actions à entreprendre sur 24h

// Définition des évènements
int NUM_EVENTS = 3; // nombre total des évènements

String event_0_label = "Métro";
String event_0_start = "09h30m00s";
String event_0_end   = "10h30m00s";

String event_1_label = "Boulot";
String event_1_start = "10h30m00s";
String event_1_end   = "19h30m00s";

String event_2_label = "Dodo";
String event_2_start = "21h30m00s";
String event_2_end   = "08h30m00s";

// DEBUG
Boolean ACCELERATION = false; // définit si on veut accélérer le temps (true) ou laisser le temps au temps (false)

//--------------------------------------------------------
void setup(){
  // Crée une fenêtre de 600 par 600
  size(600,600);
  smooth();
  
  // définition des valeurs des variables globales
  cadran_rayon       = 250;
  cadran_temps_total = 24 * 3600; // 24 heures, en secondes
  action_weight      = 20; // 20 pixels de plus que le cadran
  rotation_generale  = 0;
}

//----------------------------------------------------------
void draw(){
  // colore le fond en blanc
  background(255);
  
  float degree_sec  = map( second(), 0, 60, 0, 360 );
  float degree_min  = map( minute(), 0, 60, 0, 360 );
  float degree_hour = map( hour(),   0, 12, 0, 360 );
  
  // on deplace le point [0;0] au centre de l'écran
  translate( width/2, height/2);
  

  pushMatrix();  // <!-- ISOLATION de la rotation générale de la scène 
  
  String heure_str = ( hour()<10 ? ("0"+hour()) : hour() ) + "h";
  heure_str       += ( minute()<10 ? ("0"+minute()) : minute() ) + "m";
  heure_str       += ( second()<10 ? ("0"+second()) : second() ) + "s";
  float heure_num = getTimeFromString(heure_str) ;
  if( ACCELERATION ) heure_num += frameCount*300; // ACCELERATION - pour le DEBUG
  
  heure_num %= cadran_temps_total;
  
  rotate( map( heure_num ,
          0 ,  cadran_temps_total,
          0.0, TWO_PI*-1) );
    
  
  // on dessine d'abord les actions, sous forme d'arc de cercle
  // ces arcs seront ensuite masqués en partie par le cadran lui-même
  rotate(-PI/2);
  for(int i=0; i< NUM_EVENTS ; i++){
    // ici on utilise une fonction visible dans l'onglet "Dessin"
    drawTaskByID(i);
  }
  
  popMatrix();   // fin de l'ISOLATION de la rotation générale ---/>
  
  
  // dessin du CADRAN
  ellipseMode(CENTER); // on dessinera l'ellipse depuis son centre
  fill( 255 ); // remplissage en blanc (255)
  stroke( 0 ); // contour en noir (0)
  strokeWeight(3); // épaisseur du trait à 3 pixels
  ellipse(0, 0, cadran_rayon, cadran_rayon);
  
  // dessin de d'un triangle pointant vers le moment présent
  noStroke(); // pas de contour
  fill(0); // remplissage en noir (0)
  // dessin du triangle grâce à la fonction "quad()", en 4 points (dont les deux derniers sont égaux)
  // Rappel : quad( A.x, A.y, B.x, B.y, C.x, C.y, D.x, D.y );
  quad( -10, cadran_rayon*-.35 , // A
         10, cadran_rayon*-.35 , // B
         0,  cadran_rayon*-.45 , // C
         0,  cadran_rayon*-.45   // D
        );
   
   
  // dessin du texte de l'heure actuelle
  pushMatrix(); // on isole les prochaines transformations de matrice
  textAlign(CENTER); // le texte sera aligné en son centre
  scale(2); // on multplie les prochaines coordonnées par 2 (zoom de toute la scène)
  
  // ici on écrit la liste des actions identifiées comme étant "en cours" (face à la pointe)
  // cette fonction est visible dans l'onglet "Outils"
  text( getCurrentActionName( round( heure_num )), 0, 4);
  popMatrix(); // fin du "Zoom"
  
  
  // ici on utilise une fonction visible dans l'onglet "Dessin"
  // afin de dessiner la légende en haut à droite
  drawCaption();
}
