import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:takehair/controller/choixProfessionnelController.dart';
import 'package:takehair/model/fireBaseHelper.dart';
import 'package:takehair/model/user.dart';

class searchController extends StatelessWidget{
  String message;
  search(String message)
  {
    this.message=message;
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Homesearch();
  }

}

class Homesearch extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Homesearch();
  }

}


class Post {
  final String title;
  final String description;

  Post(this.title, this.description);
}


  class _Homesearch extends State <Homesearch> {
    String search ='';
  @override
  Widget build(BuildContext context) {

    String recherche = 'Takehair';
    // TODO: implement build
    if (Platform.isIOS) {
      return body();
    }
  }





  Widget body() {
    return new Container(
      padding: EdgeInsets.all(10),
        width: MediaQuery
            .of(context)
            .size
            .width,
        height: MediaQuery.of(context).size.height,
        child:Column(
          children: [
            TextField(
              onChanged: (String text)
              {
                setState(() {
                  search =text;
                });


              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20)
                ),
                hintText: 'Recherche',
                icon: Icon(Icons.search)
              ),
            ),
            FirebaseAnimatedList(
                shrinkWrap: true,
                query: fireBaseHelper().base_user,
                itemBuilder: (BuildContext context,DataSnapshot snapshot,Animation<double>animation,int index){
                  user pro = user(snapshot);
                  if((search.toUpperCase() == pro.nom.toUpperCase().substring(0,3))||
                      (search.toUpperCase() == pro.prenom.toUpperCase().substring(0,3))||
                      (search.toUpperCase() == pro.login.toUpperCase().substring(0,3))||
                      (search.toUpperCase()==pro.nom.toUpperCase()
                          ||(search.toUpperCase()==pro.prenom.toUpperCase())
                          ||(search.toUpperCase()==pro.login.toUpperCase())
                      )
                  )
                    {
                      return ListTile(

                        title: Row(
                          children: [
                            Text(pro.login),
                            Padding(padding: EdgeInsets.all(10)),
                            Text(pro.prenom),
                            Padding(padding: EdgeInsets.all(10)),
                            Text(pro.nom)
                          ],
                        ),
                        trailing: IconButton(
                            icon: Icon(Icons.arrow_forward_ios),
                            onPressed: ()
                            {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (BuildContext context)
                                      {
                                        return choixProfessionnelController(pro.id, DateTime.now(), pro);
                                      }
                              ));
                            }
                        ),
                      );

                    }
                  else
                    {
                      return Container();
                    }



                }
            )

          ],
        ),








    );
  }
}