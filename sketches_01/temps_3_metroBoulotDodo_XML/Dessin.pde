//--------------------------------------------------------------------------
// Fonction qui dessine l'arc de cercle de l'action dont l'identifiant a été transmis en paramètre
void drawTaskByID(int id){
  if(id >= liste_actions.getChildCount()){
    println("ERROR drawTaskByID : id XML n'est pas valide.");
    return;
  }
  
  // on utilise ici l'objet XML nommé "liste_actions", créé dans le "setup()"
  // sauvegarde temporaire du noeud XML qui nous intéresse
  XMLElement tempXML = (XMLElement) liste_actions.getChild(id);
  // récupération de la signature temporelle, en secondes, des deux informations 
  // "start" et "end" délimitant une action dans le temps
  float start = getTimeFromString( tempXML.getChild("period").getString("start") );
  float end   = getTimeFromString( tempXML.getChild("period").getString("end") );
  
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
  
  rectMode(CORNER);
  textAlign(LEFT);
  noStroke();
  
  for(int i=0; i<liste_actions.getChildCount(); i++){
    fill(  getColorByID(i)  );
    rect( startX, startY + (caption_height + margin_Y)*i,
          caption_width, caption_height ) ;
    
    fill( 0 ); // texte en noir
    text(liste_actions.getChild(i).getChild("name").getContent() ,
         startX + caption_width + margin_Y, startY + (caption_height + margin_Y)*i + text_Y_translate
         );
  }
  
  popMatrix();
  popStyle();
}
