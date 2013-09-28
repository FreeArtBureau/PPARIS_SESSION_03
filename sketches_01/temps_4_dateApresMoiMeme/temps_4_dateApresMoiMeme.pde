/**
Dans cet exemple, nous allons générer la date actuelle, telle que l'an 0 ne correspond plus à la naissance du Petit-Bébé-Jésus,
mais à votre propre naissance !

Exemple: je suis né le 30 06 1984; nous sommes donc le 2 avril de l'an 28 (selon moi-même)
        (dans le cas où la date du jour serait le 1er octobre 2012)

Cet exemple fait appel à un script PHP (nécessaire au calcul de date).
Le détail de la requête est visible dans l'onglet "Outils" à la fonction "easy_Date getRelativeDateFrom()"

CLASSE :
"easy_Date" est une classe personnalisée stockant des informations de date (année, mois, jour)
Le détail de la classe est visible dans l'onglet "easy_Date"
**/

// définition des objets easy_Date : aujourd'hui, ma date de naissance, et la date à trouver
easy_Date now, moi, relative; 

void setup(){
  // Crée une fenêtre de 600 par 600
  size(600,600);
  
  now = new easy_Date( year(), month(), day()); // la date d'aujourd'hui
  moi = new easy_Date( 1984,    06 ,    30 );  // ma date de naissance
  
  // crée un objet easy_Date affichant la date exacte relativement à votre date de naissance
  relative = getRelativeDateFrom( now, moi ); 
}


void draw(){
  // colorie le fond en blanc
  background(255);
  
  
  fill(0);
  textAlign(RIGHT);
  textSize(20);
  text( "Aujourd'hui" , width/2 -10, height/2 - 45);
  fill(100);
  text( "Ma date de naissance" , width/2 -10, height/2 - 15);
  fill(0);
  text( "Date selon moi-même" , width/2 -10, height/2 + 15);
  
  textAlign(LEFT);
  textSize(30);
  text( now.getDateString() , width/2, height/2 - 45);
  fill(100);
  text( moi.getDateString() , width/2, height/2 - 15);
  fill(0);
  text( relative.getDateString() , width/2, height/2 + 15);
}
