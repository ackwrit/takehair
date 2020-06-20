import 'package:calendar_strip/calendar_strip.dart';
import 'package:flutter/material.dart';
import 'package:takehair/controller/panelProfilController.dart';
import 'package:takehair/controller/promotionController.dart';
import 'package:takehair/model/fireBaseHelper.dart';

class promoRegisterController extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return homePromoResgiter();
  }

}

class homePromoResgiter extends State<promoRegisterController>{
  DateTime debutPromotion= DateTime.now();
  DateTime finPromotion = DateTime.now();
  String code;
  String pourcentage;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(
        title: Text('Takehair'),
        backgroundColor: Colors.blue[100],

      ),
      body: bodyPage(),
    );
  }


  Widget bodyPage(){
    return new Container(
      padding: EdgeInsets.all(20),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //Donner un code promo
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                hintText: 'Entrez votre code promo',
                fillColor: Colors.white,
                filled: true
              ),
              textAlign: TextAlign.center,
              onChanged: (String valeur){
                setState(() {
                  code = valeur;
                });
              },
            ),
            Padding(padding: EdgeInsets.all(10)),

            

            // % du code promo

            TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  hintText: 'Entrez le pourcentage de la promotion',
                  fillColor: Colors.white,
                  filled: true
              ),
              textAlign: TextAlign.center,
              onChanged: (String value){
                setState(() {
                  pourcentage = value;
                });
              },
            ),
            // durée de validité
            Padding(padding: EdgeInsets.all(10)),
            Text("Début de la promotion"),
            CalendarStrip(
              iconColor: Colors.blue[100],
              startDate: debutPromotion,
              endDate: debutPromotion.add(Duration(days: 30)),

              onDateSelected: (date){
                setState(() {
                  debutPromotion=date;
                  finPromotion =date;
                });
              },

            ),
            Padding(padding: EdgeInsets.all(10)),
            Text("Fin de la promotion"),
            CalendarStrip(
              iconColor: Colors.blue[100],
              startDate: finPromotion,
              endDate: finPromotion.add(Duration(days: 30)),

              onDateSelected: (date){
                setState(() {
                  finPromotion = date;
                });
              },
             

            ),
            RaisedButton(
                onPressed: (){
                  fireBaseHelper().sendPromotion(debutPromotion, finPromotion, code, pourcentage);


                  Navigator.push(context, new MaterialPageRoute(
                      builder: (BuildContext context){
                        return panelProfilController();
                      }
                  ));

                },
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              color: Colors.blue[100],
              child: Text('Enregsitrer'),
            ),

          ],
        ),
      ),
    );
  }
}