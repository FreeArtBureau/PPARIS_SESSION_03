//-------------------------------------------------------------------------
// Génère autant de racines qu'il en faut pour retranscrire l'heure actuelle
void initRacines(){
  Racine tempRacine;
  float heures, minutes;
  heures = hour();     minutes = minute();
  
  for(int i=0; i<heures; i++){
    ajouterUneRacine( centre , random(TWO_PI/24)+ i*(TWO_PI/24), 3600);
    tempRacine = (Racine) list_racines.get( list_racines.size()-1 );
    if( i < heures-1 ){
      tempRacine.jumpToAge(3600);
    }
    else{
      tempRacine.jumpToAge( round(minutes*60) );
    }
  }
}

//----------------------------------------------------------
// Ajoute une Racine à la liste des Racines
void ajouterUneRacine( PVector _pos, float _angle, int _max){
  list_racines.add( (Racine) new Racine( _pos , _angle, _max ) );
}
