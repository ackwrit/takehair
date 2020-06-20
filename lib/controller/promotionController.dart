import 'package:flutter/material.dart';
import 'package:takehair/controller/promoRegisterController.dart';
import 'package:takehair/controller/promotionHistoriqueController.dart';

class promotionController extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return homePromotion();
  }

}

class homePromotion extends State<promotionController>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  bodyPage();
  }


  Widget bodyPage(){
    return Container(
      child: Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
              child: Text('Historique des promotions'),
              onPressed:(){
                Navigator.push(context, new MaterialPageRoute(
                    builder: (BuildContext context){
                      return promotionHistoriqueController();
                    }
                ));
              },
            ),
            FlatButton(
                onPressed: (){
                  Navigator.push(context, new MaterialPageRoute(
                      builder: (BuildContext context){
                        return promoRegisterController();
                      }
                  ));
                },
                child: Text("Création d'un code promo" ))
          ],
        ),
      ),
    );
  }
}