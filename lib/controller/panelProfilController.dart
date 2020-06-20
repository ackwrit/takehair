import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:takehair/controller/infoProfessionnelController.dart';
import 'package:takehair/controller/listingPrestationDetailController.dart';
import 'package:takehair/controller/listingProfessionnelController.dart';
import 'package:takehair/controller/loginController.dart';
import 'package:takehair/controller/panelController.dart';
import 'package:takehair/controller/prestationController.dart';
import 'package:takehair/controller/prestationRegisterController.dart';
import 'package:takehair/controller/professionnelSettingsController.dart';
import 'package:takehair/controller/profilPersonnel.dart';
import 'package:takehair/controller/promotionController.dart';
import 'package:takehair/listingPrestationController.dart';
import 'package:takehair/model/contactProfessionnel.dart';
import 'package:takehair/model/fireBaseHelper.dart';
import 'package:takehair/model/user.dart';

class panelProfilController extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return homePanelProfil();
  }

}

class homePanelProfil extends State<panelProfilController>{
  String id;
  user utilisateur;
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
    if(utilisateur.typeUtilisateur=='admin')
      {
        if(Theme.of(context).platform==TargetPlatform.iOS)
        {
          return new CupertinoTabScaffold(
              tabBar: new CupertinoTabBar(
                  backgroundColor: Colors.blue[100],

                  activeColor: Colors.black,
                  inactiveColor: Colors.white,
                  items:[
                    new BottomNavigationBarItem(icon: new Icon(Icons.format_list_bulleted,),title: new Text("Liste",style:TextStyle(fontSize: 18),)),
                    new BottomNavigationBarItem(icon: new Icon(Icons.add_circle),title: new Text('prestation',style: TextStyle(fontSize: 18),)),

                    new BottomNavigationBarItem(icon: new Icon(Icons.event),title: new Text('promotion',style: TextStyle(fontSize: 18),)),






                  ]),
              tabBuilder: (BuildContext context,int index){
                Widget controllerSelected= controllers()[index];
                return new Scaffold(
                  appBar: new AppBar(
                    leading: IconButton(
                        icon: (Icon(Icons.clear)),
                        onPressed: (){
                          fireBaseHelper().handleOut();
                          Navigator.push(context, MaterialPageRoute(
                              builder: (BuildContext context)
                              {
                                return loginController();
                              }
                          ));


                        }
                    ),
                    actions: [
                      IconButton(icon:Icon(Icons.map), onPressed:()
                      {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (BuildContext context)
                            {
                              return panelController();
                            }
                        ));

                      }
                      )
                    ],

                    title: Text('Takehair'),
                    backgroundColor: Colors.blue[100],),
                  body: controllerSelected,


                );
              }
          );
        }
        else
        {
          return new DefaultTabController(
            length: 5,
            child: new Scaffold(
              appBar: new AppBar(
                backgroundColor: Colors.blue[100],
                title: Text('Takehair'),
                centerTitle: true,
                actions: <Widget>[
                  new IconButton(icon:Icon(Icons.account_circle,size: 32.0,color: Colors.white,),
                      onPressed:null
                  ),

                ],
                bottom: new TabBar(
                    tabs: [
                      new Tab(icon: new Icon(Icons.format_list_bulleted,),
                        text: "Liste",
                      ),
                      new Tab(icon: new Icon(Icons.add_circle),
                          text: 'prestation'
                      ),
                      new Tab(icon: new Icon(Icons.event),
                          text: 'promotion'),





                    ]),
              ),
              body: new TabBarView(
                children: controllers(),
              ),
            ),

          );
        }
      }
    if(utilisateur.typeUtilisateur=='professionnel')
      {
        if(Theme.of(context).platform==TargetPlatform.iOS)
        {
          return new CupertinoTabScaffold(
              tabBar: new CupertinoTabBar(
                  backgroundColor: Colors.blue[100],

                  activeColor: Colors.black,
                  inactiveColor: Colors.white,
                  items:[
                    new BottomNavigationBarItem(icon: new Icon(Icons.info,),title: new Text("Information",style:TextStyle(fontSize: 18),)),
                    new BottomNavigationBarItem(icon: new Icon(Icons.settings),title: new Text('Paramètre',style: TextStyle(fontSize: 18),)),

                    new BottomNavigationBarItem(icon: new Icon(Icons.event),title: new Text('Rendez-vous',style: TextStyle(fontSize: 18),)),






                  ]),
              tabBuilder: (BuildContext context,int index){
                Widget controllerSelected= controllersProfessionels()[index];
                return new Scaffold(
                  appBar: new AppBar(
                    leading: IconButton(
                        icon: (Icon(Icons.clear)),
                        onPressed: (){
                          fireBaseHelper().handleOut();
                          Navigator.push(context, MaterialPageRoute(
                              builder: (BuildContext context)
                              {
                                return loginController();
                              }
                          ));


                        }
                    ),
                    actions: [
                      IconButton(icon:Icon(Icons.map), onPressed:()
                      {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (BuildContext context)
                            {
                              return panelController();
                            }
                        ));

                      }
                      )
                    ],

                    title: Text('Takehair'),
                    backgroundColor: Colors.blue[100],),
                  body: controllerSelected,


                );
              }
          );
        }
        else
        {
          return new DefaultTabController(
            length: 5,
            child: new Scaffold(
              appBar: new AppBar(
                backgroundColor: Colors.blue[100],
                title: Text('Takehair'),
                centerTitle: true,
                actions: <Widget>[
                  new IconButton(icon:Icon(Icons.account_circle,size: 32.0,color: Colors.white,),
                      onPressed:null
                  ),

                ],
                bottom: new TabBar(
                    tabs: [
                      new Tab(icon: new Icon(Icons.format_list_bulleted,),
                        text: "Liste",
                      ),
                      new Tab(icon: new Icon(Icons.add_circle),
                          text: 'prestation'
                      ),
                      new Tab(icon: new Icon(Icons.event),
                          text: 'promotion'),





                    ]),
              ),
              body: new TabBarView(
                children: controllers(),
              ),
            ),

          );
        }
      }

  }




  List <Widget> controllersProfessionels(){
    return[
      infoProfessionnelController(pro: utilisateur,),
      professionnelSettingsController(),
      profilPersonnel(),

    ];
  }
  List <Widget> controllers () {
    return [
      profilPersonnel(),
      listingPrestationController(),
      promotionController(),


    ];
  }

}