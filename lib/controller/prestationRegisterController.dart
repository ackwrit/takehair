import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';
import 'package:takehair/controller/adminsitrationController.dart';
import 'package:takehair/controller/panelProfilController.dart';
import 'package:takehair/model/fireBaseHelper.dart';

class prestationRegisterController extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return homePrestation();
  }

}

class homePrestation extends State<prestationRegisterController>{
  String prix="";
  String titre="";
  String typePrestation="Coiffure";
  String dropdownValue='Coiffure';
  List<String>annonceListing=["Coiffure","Barbier","Soin","Tondeuse"];
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      key: scaffoldKey,

      appBar: AppBar(
        title: Text('Takehair'),
        backgroundColor: Colors.blue[100],
      ),
      body: bodyPage(),
    );
  }


  showSnackBar(){
    String rand = randomAlphaNumeric(20);
    String uid = rand;
    Map map ={
      "uid":uid,
      "nom":titre,
      "prix":prix,
      "typePrestation":typePrestation
    };
    fireBaseHelper().addPrestation(uid, map);
    final snackbar = SnackBar(
        content: Text('Enregsitrement effectué'),
      duration: Duration(seconds: 10),
    );

    scaffoldKey.currentState.showSnackBar(snackbar);
    Navigator.push(context,MaterialPageRoute(
        builder: (BuildContext context)
            {
              return panelProfilController();
            }
    ));



  }



  Widget bodyPage()
  {
    return new Container(
      padding: EdgeInsets.all(10),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DropdownButton(
                onChanged: (String newValue){
                  setState(() {
                    typePrestation =newValue;
                  });
                },
                value: typePrestation,
                items:annonceListing.map<DropdownMenuItem<String>>((String value){
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value,textAlign: TextAlign.center,),
                  );

                }).toList()
            ),
            Padding(padding: EdgeInsets.all(10)),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20)
                ),
                hintText:'Entrer le nom de votre prestation',
                filled: true,
                fillColor: Colors.white,
              ),
              textAlign: TextAlign.center,
              onChanged: (value){
                setState(() {
                  titre =value;
                });
              },
            ),
            Padding(padding: EdgeInsets.all(10),),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)
                ),
                hintText:'Entrer le prix de votre prestation',
                filled: true,
                fillColor: Colors.white,
              ),
              textAlign: TextAlign.center,
              onChanged: (value){
                setState(() {
                  prix =value;
                });
              },
            ),
            Padding(padding: EdgeInsets.all(10)),
            RaisedButton(
                onPressed: ()
                    {
                      //enregistrement dans la base de donnée partie prestation
                      showSnackBar();

                    },
              child: Text('Enregistrement'),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            )

          ],
        ),
      ),
    );
  }

}