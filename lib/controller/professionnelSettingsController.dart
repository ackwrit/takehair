import 'package:flutter/material.dart';
import 'package:takehair/controller/administrationContact.dart';
import 'package:takehair/controller/chatContact.dart';

class professionnelSettingsController extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return homeProfSettings();
  }

}

class homeProfSettings extends State<professionnelSettingsController>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RaisedButton(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              onPressed: (){
              Navigator.push(context, MaterialPageRoute(
                  builder: (BuildContext context){
                    return chatContact();
                  }
              ));
              },
            child: Text('Messagerie'),
            color: Colors.blue[100],

          ),
          Padding(padding: EdgeInsets.all(10)),
          RaisedButton(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              onPressed: (){
              print('Afficher Porte-monnaie');
              },
            child: Text('Porte-Monnaie'),
            color: Colors.blue[100],
          ),
          Padding(padding: EdgeInsets.all(10)),
          RaisedButton(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(
                  builder: (BuildContext context)
                      {
                        return administrationContact();
                      }
              ));

            },
            child: Text('Contact'),
            color: Colors.blue[100],
          ),

        ],
      ),
    );
  }

}