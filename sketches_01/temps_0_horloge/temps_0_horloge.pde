void setup(){
  // Crée une fenêtre de 600 par 600
  size(600,600);
}


void draw(){
  // colore le fond en blanc
  background(255);
  
  // on stocke les valeurs actuelles des secondes, minutes et heures
  // sous des valeurs allant de 0 à 360, afin de les utiliser comme
  // valeur de rotation
  float degree_sec  = map( second(), 0, 60, 0, 360 );
  float degree_min  = map( minute(), 0, 60, 0, 360 );
  float degree_hour = map( hour(),   0, 12, 0, 360 );
  
  // on positionne le point [0;0] au centre de l'écran
  translate(width/2, height/2);
  
  // on trace l'ellipse du cadran
  ellipse(0, 0, 300, 300);
  
  // puis on trace l'aiguilles des SECONDES
  pushMatrix();
  rotate( radians( degree_sec ) );
  line(0, 0, 0, -100);
  popMatrix();
  
  // l'aiguille des MINUTES
  pushMatrix();
  rotate( radians( degree_min ) );
  line(0, 0, 0, -90);
  popMatrix();
  
  // puis l'aiguille des HEURES
  pushMatrix();
  rotate( radians( degree_hour ) );
  line(0, 0, 0, -50);
  popMatrix();
  
  
  // dessine les nombres des HEURES sous forme de texte
  pushStyle();
  fill(0);
  textAlign(CENTER);
  float rayon_heure = 200;
  for(int i=0; i<12; i++){
    if(i == 0) text("12", cos(i/6.0*PI - PI/2)*rayon_heure, sin(i/6.0*PI - PI/2)*rayon_heure   );
    else       text(""+i, cos(i/6.0*PI - PI/2)*rayon_heure, sin(i/6.0*PI - PI/2)*rayon_heure   );
  }
  popStyle();
  
  // dessine les nombres des MINUTES sous forme de texte
  pushStyle();
  fill(0);
  textAlign(CENTER);
  textSize(8);
  float rayon_min = rayon_heure - 20;
  for(int i=0; i<60; i++){
    if(i == 0) text("60", cos(i/30.0*PI - PI/2)*rayon_min, sin(i/30.0*PI - PI/2)*rayon_min   );
    else       text(""+i, cos(i/30.0*PI - PI/2)*rayon_min, sin(i/30.0*PI - PI/2)*rayon_min   );
  }
  popStyle();
  
}
