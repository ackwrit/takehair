import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:takehair/controller/checkPaymentController.dart';

import 'package:takehair/model/user.dart';



class paymentController extends StatefulWidget{
  user profession;
  DateTime moment;
  int total;
  //prestation
  paymentController(profession,moment,total)
  {
    this.profession=profession;
    this.moment=moment;
    this.total=total;
  }
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _homepayment();
  }
}

class _homepayment extends State <paymentController> {
  
  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('fr_FR');
    // TODO: implement build
    if (Platform.isIOS) {
      return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: new Text(
            'Takehair', style: new TextStyle(color: Colors.white),),
          backgroundColor: Colors.grey,
        ),
        child: body(),
      );
    }
    else {
      return Scaffold(
        appBar: new AppBar(
          title: new Text(
              'Takehair', style: new TextStyle(color: Colors.white)),
          backgroundColor: Colors.black,
          centerTitle: true,
        ),
        body: body(),
      );
    }
  }

  Widget changementText(String data, Color couleur) {
    if (Platform.isIOS) {
      return new DefaultTextStyle(
          style: new TextStyle(color: couleur, fontSize: 15.0),
          child: new Text(data));
    }
    else {
      return new Text(
          data, style: new TextStyle(color: couleur, fontSize: 15.0));
    }
  }

  Widget changementBouton(String texte, VoidCallback direction) {
    if (Platform.isIOS) {
      return new CupertinoButton(
        onPressed: direction,
        color: Colors.grey,
        child: changementText(texte, Colors.white),
      );
    }
    else {
      return new RaisedButton(
          onPressed: direction,
          color: Colors.blue,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.0)),
          child: changementText(texte, Colors.white)
      );
    }
  }
  Widget body()
  {
    return new Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,

      child: new Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          changementText('Récapitulatif de votre rendez-vous',Colors.black ),
          Image.asset('assets/images/logo.png',
            height: MediaQuery.of(context).size.height/7,
            width:MediaQuery.of(context).size.width/7 ,
          ),
          new Container(
            padding: EdgeInsets.all(10),
            height: MediaQuery.of(context).size.height/1.5,
            width: MediaQuery.of(context).size.width,
            child:Card(
              elevation: 10,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[

                  new Text('${widget.profession.nom} ${widget.profession.prenom} (${widget.profession.login})',style: new TextStyle(fontSize:25)),



                  new Text('${DateFormat.MMMMEEEEd('fr_FR').format(widget.moment)} - ${DateFormat.jm('fr_FR').format(widget.moment)}',style: new TextStyle(fontSize: 25),),
                  new Text('Total : ${widget.total} €',style: new TextStyle(fontSize: 25),)
                ],
              ),


            ),

          ),

          changementBouton('Validation', versCheckPayment)
        ],
      ),

    );

  }



  versCheckPayment(){
    Navigator.push(context, new MaterialPageRoute(
        builder: (BuildContext context)
            {
              return new checkPaymentController(widget.total);
            }
    ));

  }
}