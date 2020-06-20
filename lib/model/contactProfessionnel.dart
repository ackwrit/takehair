import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:takehair/controller/messagerieController.dart';
import 'package:takehair/model/user.dart';

class contactProfessionnel extends StatefulWidget{
  user professionel;
  contactProfessionnel(user pro)
  {
    professionel =pro;
  }
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return homeContact();
  }

}

class homeContact extends State<contactProfessionnel>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(
        title: new Text('Takehair'),
        backgroundColor: Colors.blue[100],

      ),
      body: _Body(),
    );
  }


  Widget _Body(){
    return Center(
        child :new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularPercentIndicator(
              radius: 60.0,
              lineWidth: 5.0,
              percent: 0.5,
              animation: true,
              animationDuration: 20,
              center: new Text("Monnaie"),
              backgroundColor: Colors.white,
              progressColor: Colors.blue[100],


            ),
            Padding(padding: EdgeInsets.all(10)),

            Text(widget.professionel.nom),
            Padding(padding: EdgeInsets.all(10)),
            Text(widget.professionel.login),
            Padding(padding: EdgeInsets.all(10),),
            RaisedButton(
              color: Colors.blue[100],
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                onPressed: (){
                Navigator.push(context, new MaterialPageRoute(
                    builder: (BuildContext context){
                      return messagerieController(widget.professionel);
                    }
                ));
                },
              child: Text('Envoyer un message'),
            )
          ],
        )
    );

  }

}