import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:takehair/controller/panelConversationController.dart';
import 'package:takehair/model/conversation.dart';
import 'package:takehair/model/fireBaseHelper.dart';
import 'package:takehair/model/user.dart';

class administrationContact extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return homeAdminContact();
  }

}

class homeAdminContact extends State<administrationContact>{
  String identifiant;
  user moi;
  conversation discussion;
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact'),
        centerTitle: true,
        backgroundColor: Colors.blue[100],
      ),
      body: bodyPage(),
    );
  }



  Widget bodyPage(){
    return FirebaseAnimatedList(
      query: fireBaseHelper().base_user,
      itemBuilder: (BuildContext context,DataSnapshot snapshot,Animation<double>animation,int index) {
        user admin = user(snapshot);
        if (admin.typeUtilisateur == 'admin') {
          return Card(
            child: ListTile(
              title: Text(admin.login),
              trailing: IconButton(
                  icon: Icon(Icons.chat),
                  onPressed: ()
                  {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (BuildContext context){
                        return panelConversationController(discussion: discussion,moi: admin,);
                      }
                    ));
                  }
              ),

            ),
          );


        }
        else
          {
            return Container();
          }
      },

    );
  }

}