import 'package:flutter/material.dart';
import 'package:takehair/model/user.dart';

class infoProfessionnelController extends StatefulWidget{
  user professionnel;
  infoProfessionnelController({user pro})
  {
    this.professionnel = pro;
  }
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return homeInfoPro();
  }

}


class homeInfoPro extends State<infoProfessionnelController>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(widget.professionnel.mail),
          Text(widget.professionnel.nom),
          Text(widget.professionnel.prenom),

        ],
      )

    );

  }

}