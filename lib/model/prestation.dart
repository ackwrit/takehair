import 'package:firebase_database/firebase_database.dart';

class prestation
{
  String id;
  String nom;
  String prix;
  String typePrestation;

  prestation(DataSnapshot snapshot){
    id=snapshot.key;
    Map map = snapshot.value;
    prix = map["prix"];
    nom = map["nom"];
    typePrestation = map["typePrestation"];


  }

  Map toMap(){
    return {
      "prix":prix,
      "nom":nom,
      "typePrestation":typePrestation,
      "uid":id,


    };
  }

}