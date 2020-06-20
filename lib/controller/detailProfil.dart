import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:takehair/controller/mainAppController.dart';
import 'package:takehair/controller/map.dart';
import 'package:takehair/controller/prestationController.dart';
import 'package:takehair/controller/profilPersonnel.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:takehair/model/user.dart';

import 'package:takehair/model/fireBaseHelper.dart';

class detailProfil extends StatefulWidget{

  String id;
  detailProfil({id}){
    this.id=id;
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return detailProfilState();
  }

}

class detailProfilState extends State<detailProfil>{
  int selectionIdex=0;
  user utilisateur;
  String id;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fireBaseHelper().myId().then((uid)
    {
      setState(() {
        id=uid;
        print(id);
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
    if(utilisateur==null)
    {
      return new Center(child: changementText("Chargement .....",Colors.black));
    }
    else
    {
      return new Scaffold(
        appBar: new AppBar(
          title: Text("Takehair"),
          backgroundColor: Colors.black,
        ),
        body: body(),
        bottomNavigationBar:BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.person),
                title: Text('Profil')

            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.info),
                title: Text('Information')
            )
          ],
          currentIndex: selectionIdex,
          selectedItemColor: Colors.blue,
          onTap: (int index){
            setState(() {
              selectionIdex=index;
              cheminment(selectionIdex);
            });


          },
        ),
      );
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


  Widget body(){
    return new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Image.asset('assets/images/logo.png',
              height: MediaQuery
                  .of(context)
                  .size
                  .height /5.5,
              width: MediaQuery
                  .of(context)
                  .size
                  .width / 5.5,

            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width:80.0,
                  height: 80.0,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage("assets/images/blank-profile-picture-973460_1280.png"),
                      )
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(5.0),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(utilisateur.login,style: new TextStyle(color: Colors.black,fontSize: 20.0),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(5.0),
                        ),
                        Text(utilisateur.prenom,style: new TextStyle(color: Colors.black,fontSize: 20.0)),
                        Padding(
                          padding: EdgeInsets.all(5.0),
                        ),
                        Text(utilisateur.nom,style: new TextStyle(color: Colors.black,fontSize: 20.0)),

                      ],

                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        new Icon(Icons.mail),
                        Text(utilisateur.mail,style: new TextStyle(color: Colors.black,fontSize: 20.0)),
                      ],

                    ),


                  ],

                ),



              ],

            ),
            Container(
              width: MediaQuery.of(context).size.width/2,
              child: TextField(
                onChanged: (String)
                {
                  setState(() {
                    utilisateur.login=String;
                  });
                },
                decoration: new InputDecoration(hintText: "modification pseudo",
                    border: OutlineInputBorder()
                ),

              ),
            ),





            changementBouton('ok', versMap),
            FlatButton(
              onPressed:_savesChanges,
              textColor: Colors.red,
              child: Text("Enregistrer modifcation"),
            )

          ],

        )
    );
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

  void _savesChanges()
  {
    Map map= utilisateur.toMap();
    fireBaseHelper().addUsers(utilisateur.id, map);
    versMap();
  }
}