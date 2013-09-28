/**
Dans cet exemple, le temps est représenté par la formation progressive de "racines".

A chaque heure, une nouvelle "racine" pousse et grandit.
A chaque minute, la "racine" en cours crée une nouvelle "sous-racine" lui poussant dessus.
Ces deux entités, la racine "heure" et la racine "minute" sont issues d'une seule et même Classe,
mais paramétrées différement afin de leur attribuer des comportements distincts.
Le détail de cette classe "Racine" est visible dans l'onglet "class_Racine"

Pour ajouter une racine, n'importe où, il suffit d'utiliser la fonction comme suit :
  ajouterUneRacine( point_de_depart , orientation_initiale , nombre_de_secondes_max );

Ex.: 
- Pour les heures :   ajouterUneRacine( centre , random(PI) , 3600 ); // max 3600 secondes
- Pour les minutes :  ajouterUneRacine( autre  , random(PI) , 60 );   // max  60 


Détails :
- onglet "Outils" : contient les fonctions ajoutant des Racines (au démarrage, et en cours d'exécution)
- onglet "class_Racine" : la classe personnalisée contenant tous les algorithmes nécessaires au dessin de la racine

**/

// Varibles globales spaciales
PVector centre; // le centre d'où partent les racines des heures
PImage bg_image;  // un objet PImage servant à colorer le fond de la scène.
ArrayList list_racines; // la liste des objets "Racine" qui vont être créées au fil du temps

// Variables temporelles
// L'application, en soi, ayant une fréquence qui n'est pas égale à 1 sec, nous allons devoir
// vérifier si, au cours du dernier "draw()" nous en étions à la même seconde ou non. Et agir
// en conséquence.
float last_seconde, last_hour; // dernière seconde, dernière heure

// true : le temps est accéléré ; 
// false : les racines croissent au rythme des secondes qui passent
boolean _SIMULATION = true; 


//---------------------------
void setup(){
  // création de la fenêtre
  size(600,600);
  
  // défintion des variables
  centre = new PVector(width/2, height/2);
  last_seconde = second();
  last_hour    = hour();
  
  list_racines = new ArrayList();
//  ajouterUneRacine( centre , random(TWO_PI) , 3600 ); // exemple d'ajout d'une racine "heure"
  
  // création d'un fond blanc
  background(255);
  bg_image = get(); // "get()" crée une copie de l'image en cours (ici le fond blanc de "background")
    
  //-
  // Initialisation du système de racines, qui va générer les racines que nous aurions du voir
  // si nous avions lancé notre application à 00:00
  // Détail dans l'onglet "Outils"
  initRacines();
  
  if(_SIMULATION) frameRate(100);
}


//----------------------------------------------------
void draw(){
  // Si la dernière seconde enregistrée ne correspond pas aux secondes réelles
  if(last_seconde != second() || _SIMULATION ){
    last_seconde = second(); // on enregistre la nouvelle valeur des secondes
    
    // Si l'heure n'est pas la même, on crée une nouvelle Racine
    if(last_hour != hour() || (_SIMULATION && frameCount%3600==0 && frameCount != 0)){
      ajouterUneRacine( centre , random(TWO_PI/24)+ last_hour*(TWO_PI/24) , 3600 );
      last_hour = hour(); // on enregistre la dernière valeur des heures
    }
  
  
    Racine tempRacine; // objet temporaire; il sert de référence, afin de manipuler un objet stocké dans une liste plus facilement
    for(int i=0; i<list_racines.size(); i++){
      // on crée une référence à l'objet de la liste en cours
      tempRacine = ((Racine) list_racines.get(i));

      // si la Racine a un _STATUS égal à 0, il ne doit pas être considéré
      if(tempRacine._STATUS == 0) continue; 
      
      // on "update()" la Racine sélectionnée
      // Détail dans l'onglet "class_Racine"
      tempRacine.update();
    }
  }
}


//--
// Fonction groupant tous les effets et le remplissage de background à chaque nouvelle Racine créée
void couvreLeFond(){
  filter(BLUR, 1);
  tint( getDayColor() , 20);
  image(bg_image, 0, 0);
  noTint();
}

// --
int getDayColor(){
  // Ici nous définissons la couleur en surimpression (effectuée à chaque changement d'heure)
  // de manière arbitraire
  int[] midnight_color = {10, 10, 50};
  int[] midday_color   = {245, 255, 255};  
  
  float midnight_percent;
  float midday_percent;
  
  int heure   = hour();
  int minutes = minute();
  int temps = heure*60 + minutes;
  int douzeHeures = 12*60;
  
  if(temps < douzeHeures){
    midnight_percent = 1 - temps/douzeHeures;
    midday_percent   = temps/douzeHeures;
  }else{
    midday_percent   = 1 - (temps-12)/douzeHeures;
    midnight_percent = (temps-12)/douzeHeures;
  }
  
  int retour = color( midnight_color[0]*midnight_percent + midday_color[0]*midday_percent ,
                          midnight_color[1]*midnight_percent + midday_color[1]*midday_percent ,
                          midnight_color[2]*midnight_percent + midday_color[2]*midday_percent 
                          );
  return retour;
}


