import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:takehair/controller/messageController.dart';
import 'package:takehair/model/user.dart';

class chatBubble extends StatelessWidget{

  message mess;
  user partenaire;
  String monId;
  Animation animation;

  chatBubble(String id,user partenaire,message mess,Animation animation)
  {
    this.mess =mess;
    this.partenaire = partenaire;
    this.animation =animation;
    this.monId =id;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new SizeTransition(
        sizeFactor: new CurvedAnimation(parent: animation, curve: Curves.easeIn),
      child: Container(
        margin: EdgeInsets.all(10),
        child: Row(
          children: widgetBubble(mess.from==monId)
        ),
      ),
    );
  }


  List <Widget> widgetBubble(bool moi){
    CrossAxisAlignment alignment =(moi)? CrossAxisAlignment.start:CrossAxisAlignment.end;
    Color bubbleColor =(moi)?Colors.orangeAccent:Colors.blue[100];
    Color textColors =(moi)? Colors.black:Colors.white;

    return <Widget>[

      new Expanded(
          child: Column(
            crossAxisAlignment: alignment,
            children: [
              new Text(mess.dateString),
              new Card(
                elevation: 5.0,
                color: bubbleColor,
                shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(10) ),
                child: Container(
                  padding: EdgeInsets.all(5.0),
                  child: new Text(mess.texte ?? "",style: TextStyle(color: textColors),),
                ),

              ),
            ],
          )
      )

    ];

  }
  
}