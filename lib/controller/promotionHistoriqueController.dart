import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:takehair/model/fireBaseHelper.dart';
import 'package:takehair/model/promotion.dart';
import 'package:intl/date_symbol_data_local.dart';

class promotionHistoriqueController extends  StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return homeStoryPromo();
  }

}

class homeStoryPromo extends State<promotionHistoriqueController>{


  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('fr_FR');
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Takehair'),
        backgroundColor: Colors.blue[100],
      ),
      body: bodyPage(),
    );
  }


  Widget bodyPage(){
    return FirebaseAnimatedList(
        query: fireBaseHelper().base_promotion,
        itemBuilder: (BuildContext context,DataSnapshot snapshot,Animation<double>animation,int index)
        {
          promotion promo = promotion(snapshot);
          return ListTile(

            trailing: Text("${promo.pourcentage} %"),
            title: Text("Code promo : ${promo.code}",textAlign: TextAlign.center,),


            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(DateFormat.yMd('fr_Fr').format(DateTime.fromMicrosecondsSinceEpoch(int.parse(promo.debut)))),
                Text('-'),
                Text(DateFormat.yMd('fr_Fr').format(DateTime.fromMicrosecondsSinceEpoch(int.parse(promo.fin)))),

              ],
            ) ,


        );

  }
    );
  }
}