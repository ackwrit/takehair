import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:takehair/model/conversation.dart';
import 'package:takehair/model/prestation.dart';
import 'dart:async';

import 'package:takehair/model/user.dart';

class fireBaseHelper {
  //autenthification

  final auth=FirebaseAuth.instance;

  Future <FirebaseUser> handleSign(String mail,String password) async
  {
    final AuthResult userAuth = await auth.signInWithEmailAndPassword(email: mail, password: password);
    FirebaseUser user=userAuth.user;
    return user;
  }



  Future <FirebaseUser> handleCreate(String mail,String password,String prenom, String nom,String login,String typeUtilisateur) async
  {
    final AuthResult userAuth = await auth.createUserWithEmailAndPassword(email: mail, password: password);
    FirebaseUser user = userAuth.user;
    String uid=user.uid;
    Map map =
    {
      "uid":uid,
      "login":login,
      "prenom" :prenom,
      "mail":mail,
      "nom":nom,
      "utilisateur":typeUtilisateur

    };
    addUsers(uid, map);
    return user;


  }
deleteUser(String uid)
{
  base_user.child(uid).remove();

}





  Future <FirebaseUser> handleCreatePrestation(String nomPrestation, String prixPrestation,String typePrestation) async
  {

    FirebaseUser user = await auth.currentUser();
    String uid =user.uid;
    Map map =
        {
          "uid":uid,
          "nom":nomPrestation,
          "prix":prixPrestation,
          "typePrestation":typePrestation

        };
    addPrestation(uid, map);
    return user;
  }

  Future<String> myId() async{
    FirebaseUser user = await auth.currentUser();
    return user.uid;


}


Future<bool>handleOut() async{
    await auth.signOut();
    return true;

}












  //Database

static final base=FirebaseDatabase.instance.reference();
  final base_user=base.child("users");
  final base_prestation = base.child("prestation");
  final base_message = base.child('messages');
  final base_conversation =base.child('conversation');
  final base_promotion = base.child('promotion');




  addUsers(String uid,Map map)
  {
    base_user.child(uid).set(map);
  }


  addPrestation(String uid,Map map)
  {
    base_prestation.child(uid).set(map);
  }


  deletePrestation(String uid){
    base_prestation.child(uid).remove();
  }



 sendPromotion(DateTime debut, DateTime fin,String code, String pourcentage)
 {
   String dateDebut = debut.microsecondsSinceEpoch.toString();
   String datefin = fin.microsecondsSinceEpoch.toString();
   String uid = dateDebut+datefin+code;
   Map map ={
     'debut':dateDebut,
     'fin':datefin,
     'code':code,
     'pourcentage':pourcentage,
     'uid':uid
   };
   base_promotion.child(uid).set(map);



 }
  sendMessage(String texte, user utilisateur, user moi){
    String date =new DateTime.now().millisecondsSinceEpoch.toString();
    Map map = {
      'from' : moi.id,
      'to': utilisateur.id,
      'texte':texte,
      'dateString': date


    };


    base_message.child(getMessageRef(moi.id, utilisateur.id)).child(date).set(map);
    base_conversation.child(moi.id).child(utilisateur.id).set(getConversation(moi.id, utilisateur, texte, date));
    base_conversation.child(utilisateur.id).child(moi.id).set(getConversation(utilisateur.id, moi, texte, date));

  }
  Map getConversation(String sender, user receiver, String texte, String dateString){
    Map map = receiver.toMap();
    map['monId']=sender;
    map['last_message']=texte;
    map['dateString']= dateString ;
    return map;

  }

  getMessageRef(String from, String to )
  {
    String resultat="";
    List<String> liste =[from,to];
    liste.sort((a,b)=>a.compareTo(b));
    for(var x in liste)
      {
        resultat += x +"+";
      }
    return resultat;
  }


  Future<user> getUser(String uid) async
  {
    DataSnapshot snapshot = await base_user.child(uid).once();
    return user(snapshot);
  }


  Future<prestation> getPrestation(String uid) async
  {
    DataSnapshot snapshot = await base_prestation.child(uid).once();
    return prestation(snapshot);
  }


}

