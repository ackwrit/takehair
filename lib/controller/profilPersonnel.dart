import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:takehair/controller/detailProfil.dart';
import 'dart:io';

import 'package:takehair/controller/map.dart';
import 'package:takehair/model/contactProfessionnel.dart';
import 'package:takehair/model/fireBaseHelper.dart';
import 'package:takehair/model/prestation.dart';
import 'package:takehair/model/user.dart';

class profilPersonnel extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return profilPersonnelState();
  }

}

class profilPersonnelState extends State<profilPersonnel>
{
  int selectionIdex=1;
  String typeUtilisateur="administrateur";
  user utilisateur;
  String id;
  String _nomPrestation;
  String _prixPrestation;
  String _typePrestation;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fireBaseHelper().myId().then((uid)
    {
      setState(() {
        id=uid;
      });
      fireBaseHelper().getUser(id).then((user)
      {
        setState(() {
          utilisateur=user;
        });

      });

    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if(typeUtilisateur=='administrateur')
      {
        return _BodyAdmin();


      }











  }


  ///FONCTION/////////////////
///
///
  void cheminment(int index)
  {
    switch(index)
    {
      case 0:versDetailprofil();
      break;
      case 1:versprofil();
      break;
      default:break;
    }
  }
  Widget _BodyAdmin()
  {

    return new FirebaseAnimatedList(
      query: fireBaseHelper().base_user,
      itemBuilder: (BuildContext context,DataSnapshot snapshot,Animation<double> animation,int index){
        user prestationList = user(snapshot);
        if(prestationList.id==utilisateur.id)
          {
            return Container();
          }
        else
          {
            return new Card(
              child: ListTile(
                trailing:IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: ()
                    {
                      fireBaseHelper().deleteUser(prestationList.id);
                    }
                ),
                title: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('${prestationList.nom}'),
                    IconButton(
                        icon: Icon(Icons.info_outline),
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(
                              builder: (BuildContext context){
                                return contactProfessionnel(prestationList);
                              }
                          ));
                        }
                    ),
                  ],

                ),
              ),
            );
          }




      },



    );
  }



  _AjouterPrestation()
  {
    showDialog(
        context: context,
      barrierDismissible: true,
      builder: (BuildContext context){
          return new Container(
            padding: EdgeInsets.all(10),
            height: MediaQuery.of(context).size.height/2,
            color: Colors.transparent,
            child: new Scaffold(
              appBar: new AppBar(
               backgroundColor: Colors.transparent,

              ),
              backgroundColor: Colors.transparent,
              body: new Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      hintText: 'Entrer le nom de la prestation',
                      filled: true,
                      fillColor: Colors.white
                    ),

                  ),
                  new TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        hintText: 'Entrer le prix de la prestation',
                        filled: true,
                        fillColor: Colors.white
                    ),

                  ),
                  RaisedButton(
                    child: Text('Enregistrer'),
                    onPressed: (){
                      fireBaseHelper().handleCreatePrestation(_nomPrestation, _prixPrestation, _typePrestation);
                      Navigator.pop(context);

                    },
                  )

                ],
              ),
            ),
          );
      }
    );
  }



  void versDetailprofil(){
    Navigator.push(context, new MaterialPageRoute
      (
        builder: (BuildContext context)
            {
              return detailProfil();
            }
    ));
}


  void versprofil(){
    Navigator.push(context, new MaterialPageRoute
      (
        builder: (BuildContext context)
        {
          return profilPersonnel();
        }
    ));
  }






  Widget body(){
    return new SingleChildScrollView(
      child: new Container(
        height: MediaQuery.of(context).size.height/1.3,
        width: MediaQuery.of(context).size.width,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Image.asset('assets/images/logo.png',
              width: MediaQuery.of(context).size.width/2,

            ),
            Padding(
              padding: EdgeInsets.all(40.0),
            ),


            changementText('Reservation', Colors.black),
            changementText('Historique', Colors.black),
            FlatButton(
                onPressed: null,//vers page avantage
                child: changementText('Avantage/Fidélité', Colors.black)),
            changementText('Contact', Colors.black),
            changementText('FAQ', Colors.black),
            changementBouton('ok', versMap)


          ],

        ),
      ),

    );;
  }
 Widget changementText(String data,Color couleur)
  {
    if(Platform.isIOS)
    {
      return new DefaultTextStyle(
          style: new TextStyle(color:couleur,fontSize: 15.0),
          child: new Text(data));

    }
    else
    {
     return new Text(data,style: new TextStyle(color: couleur,fontSize: 15.0));
    }
  }





  Widget changementBouton(String texte,VoidCallback direction)
  {
    if(Platform.isIOS)
    {
      return new CupertinoButton(
        onPressed: direction,
        color: Colors.black,//changement de couleur
        child: changementText(texte,Colors.white),
      );

    }
    else
    {
      return new RaisedButton(
          onPressed:direction,
          color: Colors.black,//changement de couleur
          shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
          child: changementText(texte,Colors.white)
      );
    }
  }


  void versMap()
  {
    Navigator.push(context, new MaterialPageRoute(
        builder: (BuildContext context)
            {
              return map();
            }
    )
    );
  }

/// ////////////////////////////

}