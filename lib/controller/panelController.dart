import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:takehair/controller/bookingController.dart';
import 'package:takehair/controller/map.dart';
import 'package:takehair/controller/panelProfilController.dart';
import 'package:takehair/controller/profilPersonnel.dart';
import 'package:takehair/controller/searchController.dart';

class panelController extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return homePanel();
  }

}

class homePanel extends State<panelController>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if(Theme.of(context).platform==TargetPlatform.iOS)
    {
      return new CupertinoTabScaffold(
          tabBar: new CupertinoTabBar(
              backgroundColor: Colors.blue[100],
              activeColor: Colors.black,
              inactiveColor: Colors.white,
              items:[
                new BottomNavigationBarItem(icon: new Icon(Icons.search),title: new Text("Recherche")),
                new BottomNavigationBarItem(icon: new Icon(Icons.map),title: new Text('Carte')),

                new BottomNavigationBarItem(icon: new Icon(Icons.event),title: new Text('Rendez-vous')),






              ]),
          tabBuilder: (BuildContext context,int index){
            Widget controllerSelected= controllers()[index];
            return new Scaffold(
              appBar: new AppBar(
                actions: [
                  IconButton(icon:Icon(Icons.account_circle), onPressed:()
                {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (BuildContext context)
                          {
                            return panelProfilController();
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
              new IconButton(icon:Icon(Icons.account_circle,size: 32.0,color: Colors.white,), onPressed:null),

            ],
            bottom: new TabBar(
                tabs: [
                  new Tab(icon: new Icon(Icons.comment),),
                  new Tab(icon: new Icon(Icons.directions_bus),),
                  new Tab(icon: new Icon(Icons.account_balance),),

                  new Tab(icon: new Icon(Icons.local_hospital),),
                  new Tab(icon: new Icon(Icons.beach_access),),




                ]),
          ),
          body: new TabBarView(
            children: controllers(),
          ),
        ),

      );
    }



  }



  List <Widget> controllers (){
    return [
      searchController(),
      map(),

      bookingController(),






    ];

  }

}