import 'package:flutter/material.dart';
import 'package:takehair/controller/detailProfil.dart';
import 'package:takehair/controller/mainAppController.dart';
import 'package:takehair/controller/panelController.dart';
import 'package:takehair/controller/registerController.dart';
import 'package:takehair/fonction/changementText.dart';
import 'package:takehair/fonction/champsfield.dart';
import 'package:takehair/fonction/bouton.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:takehair/model/fireBaseHelper.dart';
import 'package:firebase_auth/firebase_auth.dart';

class loginController extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return loginControllerState();
  }

}

class loginControllerState extends State <loginController>
{
  bool _log=true;
  bool typeUser=false;

  champsfield login=new champsfield ('login',false);
  champsfield password=new champsfield('password', true);
  changementText nouveauCompte= new changementText('Creer un compte',Colors.black);
  changementText particulier=new changementText('Particulier', Colors.black);
  changementText professionnel=new changementText('professionnel', Colors.orange);
  bouton connexion=new bouton('Connexion',Colors.black,Colors.white);
  bouton creationCompte=new bouton('Créer un compte', Colors.black,Colors.white);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text('Takehair',style: new TextStyle(color: Colors.white),),
          backgroundColor: setColor(),
        ),
        body: SingleChildScrollView(
          child:Container(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Image.asset('assets/images/logo.png',
                  height: MediaQuery.of(context).size.height/4,
                  width: MediaQuery.of(context).size.width/4,

                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    particulier.plateforme(),
                    changementSwitch(),
                    professionnel.plateforme(),

                  ],

                ),
                Padding(
                  padding: EdgeInsets.all(MediaQuery.of(context).size.height/40),
                ),


                Container(
                  child: login.creation_champsfield('Mail'),
                  width: MediaQuery.of(context).size.width/1.5,
                ),
                Padding(
                  padding: EdgeInsets.all(MediaQuery.of(context).size.height/40),
                ),
                Container(
                  width: MediaQuery.of(context).size.width/1.5,
                  child:password.creation_champsfield('Password '),
                ),

                Padding(
                  padding: EdgeInsets.all(MediaQuery.of(context).size.height/40),
                ),
                connexion.pressionBouton('Connexion',champsComplet,setColor()),




                Padding(
                  padding: EdgeInsets.all(MediaQuery.of(context).size.height/40),
                ),

                creationCompte.pressionBouton('Créer un compte',versregister,setColor()),






              ],
            ),

          ) ,
        ) // This trailing comma makes auto-formatting nicer for build methods.
    );
  }



  //FONCTION

  void versChoixprincipal()
  {
    Navigator.push(context, new MaterialPageRoute(builder:
        (BuildContext context){
      return panelController();
    }
    ));

  }


  void versregister()
  {
    Navigator.push(context, new MaterialPageRoute(builder:
        (BuildContext context){
      return new registerController(typeUser: typeUser,);
    }
    ));

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
              title: new Text('Champs manquants'),
              actions: <Widget>[
                new CupertinoButton(
                    child: new Text('OK',style:new TextStyle(color: Colors.orange)),
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
              title: new Text('Champs manquants'),
              children: <Widget>[
                new RaisedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: new Text('OK', style: new TextStyle(color: Colors.orange)),)


              ],

            );
          }
      );
    }
  }
///Changement de profil entre professionelle et particulier
  Widget changementSwitch()
  {
    if(Platform.isIOS)
    {
      return new CupertinoSwitch
        (
          value: typeUser,
          activeColor: setColor(),
          onChanged: (bool b)
          {
            setState(() {
              typeUser=b;
            });
          }
      );
    }
    else
    {
      return new Switch(
          value: typeUser,
          activeTrackColor: setColor(),
          inactiveTrackColor: setColor(),
          activeColor: setColor(),

          onChanged: (bool b)
          {
            setState(() {
              typeUser=b;
            });
          });

    }
  }
////



  Color setColor()
  {
    if (typeUser)
    {
      return Colors.orangeAccent;
    }
    else
    {
      return Colors.grey;
    }
  }
///alerte message
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
                    child: new Text('OK',style:new TextStyle(color: Colors.black)),
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
                  child: new Text('OK', style: new TextStyle(color: Colors.black)),)


              ],

            );
          }
      );
    }

  }

/////////





  void champsComplet()
  {


    if((login.text!=null)&& (password.text!=null))
    {
     fireBaseHelper().handleSign(login.text, password.text).then((FirebaseUser user){
       versChoixprincipal();
     }).catchError((error)=>{

     alerte('Erreur sur le mot de passe ou le mail')
       

       

     });
    
   
    }
    else
    {
      message();
    }

  }


}