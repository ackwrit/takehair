import 'package:firebase_database/firebase_database.dart';

class promotion
{
  String uid;
  String code;
  String pourcentage;
  String debut;
  String fin;


  promotion(DataSnapshot snapshot)
  {
    uid = snapshot.key;
    Map map = snapshot.value;
    code= map['code'];
    pourcentage = map['pourcentage'];
    debut= map['debut'];
    fin = map['fin'];
  }


  Map toMap()
  {
    Map map;
    return map ={
      "code":code,
      "uid":uid,
      "pourcentage":pourcentage,
      "debut":debut,
      "fin":fin

    };
  }
}