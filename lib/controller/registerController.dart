import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:takehair/controller/detailProfil.dart';
import 'package:takehair/controller/panelController.dart';
import 'package:takehair/fonction/champsfield.dart';
import 'package:takehair/fonction/changementText.dart';
import 'package:takehair/fonction/bouton.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'dart:async';
import 'package:takehair/model/fireBaseHelper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:takehair/controller/mainAppController.dart';



class registerController extends StatefulWidget{



  bool typeUser=false;
  registerController({Key key ,bool typeUser}) :super (key:key)
  {
    this.typeUser=typeUser;
  }



  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return registerControllerHome();
  }

}

class registerControllerHome extends State<registerController>
{
  //Declaration variable

  void error;

  //typeUser=new registerController();
  champsfield pseudo = new champsfield('login', false);
  champsfield mail = new champsfield('Email',false);
  champsfield prenom = new champsfield('Prénom', false);
  champsfield nom = new champsfield('nom', false);
  champsfield password1= new champsfield('Entrer le mot de passe', true);
  champsfield password2 =new champsfield('Entrer à nouveau le mot de passe', true);
  bouton enregistrer= new bouton(null, Colors.black,Colors.white);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: Text('Takehair',style: TextStyle(color: Colors.white),),
        backgroundColor: setColor(),
      ),
      body: body(),
    );
  }

void verification()
{
  String typeUtilisateur="professionnel";
  if(password1.text==password2.text)
    {
     if(widget.typeUser==false)
       {
         typeUtilisateur='particulier';
       }
      fireBaseHelper().handleCreate(mail.text, password1.text, prenom.text, nom.text,pseudo.text,typeUtilisateur).then((FirebaseUser user) {
        print("Enregistrement d'un utilisateur");

        Navigator.push(context, new MaterialPageRoute(
            builder: (BuildContext context)
            {
              return panelController();
            }
        ));
        alerte("Votre compte est enregistré");
      }).catchError((error)=>{
        alerte("l'adresse mail ou login sont déjà utlisées")
      });



    }
  else
    {
      alerte("Mot de passe différent");
    }
}

/////mesage alerte
  Future <Null> alerte(String erreur) async
  {
    if(Platform.isIOS)
    {
      showDialog(context: context,
          barrierDismissible: true,
          builder:(BuildContext builContext)
          {
            return new CupertinoAlertDialog(
              title: new Text(erreur),
              actions: <Widget>[
                new CupertinoButton(
                    child: new Text('OK',style:new TextStyle(color:setColor())),
                    onPressed: (){Navigator.pop(context);}
                )
              ],
            );
          }
      );

    }
    else {
      showDialog(context: context,
          barrierDismissible: true,
          builder: (BuildContext buildContext) {
            return new SimpleDialog(
              title: new Text(erreur),
              children: <Widget>[
                new RaisedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: new Text('OK', style: new TextStyle(color:setColor())),)


              ],

            );
          }
      );
    }
  }














  ///////



  Color setColor()
  {
    if (widget.typeUser)
    {
      return Colors.orangeAccent;
    }
    else
    {
      return Colors.grey;
    }
  }



  Future <Null> message() async
  {
    if(Platform.isIOS)
    {
      showDialog(context: context,
          barrierDismissible: true,
          builder:(BuildContext builContext)
          {

            return new CupertinoAlertDialog(
              title: new Text('Champs manquants ou mot de passe incorect'),
              actions: <Widget>[
                new CupertinoButton(
                    child: new Text('OK',style:new TextStyle(color:setColor())),
                    onPressed: (){Navigator.pop(context);}
                )
              ],
            );
          }
      );

    }
    else {
      showDialog(context: context,
          barrierDismissible: true,
          builder: (BuildContext buildContext) {
            return new SimpleDialog(
              title: new Text('Champs manquants ou mot de passe incorect'),
              children: <Widget>[
                new RaisedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: new Text('OK', style: new TextStyle(color:setColor())),)


              ],

            );
          }
      );
    }
  }




 Widget body()
 {
   return new SingleChildScrollView(
     child:Center(


       child: new Column(
         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
         children: <Widget>[

           pseudo.creation_champsfield('Entrer le Login'),
           mail.creation_champsfield('Entrer le mail'),
           prenom.creation_champsfield('Entrer votre prenom'),
           nom.creation_champsfield('Entrer votre nom'),
           password1.creation_champsfield('Entrer le mot de passe'),
           password2.creation_champsfield('Entrer à nouveau le mot de passe'),

           enregistrer.pressionBouton('Enregistrer', verification,setColor())





         ],
       ),
     ) ,
   );
 }
}