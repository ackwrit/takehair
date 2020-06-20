import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';

import 'package:takehair/controller/choixProfessionnelController.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:takehair/model/fireBaseHelper.dart';
import 'package:takehair/model/user.dart';







class multipleProfessionelController extends StatefulWidget
{
  String titre;
  int heure;
  var jour;
  var mois;
  DateTime rendezvous;

  multipleProfessionelController({String message,int heure,var jour,var mois,DateTime rendezvous})
  {
    this.titre=message;
    this.heure=heure;
    this.jour=jour;
    this.mois=mois;
    this.rendezvous=rendezvous;
  }


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Homedate();
  }

}

class _Homedate extends State <multipleProfessionelController> {


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if(Platform.isIOS)
    {
      return new CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text('Takehair',style: TextStyle(color: Colors.white)),
          backgroundColor:Colors.blue[100] ,
        ),
        child: body_list(),

      );
    }
    else
    {
      return new Scaffold(
        appBar: AppBar(
          title: Text('Takehair'),
          backgroundColor: Colors.black,
        ),
        body: body_list(),
      );
    }
  }


  Widget body_list(){
    return new FirebaseAnimatedList(
        query: fireBaseHelper().base_user,
        itemBuilder:(BuildContext context,DataSnapshot snapshot, Animation<double> animation, int index)
      {
        user newuser = new user(snapshot);
        if((newuser.typeUtilisateur=="particulier")){
          return new Container();


        }
        else
          {
            return new Card(
              child: ListTile(
                leading:Container(
                  width:48.0,
                  height: 48.0,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage("assets/images/blank-profile-picture-973460_1280.png"),
                      )
                  ),
                ),

                trailing: IconButton(icon: new Icon(Icons.arrow_forward_ios), onPressed: ()
                {
                  Navigator.push(context, new MaterialPageRoute(
                      builder: (context)
                          {
                            return choixProfessionnelController(newuser.id,widget.rendezvous, newuser);
                          }
                  ));

                }
                ),

                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.star_border,color: Colors.yellow,),
                    Icon(Icons.star_border,color: Colors.yellow,),
                    Icon(Icons.star_border,color: Colors.yellow,),
                    Icon(Icons.star_border,color: Colors.yellow,),
                    Icon(Icons.star_border,color: Colors.yellow,),

                  ],
                ),

                title: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(" ${newuser.login} "),
                    Text(" ${newuser.prenom} "),
                    //
                  ],
                ),
              ),
            );
          }

      },

    );

}

  Widget body()
  {
    return new Center(
        child:new ListView.builder(
            itemCount: 7,
            itemBuilder: (BuildContext context,int i) {
              return new Container(
                  height: 135.0,
                  padding:EdgeInsets.all(10.0),
                  child: new Card(
                    elevation: 20.0,
                    child:InkWell(
                      onTap: ()
                      {



                      },
                      //Aller sur la page detail professionnel
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Container(
                                width:48.0,
                                height: 48.0,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: AssetImage("assets/images/blank-profile-picture-973460_1280.png"),
                                    )
                                ),
                              ),
                              new Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Icon(Icons.star_border,color: Colors.yellow,),
                                  Icon(Icons.star_border,color: Colors.yellow,),
                                  Icon(Icons.star_border,color: Colors.yellow,),
                                  Icon(Icons.star_border,color: Colors.yellow,),
                                  Icon(Icons.star_border,color: Colors.yellow,),

                                ],
                              ),



                              Text('nom',style: new TextStyle(color: Colors.black)),
                              Text('prenom',style: new TextStyle(color: Colors.black)),
                            ],
                          ),
                          new Text('Description'),

                        ],
                      ),

                    ),
                  )
              );
            }
        )

    );




  }



}