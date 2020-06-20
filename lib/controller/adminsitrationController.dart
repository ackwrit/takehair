import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:takehair/controller/listingProfessionnelController.dart';
import 'package:takehair/controller/promotionController.dart';
import 'package:takehair/listingPrestationController.dart';




class administrationController extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return homeAdministration();
  }

}


class homeAdministration extends State<administrationController>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (Theme
        .of(context)
        .platform == TargetPlatform.iOS) {
      return new CupertinoTabScaffold(
          tabBar: new CupertinoTabBar(
              backgroundColor: Colors.blue[100],
              activeColor: Colors.black,
              inactiveColor: Colors.white,
              items: [
                new BottomNavigationBarItem(icon: new Icon(Icons.search,),title: new Text("Professionnel",style: new TextStyle(fontSize: 18),)),
                new BottomNavigationBarItem(icon: new Icon(Icons.format_list_bulleted),title:new Text('Prestation',style: new TextStyle(fontSize: 18),)),
                new BottomNavigationBarItem(icon: new Icon(Icons.attach_money),title:new Text('Promotion',style: new TextStyle(fontSize: 18),)),


              ]
          ),
          tabBuilder: (BuildContext context, int index) {
            Widget controllerSelected = controller()[index];
            return Scaffold(
                appBar: AppBar(


                  backgroundColor: Colors.blue[100],

                ),
                body: controllerSelected
            );
          }
      );
    }
    else {
      return DefaultTabController(
          length: 3,
          child: Scaffold(
              appBar: AppBar(



                centerTitle: true,
                backgroundColor: Colors.lightBlue,


                bottom: new TabBar(
                  tabs: [
                    new Tab(
                      icon: new Icon(Icons.search),
                      child: new Text("Professionnel",style: new TextStyle(fontSize: 18),),
                    ),
                    new Tab(
                      icon: new Icon(Icons.format_list_bulleted),
                      child: new Text("Prestation",style: new TextStyle(fontSize: 18),),
                    ),

                    new Tab(
                      icon: new Icon(Icons.format_list_bulleted),
                      child: new Text("Promotion",style: new TextStyle(fontSize: 18),),
                    ),




                  ],
                  labelColor: Colors.orangeAccent,
                  indicatorColor: Colors.black,
                  unselectedLabelColor: Colors.white,
                ),
              ),
              body: new TabBarView(
                children: controller(),
              )
          )
      );





    }




  }









  _help()
  {
    //envoyer vers la page help
  }

  _login()
  {
    //envoyer vers la page login
    Navigator.push(context, new MaterialPageRoute(
        builder: (BuildContext context)
        {
          return  null;
        }
    ));

  }



  List<Widget> controller()
  {
    return[
      listingProfessionnelController(),
      listingPrestationController(),
      promotionController(),//créeer la page promotion


    ];
  }




}