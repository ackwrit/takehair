import 'package:flutter/material.dart';
import 'package:takehair/controller/adminsitrationController.dart';
import 'package:takehair/model/fireBaseHelper.dart';
import 'package:takehair/model/prestation.dart';

class listingPrestationDetailController extends StatefulWidget{
  prestation presta;
  listingPrestationDetailController(prestation p){
    this.presta =p ;
  }
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return homeListingPrestaDetail();
  }

}

class homeListingPrestaDetail extends State<listingPrestationDetailController>{
  prestation presta;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    presta = widget.presta;
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(
        title: Text('Takehair'),
        backgroundColor: Colors.blue,

      ),
      body: bodyPage(),
    );
  }

  Widget bodyPage(){
    return Center(
      child:Container(
        padding: EdgeInsets.all(10),
        child:new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)
                  ),
                  hintText: presta.nom,
                  filled: true,
                  fillColor: Colors.white
              ),
              textAlign: TextAlign.center,
              onChanged: (text){
                setState(() {
                  presta.nom = text;
                });
              },



            ),
            Padding(padding: EdgeInsets.all(10)),
            TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)
                  ),
                  hintText: presta.prix,
                  filled: true,
                  fillColor: Colors.white
              ),
              textAlign: TextAlign.center,
              onChanged: (text){
                setState(() {
                  presta.prix= text;
                });
              },



            ),
            Padding(padding: EdgeInsets.all(10),),
            RaisedButton(
              child:  Text('Enregsitrer'),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                color: Colors.blue,
                onPressed: (){
                Map map={
                  "uid":presta.id,
                  "nom":presta.nom,
                  "prix":presta.prix,
                  "typePrestation":""
                };
                fireBaseHelper().addPrestation(presta.id, map);
                Navigator.push(context, new MaterialPageRoute(
                    builder: (BuildContext context){
                      return new administrationController();
                    }
                ));
                }
            )



          ],
        ) ,
      )
      

    );


  }

}