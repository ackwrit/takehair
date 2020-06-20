import 'package:flutter/material.dart';

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:takehair/controller/bookingController.dart';
import 'package:takehair/controller/mainAppController.dart';
import 'package:takehair/controller/prestationController.dart';
import 'package:takehair/model/user.dart';
import 'package:flutter_multi_carousel/carousel.dart';








class choixProfessionnelController extends StatefulWidget
{
  int heure;
  var jour;
  var mois;
  user profession;
  String id;

  choixProfessionnelController(@required String id,@required DateTime daterendezvous,@required user profession){
    this.id=id;
    this.jour=daterendezvous.day;
    this.mois=daterendezvous.month;
    this.heure=daterendezvous.hour;
    this.profession=profession;
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _homeDetailProfessionnel();
  }

}



class _homeDetailProfessionnel extends State <choixProfessionnelController>
{

  //CardController controller;
  List <String> images;
  DateTime moment;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    images =[
      "assets/images/cut-1.jpg",
          "assets/images/cut-2.jpg",
         "assets/images/cut-3.jpg",
          "assets/images/cut-4.jpg",
          "assets/images/cut-5.jpg",
          "assets/images/cut-6.jpg"
    ];
    print('heure :${widget.heure}');
    print('jour : ${widget.jour}');
    print('Profession ${widget.profession}');
    print('Mois : ${widget.mois}');
    moment=new DateTime(DateTime.now().year,widget.mois,widget.jour,widget.heure);
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if(Platform.isIOS)
    {
      return CupertinoPageScaffold(
        navigationBar:CupertinoNavigationBar(
          middle: new Text('Takehair',style: new TextStyle(color: Colors.white),),
          backgroundColor: Colors.blue[100],
        ),
        child: body(),
      );
    }
    else
    {
      return Scaffold(
        appBar: AppBar(
          title: new Text('Takehair',style: new TextStyle(color: Colors.white),),
          centerTitle: true,
          backgroundColor: Colors.blue[100],
        ),
        body: body(),
      );
    }
    ;
  }

  Widget body(){
    return new SingleChildScrollView(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Padding(padding: EdgeInsets.all(10)),
            Container(
              width:100.0,
              height: 100.0,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage("assets/images/blank-profile-picture-973460_1280.png"),
                  )
              ),
            ),
            Padding(padding: EdgeInsets.all(10)),
            //Icon(Icon:)
            changementText('${widget.profession.nom}', Colors.black),
            changementText('${widget.profession.prenom}', Colors.black),
           

            Container(
                padding:EdgeInsets.all(20.0),
                height: MediaQuery.of(context).size.height/3.8,
                width: MediaQuery.of(context).size.width,
                child: Card(
                  child:changementText('Description', Colors.black),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                )
            ),


            new Carousel(
                 height: MediaQuery.of(context).size.height/3,
                 width: MediaQuery.of(context).size.width-30,
                 type: Types.slideSwiper,
                 initialPage:(images.length/2).round(),
                 axis: Axis.horizontal,
                 allowWrap: false,
                 indicatorType: IndicatorTypes.bar,
                 activeIndicatorColor: Colors.white,
                 indicatorBackgroundOpacity:0.0,
                 indicatorBackgroundColor: Colors.white,
                 children: List.generate(
                     images.length,
                     (index)=>new Image.asset(images[index]))
             ),


            
            Padding(
              padding: EdgeInsets.all(10),
            ),





            //Card(
            //elevation: 8.0,
            //child: Image.asset('assets/images/cut-1.jpg' ,fit: BoxFit.cover),
            //),



            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                changementBouton('Validation')
              ],
            ),




          ]
      )
    );
  }









  Widget changementBouton(String texte)
  {
    if(Platform.isIOS)
    {
      return new CupertinoButton(
        onPressed: versPrestation,
        color: Colors.blue[100],
        child: changementText(texte,Colors.white),
      );

    }
    else
    {
      return new RaisedButton(
          onPressed:versPrestation,
          color: Colors.blue[100],
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






  void versPrestation()
  {
    if(Platform.isIOS)
    {
      Navigator.push(context, new CupertinoPageRoute(builder:
          (BuildContext c)
      {
        return new mainAppController(moment,widget.profession);
      }
      ));
    }
    else {
      Navigator.push(context, new MaterialPageRoute(builder:
          (BuildContext context) {
        return new mainAppController(moment,widget.profession);
      }
      ));
    }
  }
}