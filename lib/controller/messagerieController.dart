import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:takehair/controller/messageController.dart';
import 'package:takehair/model/conversation.dart';
import 'package:takehair/model/fireBaseHelper.dart';
import 'package:takehair/model/user.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:takehair/widget/chatBubble.dart';

class messagerieController extends StatefulWidget{
  user pro;
  messagerieController(user pro)
  {
    this.pro =pro;
  }
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return homeMessagerie();
  }

}

class homeMessagerie extends State<messagerieController>{

  TextEditingController _textEditingController = new TextEditingController();

  String identifiant;
  user moi;
  //TextEditingController _textEditingController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fireBaseHelper().myId().then((uid)
    {
      setState(() {
        identifiant=uid;
      });
      fireBaseHelper().getUser(identifiant).then((user)
      {
        setState(() {
          moi=user;
        });

      });

    });
  }


  @override


  Widget build(BuildContext context) {

    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.blue[100],
        title: Text('Takehair'),

      ),
      body: _widgetBody(),
    );
  }


  Widget _widgetBody(){

    return new Column(

      children: <Widget>[
        Container(
          height:MediaQuery.of(context).size.height/10,
          child: FirebaseAnimatedList(
            query: fireBaseHelper().base_conversation.child(moi.id),
            sort: (a,b)=>b.value['dateString'].compareTo(a.value['dateString']),
            itemBuilder: (BuildContext context,DataSnapshot snapshot,Animation<double> animation,int index){
              conversation converse =new conversation(snapshot);
              return new Card(
                child: ListTile(
                  title: Text("Dernier message : ${converse.last_message}"),
                  trailing: Row(
                    children: [
                      Text(converse.date),
                    ],

                  ),



                )
              );


            },



          ),

        ),
        new Divider(height: 1.5,),
        Container(
          height: MediaQuery.of(context).size.height/1.7,
          child:  FirebaseAnimatedList(
              sort: (a,b)=>a.value['dateString'].compareTo(b.value['dateString']),

                query: fireBaseHelper().base_message.child(fireBaseHelper().getMessageRef(moi.id, widget.pro.id)),
                itemBuilder: (BuildContext context,DataSnapshot snapshot,Animation<double>animation,int index)
                {
                  message mess = message(snapshot);
                  return chatBubble(identifiant, widget.pro, mess, animation);
                }
            ),

        ),




        new Divider(height: 1.5,),
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
        fireBaseHelper().sendMessage(texte, moi, widget.pro);
        _textEditingController.clear();
        FocusScope.of(context).requestFocus(new FocusNode());

      }
  }

}

