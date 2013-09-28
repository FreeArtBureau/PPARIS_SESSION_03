//--------------------------------------------------------------------------
// Fonction qui dessine l'arc de cercle de l'action dont l'identifiant a été transmis en paramètre
void drawTaskByID(int id){
  float start  = 0;
  float end    = 0;
  
  if(id == 0){
    start = getTimeFromString(event_0_start);
    end   = getTimeFromString(event_0_end);
  }
  else if(id == 1){
    start = getTimeFromString(event_1_start);
    end   = getTimeFromString(event_1_end);
  }
  else if(id == 2){
    start = getTimeFromString(event_2_start);
    end   = getTimeFromString(event_2_end);
  }
  
  // rayon de l'arc à dessiner
  float rayon = action_weight + cadran_rayon;
  // on y ajoute une distance déterminée par l'ID de l'action, afin de les dissocier
  // même si elles se chevauchent
  rayon += id * 5;
  
  if(end < start) end += cadran_temps_total;
  
  // on isole le style déterminé pour cette tâche, afin de la distinguer des autres
  pushMatrix();
  pushStyle();
  fill( getColorByID(id) );
  noStroke();
  arc( 0, 0,  // l'arc est centré là où le point [0;0] est positionnée
       rayon, rayon,
       map( start, 0, cadran_temps_total,   0.0, TWO_PI ),
       map( end,   0, cadran_temps_total,   0.0, TWO_PI )       
       );
  
  popStyle();
  popMatrix();
}


//--------------------------------------------------------------------------
// Dessine la légende des tâches en haut à gauche de l'écran
// Note : la méthode qui détermine la couleur d'une action doit être la même 
// que celle utilisée pour le dessin des arcs de cercle
void drawCaption(){
  pushStyle();
  pushMatrix();
  resetMatrix(); // ici, nous annulons toute transformation ayant été faite sur la matrice. Le point [0;0] se retrouve donc au coin haut/gauche
  
  float startX = 5;
  float startY = 12;
  float caption_width  = 20;
  float caption_height = 10;
  float text_Y_translate = 9;
  float margin_Y = 5;
  
  String label_str ="";
  
  rectMode(CORNER);
  textAlign(LEFT);
  noStroke();
  
  for(int i=0; i<NUM_EVENTS; i++){
    fill(  getColorByID(i)  );
    rect( startX, startY + (caption_height + margin_Y)*i,
          caption_width, caption_height ) ;
    
    fill( 0 ); // texte en noir
    
    if     ( i == 0 )  label_str = event_0_label;
    else if( i == 1 )  label_str = event_1_label;
    else if( i == 2 )  label_str = event_2_label;
    
    
    text( label_str , // la chaîne de caractère
         startX + caption_width + margin_Y,                        // position en X
         startY + (caption_height + margin_Y)*i + text_Y_translate // position en Y
         );
  }
  
  popMatrix();
  popStyle();
}
