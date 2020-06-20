import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:takehair/controller/listingPrestationDetailController.dart';
import 'package:takehair/controller/prestationRegisterController.dart';
import 'package:takehair/model/fireBaseHelper.dart';
import 'package:takehair/model/prestation.dart';


class listingPrestationController extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return homeListingPresta();
  }

}

class homeListingPresta extends State<listingPrestationController>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Padding(padding: EdgeInsets.all(5)),
          FlatButton(
            child: Text('Création prestation'),
            onPressed: (){
              Navigator.push(context, new MaterialPageRoute(
                  builder: (BuildContext context){
                    return prestationRegisterController();
                  }
              ));
              
            },
          ),
          Container(
            height: MediaQuery.of(context).size.height/1.5,
            child: FirebaseAnimatedList(

                shrinkWrap: true,
                scrollDirection: Axis.vertical,

                query: fireBaseHelper().base_prestation,
                itemBuilder: (BuildContext context,DataSnapshot snapshot,Animation <double> animation,int index)
                {
                  prestation prestationOffre = prestation(snapshot);
                  return new Card(
                    child: ListTile(
                      leading: Text(prestationOffre.nom),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[

                          Text("Prix : ${prestationOffre.prix} €"),
                          IconButton(icon: Icon(Icons.dehaze), onPressed: (){
                            Navigator.push(context, new MaterialPageRoute(
                                builder: (BuildContext context){
                                  return listingPrestationDetailController(prestationOffre);
                                }
                            ));
                          }
                          )


                        ],
                      ),
                      trailing: IconButton(icon: Icon(Icons.delete), onPressed: (){
                        fireBaseHelper().deletePrestation(prestationOffre.id);

                      }),
                    ),

                  );
                }
            ),

          ),



        ],

      )

    );


  }

}