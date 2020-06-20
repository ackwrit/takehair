import 'package:firebase_database/firebase_database.dart';

class user
{
  String id;
  String prenom;
  String nom;
  String login;
  String typeUtilisateur;
  String imageUrl;
  String mail;

  user(DataSnapshot snapshot){
    id=snapshot.key;
    Map map = snapshot.value;
    prenom = map["prenom"];
    nom = map["nom"];
    login = map["login"];
    typeUtilisateur = map["utilisateur"];
    imageUrl = map["imageUrl"];
    mail = map["mail"];


  }

  Map toMap(){
    return {
      "prenom":prenom,
      "nom":nom,
      "login":login,
      "utilisateur":typeUtilisateur,
      "nom":nom,
      "imageUrl":imageUrl,
      "uid":id,
      "mail":mail


    };
  }

}