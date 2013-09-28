class easy_Date
{
  // variables
  int _year, _month, _day;

  // constructeur
  easy_Date(int years, int months, int days) {
    _year  = years;
    _month = months;
    _day   = days;
  }
  
  // écrit et transmet, sous forme de texte, la date de l'objet easy_Date
  String getDateString(){
    String retour = ((_day < 10)?"0"+_day:_day) + " / "+ ((_month < 10)?"0"+_month:_month) + " / "+ _year ;
    return retour;
  }
  
  // Compare deux objets easy_Date et détermine si l'objet exécutant cette fonction
  // se situe, dans le temps, avant l'objet easy_Date transmit en paramètre.
  boolean isBefore(easy_Date date) {
    if (_year  > date._year)    return false;
    if (_month > date._month)   return false;
    if (_day   > date._day)     return false;

    return true;
  };
}

