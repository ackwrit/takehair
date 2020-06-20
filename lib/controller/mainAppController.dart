import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:takehair/fonction/bouton.dart';
import 'package:takehair/fonction/changementText.dart';
import 'package:takehair/model/fireBaseHelper.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:takehair/controller/prestationController.dart';
import 'package:takehair/model/user.dart';



class mainAppController extends StatefulWidget{
  DateTime moment;
  user profession;


  mainAppController(moment,profession)
  {
    this.moment=moment;
    this.profession=profession;
  }
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return mainAppState();
  }

}

class mainAppState extends State<mainAppController> {
  bouton action = new bouton('ok', Colors.black, Colors.white);
  changementText titre = new changementText(
      'Choix de la prestation', Colors.black);

  @override
  Widget build(BuildContext context) {
    return new FutureBuilder(
      future: fireBaseHelper().auth.currentUser(),
      builder: (BuildContext context, AsyncSnapshot <FirebaseUser> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return new Scaffold(
              appBar: new AppBar(
                title: new Text("Takehair",style: new TextStyle(color: Colors.white),),
                backgroundColor: Colors.blue[100],
              ),
              backgroundColor: Colors.grey[50],
              body: SingleChildScrollView(
                child: new Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Image.asset('assets/images/logo.png',
                        height: MediaQuery
                            .of(context)
                            .size
                            .height / 3,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width / 3,

                      ),
                      titre.taille(20),
                      Padding(
                          padding: EdgeInsets.all(20)),
                      //image cliquable en cercle
                      Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              FlatButton(
                                onPressed: () =>
                                {
                                  versPrestation(1)
                                },
                                child: new Card(
                                  color: Colors.grey[50],
                                  child: new Image.asset(
                                    "assets/images/scissors-23413_640.png",


                                    height: 150,
                                    width: 150,
                                  ),

                                ),
                              ),
                              FlatButton(
                                onPressed: ()=>{
                                  versPrestation(2)
                                },
                                child: new Card(
                                  color: Colors.grey[50],
                                  child: new Image.asset(
                                    "assets/images/vector-3071686_640.png",
                                    height: 150,
                                    width: 150,
                                  ),

                                ),

                              ),





                              ////


                            ],

                          ),

                          ///deuxième ligne de logo

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              FlatButton(
                                onPressed: ()=>{
                                  versPrestation(3)
                                },
                                child: new Card(
                                  color: Colors.grey[50],
                                  child: new Image.asset(
                                    "assets/images/hair-3369860_1280.png",
                                    height: 150,
                                    width: 150,
                                  ),

                                ),

                              ),

                              FlatButton(
                                onPressed:()=>{
                                  versPrestation(4)

                                },
                                child: new Card(
                                  color: Colors.grey[50],
                                  child: new Image.asset(
                                    "assets/images/silhouette-3605401.png",
                                    height: 150,
                                    width: 150,
                                  ),

                                ),


                              ),





                              ////


                            ],

                          ),


                        ],
                      ),


                    ],

                  ),
                )
              )



          );
        }

        else {
          //retourne un widget chargement
          return new Scaffold(
            appBar: new AppBar(
              title: new Text("Takehair"),
            ),
            body: new Center(
              child: Text("Chargement ..."),
            ),

          );
        }
      },
    );
  }

  void versChoixprincipal() {
    Navigator.push(context, new MaterialPageRoute(builder:
        (BuildContext context) {
      return null;
    }
    ));
  }

  Widget titrePrestation(String image, String texte) {
    changementText prestation = new changementText(texte, Colors.black);
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Card(
          shape: CircleBorder(),
          elevation: 30.0,
          child: new Image.asset(image,
            height: MediaQuery
                .of(context)
                .size
                .height / 7,
            width: MediaQuery
                .of(context)
                .size
                .width / 7,


          ),

        ),
        prestation.plateforme()

      ],

    );
  }


  void versPrestation(int index) {
    Navigator.push(context, new MaterialPageRoute(builder:
        (BuildContext context) {
      return prestationController(index: index,moment: widget.moment,profession:widget.profession);
    }
    ));
  }
}