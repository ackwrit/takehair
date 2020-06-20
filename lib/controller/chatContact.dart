import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:takehair/controller/panelConversationController.dart';
import 'package:takehair/model/conversation.dart';
import 'package:takehair/model/fireBaseHelper.dart';
import 'package:takehair/model/user.dart';

class chatContact extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return homeChatContact();
  }

}

class homeChatContact extends State<chatContact>{
  String id;
  user moi;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fireBaseHelper().myId().then((uid)
    {
      setState(() {
        id=uid;
      });
      fireBaseHelper().getUser(id).then((user)
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Takehair'),
        centerTitle: true,
        backgroundColor: Colors.blue[100],

      ),
      body: bodyPage(),

    );
  }



  Widget bodyPage(){
    return FirebaseAnimatedList(
        query: fireBaseHelper().base_conversation.child(moi.id),
        sort: (a,b)=>b.value['dateString'].compareTo(a.value['dateString']),
        itemBuilder: (BuildContext context,DataSnapshot snapshot,Animation<double>animation,int index){
          conversation converse = conversation(snapshot);

              return Card(
                child: ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("dernier message : ${converse.last_message}"),
                      IconButton(
                          icon: Icon(Icons.chat),
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(
                                builder: (BuildContext context){
                                  return panelConversationController(moi: moi,discussion: converse,);
                                }
                            ));
                          }
                      )
                    ],
                  ),

                  subtitle: Text("de ${converse.partenaire.login}"),
                  trailing: Text(converse.date),
                ),
              );



        }
    );
  }

}