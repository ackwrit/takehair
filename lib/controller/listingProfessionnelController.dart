import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:takehair/model/contactProfessionnel.dart';
import 'package:takehair/model/fireBaseHelper.dart';
import 'dart:io';

import 'package:takehair/model/user.dart';


class listingProfessionnelController extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return homeListing();
  }

}

class homeListing extends State<listingProfessionnelController>{
  user _professionnel;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FirebaseAnimatedList(
        query: fireBaseHelper().base_user,
        itemBuilder: (BuildContext context,DataSnapshot snapshot,Animation <double> animation,int index){
          user _professionnel = new user(snapshot);
          if(_professionnel.typeUtilisateur=='professionnel')
            {
              return new Card(
                child: ListTile(
                  trailing: IconButton(icon:Icon(Icons.delete),
                      onPressed:(){
                    fireBaseHelper().deleteUser(_professionnel.id);
                        print("effacer");

                      },
                  //suppression id
                  ),

                  title:new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Text(_professionnel.mail),
                      IconButton(icon: Icon(Icons.dehaze),onPressed: ()
                      {
                        _UpdateProfessionnel(_professionnel);


                      },),
                    ],


                  ),
                ),

              );
            }
          else
            {
              return new Container();
            }



        }
    );
  }


  _UpdateProfessionnel(user professionnel)
  {
    Navigator.push(context, new MaterialPageRoute(
        builder: (BuildContext context)
            {
              return contactProfessionnel(professionnel);
            }
    ));
  }

}