import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:takehair/model/conversation.dart';
import 'package:takehair/model/fireBaseHelper.dart';
import 'package:takehair/model/user.dart';
import 'package:takehair/widget/chatBubble.dart';

import 'messageController.dart';

class panelConversationController extends StatefulWidget{
  user moi;
  conversation discussion;
  panelConversationController({user moi,conversation discussion})
  {
    this.moi=moi;
    this.discussion=discussion;
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return homePanelConversation();
  }

}

class homePanelConversation extends State<panelConversationController>{
  TextEditingController _textEditingController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.discussion.partenaire.login),
        centerTitle: true,
        backgroundColor: Colors.blue[100],
      ),
      body: bodyPage(),
    );
  }



  Widget bodyPage(){
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height/1.5,
          child:  FirebaseAnimatedList(
              sort: (a,b)=>a.value['dateString'].compareTo(b.value['dateString']),

              query: fireBaseHelper().base_message.child(fireBaseHelper().getMessageRef(widget.moi.id, widget.discussion.partenaire.id)),
              itemBuilder: (BuildContext context,DataSnapshot snapshot,Animation<double>animation,int index)
              {
                message mess = message(snapshot);
                return chatBubble(widget.moi.id, widget.discussion.partenaire, mess, animation);
              }
          ),

        ),
        Divider(height: 1.5,),
        new Container(
          child: new Row(
            children: <Widget>[
              Flexible(
                child: TextField(
                  controller: _textEditingController,
                  decoration: InputDecoration.collapsed(hintText: 'Ecrivez quelque chose'),
                ),

              ),

              new IconButton(icon: Icon(Icons.send), onPressed: _sendButtonPressed),
            ],
          ),
        ),

      ],

    );


  }

  _sendButtonPressed()
  {
    if(_textEditingController.text!=null && _textEditingController.text!="")
    {
      String texte = _textEditingController.text;
      fireBaseHelper().sendMessage(texte, widget.moi, widget.discussion.partenaire);
      _textEditingController.clear();
      FocusScope.of(context).requestFocus(new FocusNode());

    }
  }




}