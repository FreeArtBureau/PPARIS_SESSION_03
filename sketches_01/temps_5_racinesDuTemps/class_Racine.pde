class Racine
{
  int age;     // age de base
  int age_max; // 60 pour les branche_minutes, et 3600 pour les branches heures
  
  PVector pos_begin; // le point de DEPART la Racine
  PVector pos_last; // position de la POINTE de la Racine
  
  float dir_angle; // la direction empruntée par la Racine
  float dir_random; // l'écart que peut emprunter le chemin de la Racine, à chaque "update()"
  
  float weight, weight_min; // l'épaisseur du trait
  float sub_length; // longueur de chaque sous-segment
  int couleur; // la couleur du trait
  
  int _STATUS; // le statut : 1 (croissance), 0 (mort)
  boolean is_jumping; // si true, cela veut dire que la Racine est dessinée à l'initialisation de l'application
  
  
  // Constructeur - - - 
  Racine(PVector _pos, float _angle, int _max){
    pos_begin = new PVector(_pos.x, _pos.y);
    pos_last  = new PVector(_pos.x, _pos.y);
    
    dir_angle = _angle;
    dir_random = PI/48; // coefficient de décalage de la trajectoire
    
    weight = 3;
    weight_min = 0.5;
    
    // Longueur des sous-segments 
    // la première valeur, après " ? " est pour les Racines "heure",
    // la seconde, après " : " pour les Racines "minutes" (ou autre)
    sub_length = (_max == 3600)? .1 : .5; 
    
    couleur = 0; // noir
    
    age = 0;
    age_max = _max;
    
    _STATUS = 1;
    is_jumping = false;
  }
  
  //---------------------------------------
  void update(){
    if(_STATUS == 0) return;
    age++;
    // arrete la procedure si la racine est trop vieille
    if(age >= age_max){
      if(age_max == 3600){
        couvreLeFond();
        // SIMULATION
//        if(!is_jumping) ajouterUneRacine( centre , random(TWO_PI) , 3600 );
      }
      kill();
      return;
    }
    
    // on rajoute une Racine "minute" tous les 60 incrémentations d'"age" (age % 60 == 0)
    // si la Racine est une Racine "heure" (age_max == 3600)
    if(age%60==0 && age_max == 3600 && age != 0){
      ajouterUneRacine( pos_last , dir_angle + random(HALF_PI)-(HALF_PI/2) , 60 );
      if(is_jumping){
        ((Racine) list_racines.get(list_racines.size()-1)).jumpToAge( 60 );
      }
    }
    
    //calcule le prochain point
    dir_angle += random(dir_random)-(dir_random/2);
    PVector pos_next = new PVector( pos_last.x + cos(dir_angle)*sub_length ,
                                    pos_last.y - sin(dir_angle)*sub_length
                                   );
    pushStyle();
    stroke( 0 + (float(age)/float(age_max))*200 );
    strokeWeight(getWeight());
    // dessine le dernier point en noir
    line( pos_last.x, pos_last.y ,
          pos_next.x, pos_next.y 
        );
    popStyle();
    
    // on stocke la position vers laquelle notre trait vient d'être tracé
    pos_last = new PVector(pos_next.x, pos_next.y);
  }
  
  //-----------------------
  // Fonction qui simule une croissance instantanée de la Racine
  // Utilisé à l'initialisation de l'application
  void jumpToAge(int new_age){
    is_jumping = true;
    // dessine toutes les étapes qu'il manque afin de retranscrire visuellement
    // toutes les heures et minutes passées
    for(int i=age; i<new_age; i++){
      update();
    }
    is_jumping = false;
  }
  
  //----------------
  void kill(){
    _STATUS = 0;
  }
  
  //----
  // Définition de l'épaisseur du trait
  float getWeight(){
    return (age_max == 3600) ? 1.5 : 1; // ici, en fonction de l'age maximal de la Racine
  }
  
}
