import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:takehair/controller/map.dart';
import 'package:takehair/controller/paymentController.dart';
import 'package:takehair/fonction/changementText.dart';
import 'package:takehair/fonction/bouton.dart';
import 'package:takehair/model/fireBaseHelper.dart';
import 'package:takehair/model/prestation.dart';
import 'package:takehair/model/user.dart';

class prestationController extends StatefulWidget{


  int index=0;
  DateTime moment;
  user profession;

  prestationController({int index,DateTime moment,user profession})
  {
    this.index=index;
    this.moment=moment;
    this.profession=profession;
  }
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return prestationHome();
  }

}

class prestationHome extends State<prestationController>{

  ////VARIABLE
  int prestacheveux=0;
  int prestapointe=0;
  int prestabarbe=0;
  int prestasoinbarbe=0;
  int prestacomplexe=0;
  int prestaegalisatoncheveux=0;
  int prestaboule=0;
  int prestarasage=0;
  int totalTondeuse=0;


  int prestabrushing=0;
  int prestacarre=0;
  int prestachignon=0;
  int prestabraids=0;
  int prestafausselocks=0;
  int prestaextension=0;
  int locksdemi=0;
  int lockstete=0;
  int demimeches=0;
  int demisansmeches=0;
  int tetemeches=0;
  int tetesansmeches=0;
  int partielle=0;
  int complete=0;
  int naturel=0;
  int synthetique=0;


  int prestasoinvisage=0;
  List compteur=List(3000);
  int variableTest=0;


  int total=0;
  int coucou;
  bouton validation=new bouton('Validation', Colors.black, Colors.white);




  ////////////
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Takehair",style: new TextStyle(color: Colors.white),),
        backgroundColor: Colors.blue[100],
      ),
      body: body(),
    );
  }




////////////////PIRNCIPAL

  Widget body(){
    return new SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Image.asset("assets/images/logo.png",
            width:MediaQuery.of(context).size.width/3,
              height: MediaQuery.of(context).size.height/3,
            ),
            choix(),
            Padding(
              padding: EdgeInsets.all(10.0),
            ),
            changementText('Total : $total €', Colors.black),
            Padding(
              padding: EdgeInsets.all(10.0),
            ),
            validation.pressionBouton('Paiement', versmap, Colors.black)
          ],
        ),
      ),

    );
  }





  Widget choix(){
    switch(widget.index)
    {
      case 1:return ciseauAffichage();
      break;
      case 2:return tondeuseAffichage();
      break;
      case 3:return coiffureAffichage();
      break;
      case 4:return affichageSoin();
      break;
      default:break;


    }


  }

  void versmap()
  {
    Navigator.push(context, new MaterialPageRoute(builder:
        (BuildContext context){
      return paymentController(widget.profession,widget.moment,total);
    }
    ));

  }




  ////////////////////////////////////////




////////////////////////////////////////////////////////////////
  ///////                      FONCTION //////////





  Widget changementText(String data, Color couleur) {
    if (Platform.isIOS) {
      return new DefaultTextStyle(
          style: new TextStyle(color: couleur, fontSize: 15.0),
          child: new Text(data));
    }
    else {
      return new Text(
          data, style: new TextStyle(color: couleur, fontSize: 15.0));
    }
  }








  /////////:WIDGET DIFFERENT


  //////CISEAU

  Widget ciseauAffichage()
  {
    return Container(
      height: MediaQuery.of(context).size.height/3,
      child: FirebaseAnimatedList(
        shrinkWrap: true,
          scrollDirection: Axis.vertical,
          query: fireBaseHelper().base_prestation,
          itemBuilder: (BuildContext context,DataSnapshot snapshot,Animation<double>animation,int index){
            prestation presta = prestation(snapshot);
            compteur[index]=0;
            coucou=0;


           return ListTile(
             title: Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [

                 Text(presta.nom),
                 IconButton(
                     icon: Icon(Icons.remove_circle),
                     onPressed: ()
                     {

                         if(compteur[index]==0)
                           {
                             setState(() {
                               compteur[index]=0;
                             });


                           }
                         else
                           {
                             setState(() {
                               compteur[index]--;
                               total=total+compteur[index]*int.parse(presta.prix);
                             });

                           }



                     }
                 ),
                 Text(compteur[index].toString()),




                 IconButton(
                     icon: Icon(Icons.add_circle),
                     onPressed: (){
                       setState(() {
                         compteur[index]++;
                         total = total+ compteur[index]*int.parse(presta.prix);

                       });
                     }
                 ),

               ],
             ),
             subtitle: Text("${presta.prix} €"),

           );


          }
      ),

    );






  }




  ////////////////Tondeuse/////////////
Widget tondeuseAffichage()
{
  return Card(
    elevation: 30.0,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        new Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            changementText('Coupe de cheveux (15€)           ', Colors.black),
            Card(
              child:IconButton(icon: Icon(Icons.remove_circle),
                onPressed: ()
                {
                  if(prestacheveux==0)
                  {
                    setState(() {
                      prestacheveux=0;
                      total=prestacomplexe*18+prestabarbe*7+prestacheveux*15+prestaegalisatoncheveux*7+prestaboule*10+prestarasage*7+prestasoinbarbe*25;
                    });
                  }
                  else
                    setState(() {
                      prestacheveux--;
                      total=prestacomplexe*18+prestabarbe*7+prestacheveux*15+prestaegalisatoncheveux*7+prestaboule*10+prestarasage*7+prestasoinbarbe*25;
                    });
                },
              ),
            ),
            changementText(
                '$prestacheveux',
                Colors.black),
            Card(
              child:IconButton(icon: Icon(Icons.add_circle),
                onPressed: ()
                {
                  setState(() {
                    prestacheveux++;
                    total=prestacomplexe*18+prestabarbe*7+prestacheveux*15+prestaegalisatoncheveux*7+prestaboule*10+prestarasage*7+prestasoinbarbe*25;
                  });
                },
              ),
            ),

          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            changementText('Coupe motifs complexes (18 €)', Colors.black),
            Card(
              child:IconButton(icon: Icon(Icons.remove_circle),
                onPressed: ()
                {
                  if(prestacomplexe==0)
                  {
                    setState(() {
                      prestacomplexe=0;
                      total=prestacomplexe*18+prestabarbe*7+prestacheveux*15+prestaegalisatoncheveux*7+prestaboule*10+prestarasage*7+prestasoinbarbe*25;
                    });
                  }
                  else
                    setState(() {
                      prestacomplexe--;
                      total=prestacomplexe*18+prestabarbe*7+prestacheveux*15+prestaegalisatoncheveux*7+prestaboule*10+prestarasage*7+prestasoinbarbe*25;
                    });
                },
              ),
            ),
            changementText(
                '$prestacomplexe',
                Colors.black),
            Card(
              child:IconButton(icon: Icon(Icons.add_circle),
                onPressed: ()
                {
                  setState(() {
                    prestacomplexe++;
                    total=prestacomplexe*18+prestabarbe*7+prestacheveux*15+prestaegalisatoncheveux*7+prestaboule*10+prestarasage*7+prestasoinbarbe*25;
                  });
                },
              ),
            ),


          ],
        ),



        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            changementText('Rasage de la barbe (7 €)           ', Colors.black),
            Card(
              child:IconButton(icon: Icon(Icons.remove_circle),
                onPressed: ()
                {
                  if(prestarasage==0)
                  {
                    setState(() {
                      prestarasage=0;
                      total=prestacomplexe*18+prestabarbe*7+prestacheveux*15+prestaegalisatoncheveux*7+prestaboule*10+prestarasage*7+prestasoinbarbe*25;
                    });
                  }
                  else
                    setState(() {
                      prestarasage--;
                      total=prestacomplexe*18+prestabarbe*7+prestacheveux*15+prestaegalisatoncheveux*7+prestaboule*10+prestarasage*7+prestasoinbarbe*25;
                    });
                },
              ),
            ),
            changementText(
                '$prestarasage',
                Colors.black),
            Card(
              child:IconButton(icon: Icon(Icons.add_circle),
                onPressed: ()
                {
                  setState(() {
                    prestarasage++;
                    total=prestacomplexe*18+prestabarbe*7+prestacheveux*15+prestaegalisatoncheveux*7+prestaboule*10+prestarasage*7+prestasoinbarbe*25;
                  });
                },
              ),
            ),

          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            changementText('Soin de la barbe (25 €)             ', Colors.black),
            Card(
              child:IconButton(icon: Icon(Icons.remove_circle),
                onPressed: ()
                {
                  if(prestasoinbarbe==0)
                  {
                    setState(() {
                      prestasoinbarbe=0;
                      total=prestacomplexe*18+prestabarbe*7+prestacheveux*15+prestaegalisatoncheveux*7+prestaboule*10+prestarasage*7+prestasoinbarbe*25;
                    });
                  }
                  else
                    setState(() {
                      prestasoinbarbe--;
                      total=prestacomplexe*18+prestabarbe*7+prestacheveux*15+prestaegalisatoncheveux*7+prestaboule*10+prestarasage*7+prestasoinbarbe*25;
                    });
                },
              ),
            ),
            changementText(
                '$prestasoinbarbe',
                Colors.black),
            Card(
              child:IconButton(icon: Icon(Icons.add_circle),
                onPressed: ()
                {
                  setState(() {
                    prestasoinbarbe++;
                    total=prestacomplexe*18+prestabarbe*7+prestacheveux*15+prestaegalisatoncheveux*7+prestaboule*10+prestarasage*7+prestasoinbarbe*25;
                  });
                },
              ),
            ),


          ],
        ),

      ],
    ),

  );
}







/////////////////////////////////////////////











///////////////CAROUSEL//////


  Widget secondCarroussel()
  {
    return new Card(
      elevation: 30.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          //seconde caroussel

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              changementText('collé demi-tête avec mèches (25 €)', Colors.black),
              Card(
                child: IconButton(
                  icon: Icon(Icons.remove_circle),
                  onPressed: ()
                  {
                    if(demimeches==0) {
                      setState(() {
                        demimeches = 0;
                      });
                    }
                    else
                    {
                      setState(() {
                        demimeches--;
                        total=prestabrushing*15+prestacarre*30+prestachignon*30+prestabraids*80+prestafausselocks*50+prestaextension*15+locksdemi*40+lockstete*80+demimeches*25+
                            demisansmeches*20+tetemeches*45+tetesansmeches*35+partielle*25+complete*50+naturel*40+synthetique*30;
                      });
                    }
                  },
                ),

              ),
              changementText('$demimeches', Colors.black),
              Card(
                child: IconButton(
                  icon: Icon(Icons.add_circle),
                  onPressed: ()
                  {
                    setState(() {
                      demimeches++;
                      total=prestabrushing*15+prestacarre*30+prestachignon*30+prestabraids*80+prestafausselocks*50+prestaextension*15+locksdemi*40+lockstete*80+demimeches*25+
                          demisansmeches*20+tetemeches*45+tetesansmeches*35+partielle*25+complete*50+naturel*40+synthetique*30;
                    });
                  },
                ),

              ),
            ],

          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              changementText('collé demi-tête sans mèches (20 €)', Colors.black),
              Card(
                child: IconButton(
                  icon: Icon(Icons.remove_circle),
                  onPressed: ()
                  {
                    if(demisansmeches==0) {
                      setState(() {
                        demisansmeches = 0;
                      });
                    }
                    else
                    {
                      setState(() {
                        demisansmeches--;
                        total=prestabrushing*15+prestacarre*30+prestachignon*30+prestabraids*80+prestafausselocks*50+prestaextension*15+locksdemi*40+lockstete*80+demimeches*25+
                            demisansmeches*20+tetemeches*45+tetesansmeches*35+partielle*25+complete*50+naturel*40+synthetique*30;
                      });
                    }
                  },
                ),

              ),
              changementText('$demisansmeches', Colors.black),
              Card(
                child: IconButton(
                  icon: Icon(Icons.add_circle),
                  onPressed: ()
                  {
                    setState(() {
                      demisansmeches++;
                      total=prestabrushing*15+prestacarre*30+prestachignon*30+prestabraids*80+prestafausselocks*50+prestaextension*15+locksdemi*40+lockstete*80+demimeches*25+
                          demisansmeches*20+tetemeches*45+tetesansmeches*35+partielle*25+complete*50+naturel*40+synthetique*30;
                    });
                  },
                ),

              ),

            ],

          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              changementText('permanente partielle (25 €)             ', Colors.black),
              Card(
                child: IconButton(
                  icon: Icon(Icons.remove_circle),
                  onPressed: ()
                  {
                    if(partielle==0) {
                      setState(() {
                        partielle = 0;
                      });
                    }
                    else
                    {
                      setState(() {
                        partielle--;
                        total=prestabrushing*15+prestacarre*30+prestachignon*30+prestabraids*80+prestafausselocks*50+prestaextension*15+locksdemi*40+lockstete*80+demimeches*25+
                            demisansmeches*20+tetemeches*45+tetesansmeches*35+partielle*25+complete*50+naturel*40+synthetique*30;
                      });
                    }
                  },
                ),

              ),
              changementText('$partielle', Colors.black),
              Card(
                child: IconButton(
                  icon: Icon(Icons.add_circle),
                  onPressed: ()
                  {
                    setState(() {
                      partielle++;
                      total=prestabrushing*15+prestacarre*30+prestachignon*30+prestabraids*80+prestafausselocks*50+prestaextension*15+locksdemi*40+lockstete*80+demimeches*25+
                          demisansmeches*20+tetemeches*45+tetesansmeches*35+partielle*25+complete*50+naturel*40+synthetique*30;
                    });
                  },
                ),

              ),


            ],

          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              changementText('permanente complète (50 €)          ', Colors.black),
              Card(

                child: IconButton(
                  icon: Icon(Icons.remove_circle),
                  onPressed: ()
                  {
                    if(complete==0) {
                      setState(() {
                        complete = 0;
                      });
                    }
                    else
                    {
                      setState(() {
                        complete--;
                        total=prestabrushing*15+prestacarre*30+prestachignon*30+prestabraids*80+prestafausselocks*50+prestaextension*15+locksdemi*40+lockstete*80+demimeches*25+
                            demisansmeches*20+tetemeches*45+tetesansmeches*35+partielle*25+complete*50+naturel*40+synthetique*30;
                      });
                    }
                  },
                ),

              ),
              changementText('$complete', Colors.black),
              Card(
                child: IconButton(
                  icon: Icon(Icons.add_circle),
                  onPressed: ()
                  {
                    setState(() {
                      complete++;
                      total=prestabrushing*15+prestacarre*30+prestachignon*30+prestabraids*80+prestafausselocks*50+prestaextension*15+locksdemi*40+lockstete*80+demimeches*25+
                          demisansmeches*20+tetemeches*45+tetesansmeches*35+partielle*25+complete*50+naturel*40+synthetique*30;
                    });
                  },
                ),

              ),
            ],

          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              changementText('perruque naturelle (40 €)               ', Colors.black),
              Card(

                child: IconButton(
                  icon: Icon(Icons.remove_circle),
                  onPressed: ()
                  {
                    if(naturel==0) {
                      setState(() {
                        naturel = 0;
                      });
                    }
                    else
                    {
                      setState(() {
                        naturel--;
                        total=prestabrushing*15+prestacarre*30+prestachignon*30+prestabraids*80+prestafausselocks*50+prestaextension*15+locksdemi*40+lockstete*80+demimeches*25+
                            demisansmeches*20+tetemeches*45+tetesansmeches*35+partielle*25+complete*50+naturel*40+synthetique*30;
                      });
                    }
                  },
                ),

              ),
              changementText('$naturel', Colors.black),
              Card(
                child: IconButton(
                  icon: Icon(Icons.add_circle),
                  onPressed: ()
                  {
                    setState(() {
                      naturel++;
                      total=prestabrushing*15+prestacarre*30+prestachignon*30+prestabraids*80+prestafausselocks*50+prestaextension*15+locksdemi*40+lockstete*80+demimeches*25+
                          demisansmeches*20+tetemeches*45+tetesansmeches*35+partielle*25+complete*50+naturel*40+synthetique*30;
                    });
                  },
                ),

              ),


            ],

          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              changementText('perruque synthétique (30 €)         ', Colors.black),
              Card(

                child: IconButton(
                  icon: Icon(Icons.remove_circle),
                  onPressed: ()
                  {
                    if(synthetique==0) {
                      setState(() {
                        synthetique = 0;
                      });
                    }
                    else
                    {
                      setState(() {
                        synthetique--;
                        total=prestabrushing*15+prestacarre*30+prestachignon*30+prestabraids*80+prestafausselocks*50+prestaextension*15+locksdemi*40+lockstete*80+demimeches*25+
                            demisansmeches*20+tetemeches*45+tetesansmeches*35+partielle*25+complete*50+naturel*40+synthetique*30;
                      });
                    }
                  },
                ),

              ),
              changementText('$synthetique', Colors.black),
              Card(
                child: IconButton(
                  icon: Icon(Icons.add_circle),
                  onPressed: ()
                  {
                    setState(() {
                      synthetique++;
                      total=prestabrushing*15+prestacarre*30+prestachignon*30+prestabraids*80+prestafausselocks*50+prestaextension*15+locksdemi*40+lockstete*80+demimeches*25+
                          demisansmeches*20+tetemeches*45+tetesansmeches*35+partielle*25+complete*50+naturel*40+synthetique*30;
                    });
                  },
                ),

              ),
            ],

          ),
          ///////// fin second carroussel

        ],
      ),
    );
  }





  Widget firstCarouseel()
  {
    return new Card(
      elevation: 30.0,
      child:new Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          //first carroussel
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[

              changementText('Brushing (15 €)                     ', Colors.black),
              Card(
                child: IconButton(
                  icon: Icon(Icons.remove_circle),
                  onPressed: ()
                  {
                    if(prestabrushing==0) {
                      setState(() {
                        prestabrushing = 0;
                      });
                    }
                    else
                    {
                      setState(() {
                        prestabrushing--;
                        total=prestabrushing*15+prestacarre*30+prestachignon*30+prestabraids*80+prestafausselocks*50+prestaextension*15+locksdemi*40+lockstete*80+demimeches*25+
                            demisansmeches*20+tetemeches*45+tetesansmeches*35+partielle*25+complete*50+naturel*40+synthetique*30;
                      });
                    }
                  },
                ),

              ),
              changementText('$prestabrushing', Colors.black),
              Card(
                child: IconButton(
                  icon: Icon(Icons.add_circle),
                  onPressed: ()
                  {
                    setState(() {
                      prestabrushing++;
                      total=prestabrushing*15+prestacarre*30+prestachignon*30+prestabraids*80+prestafausselocks*50+prestaextension*15+locksdemi*40+lockstete*80+demimeches*25+
                          demisansmeches*20+tetemeches*45+tetesansmeches*35+partielle*25+complete*50+naturel*40+synthetique*30;
                    });
                  },
                ),

              ),
            ],

          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              changementText('Carré (30 €)                          ', Colors.black),
              Card(
                child: IconButton(
                  icon: Icon(Icons.remove_circle),
                  onPressed: ()
                  {
                    if(prestacarre==0) {
                      setState(() {
                        prestacarre = 0;
                      });
                    }
                    else
                    {
                      setState(() {
                        prestacarre--;
                        total=prestabrushing*15+prestacarre*30+prestachignon*30+prestabraids*80+prestafausselocks*50+prestaextension*15+locksdemi*40+lockstete*80+demimeches*25+
                            demisansmeches*20+tetemeches*45+tetesansmeches*35+partielle*25+complete*50+naturel*40+synthetique*30;
                      });
                    }
                  },
                ),

              ),
              changementText('$prestacarre', Colors.black),
              Card(
                child: IconButton(
                  icon: Icon(Icons.add_circle),
                  onPressed: ()
                  {
                    setState(() {
                      prestacarre++;
                      total=prestabrushing*15+prestacarre*30+prestachignon*30+prestabraids*80+prestafausselocks*50+prestaextension*15+locksdemi*40+lockstete*80+demimeches*25+
                          demisansmeches*20+tetemeches*45+tetesansmeches*35+partielle*25+complete*50+naturel*40+synthetique*30;
                    });
                  },
                ),

              ),


            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              changementText('Chignon (30 €)                     ', Colors.black),
              Card(
                child: IconButton(
                  icon: Icon(Icons.remove_circle),
                  onPressed: ()
                  {
                    if(prestachignon==0) {
                      setState(() {
                        prestachignon = 0;
                      });
                    }
                    else
                    {
                      setState(() {
                        prestachignon--;
                        total=prestabrushing*15+prestacarre*30+prestachignon*30+prestabraids*80+prestafausselocks*50+prestaextension*15+locksdemi*40+lockstete*80+demimeches*25+
                            demisansmeches*20+tetemeches*45+tetesansmeches*35+partielle*25+complete*50+naturel*40+synthetique*30;
                      });
                    }
                  },
                ),

              ),
              changementText('$prestachignon', Colors.black),
              Card(
                child: IconButton(
                  icon: Icon(Icons.add_circle),
                  onPressed: ()
                  {
                    setState(() {
                      prestachignon++;
                      total=prestabrushing*15+prestacarre*30+prestachignon*30+prestabraids*80+prestafausselocks*50+prestaextension*15+locksdemi*40+lockstete*80+demimeches*25+
                          demisansmeches*20+tetemeches*45+tetesansmeches*35+partielle*25+complete*50+naturel*40+synthetique*30;
                    });
                  },
                ),

              ),

            ],

          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              changementText('Braids (80 €)                         ', Colors.black),
              Card(
                child: IconButton(
                  icon: Icon(Icons.remove_circle),
                  onPressed: ()
                  {
                    if(prestabraids==0) {
                      setState(() {
                        prestabraids = 0;
                      });
                    }
                    else
                    {
                      setState(() {
                        prestabraids--;
                        total=prestabrushing*15+prestacarre*30+prestachignon*30+prestabraids*80+prestafausselocks*50+prestaextension*15+locksdemi*40+lockstete*80+demimeches*25+
                            demisansmeches*20+tetemeches*45+tetesansmeches*35+partielle*25+complete*50+naturel*40+synthetique*30;
                      });
                    }
                  },
                ),

              ),
              changementText('$prestabraids', Colors.black),
              Card(
                child: IconButton(
                  icon: Icon(Icons.add_circle),
                  onPressed: ()
                  {
                    setState(() {
                      prestabraids++;
                      total=prestabrushing*15+prestacarre*30+prestachignon*30+prestabraids*80+prestafausselocks*50+prestaextension*15+locksdemi*40+lockstete*80+demimeches*25+
                          demisansmeches*20+tetemeches*45+tetesansmeches*35+partielle*25+complete*50+naturel*40+synthetique*30;
                    });
                  },
                ),

              ),

            ],

          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              changementText('Fausse locks (50 €)              ', Colors.black),
              Card(
                child: IconButton(
                  icon: Icon(Icons.remove_circle),
                  onPressed: ()
                  {
                    if(prestafausselocks==0) {
                      setState(() {
                        prestafausselocks = 0;
                      });
                    }
                    else
                    {
                      setState(() {
                        prestafausselocks--;
                        total=prestabrushing*15+prestacarre*30+prestachignon*30+prestabraids*80+prestafausselocks*50+prestaextension*15+locksdemi*40+lockstete*80+demimeches*25+
                            demisansmeches*20+tetemeches*45+tetesansmeches*35+partielle*25+complete*50+naturel*40+synthetique*30;
                      });
                    }
                  },
                ),

              ),
              changementText('$prestafausselocks', Colors.black),
              Card(
                child: IconButton(
                  icon: Icon(Icons.add_circle),
                  onPressed: ()
                  {
                    setState(() {
                      prestafausselocks++;
                      total=prestabrushing*15+prestacarre*30+prestachignon*30+prestabraids*80+prestafausselocks*50+prestaextension*15+locksdemi*40+lockstete*80+demimeches*25+
                          demisansmeches*20+tetemeches*45+tetesansmeches*35+partielle*25+complete*50+naturel*40+synthetique*30;
                    });
                  },
                ),

              ),

            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              changementText("Pose d'extensions (15 €)     ", Colors.black),
              Card(
                child: IconButton(
                  icon: Icon(Icons.remove_circle),
                  onPressed: ()
                  {
                    if(prestaextension==0) {
                      setState(() {
                        prestaextension = 0;
                      });
                    }
                    else
                    {
                      setState(() {
                        prestaextension--;
                        total=prestabrushing*15+prestacarre*30+prestachignon*30+prestabraids*80+prestafausselocks*50+prestaextension*15+locksdemi*40+lockstete*80+demimeches*25+
                            demisansmeches*20+tetemeches*45+tetesansmeches*35+partielle*25+complete*50+naturel*40+synthetique*30;
                      });
                    }
                  },
                ),

              ),
              changementText('$prestaextension', Colors.black),
              Card(
                child: IconButton(
                  icon: Icon(Icons.add_circle),
                  onPressed: ()
                  {
                    setState(() {
                      prestaextension++;
                      total=prestabrushing*15+prestacarre*30+prestachignon*30+prestabraids*80+prestafausselocks*50+prestaextension*15+locksdemi*40+lockstete*80+demimeches*25+
                          demisansmeches*20+tetemeches*45+tetesansmeches*35+partielle*25+complete*50+naturel*40+synthetique*30;
                    });
                  },
                ),

              ),

            ],

          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              changementText('Locks demi-tête (40 €)       ', Colors.black),
              Card(
                child: IconButton(
                  icon: Icon(Icons.remove_circle),
                  onPressed: ()
                  {
                    if(locksdemi==0) {
                      setState(() {
                        locksdemi = 0;
                      });
                    }
                    else
                    {
                      setState(() {
                        locksdemi--;
                        total=prestabrushing*15+prestacarre*30+prestachignon*30+prestabraids*80+prestafausselocks*50+prestaextension*15+locksdemi*40+lockstete*80+demimeches*25+
                            demisansmeches*20+tetemeches*45+tetesansmeches*35+partielle*25+complete*50+naturel*40+synthetique*30;
                      });
                    }
                  },
                ),

              ),
              changementText('$locksdemi', Colors.black),
              Card(
                child: IconButton(
                  icon: Icon(Icons.add_circle),
                  onPressed: ()
                  {
                    setState(() {
                      locksdemi++;
                      total=prestabrushing*15+prestacarre*30+prestachignon*30+prestabraids*80+prestafausselocks*50+prestaextension*15+locksdemi*40+lockstete*80+demimeches*25+
                          demisansmeches*20+tetemeches*45+tetesansmeches*35+partielle*25+complete*50+naturel*40+synthetique*30;
                    });
                  },
                ),

              ),
            ],

          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              changementText('Locks tête entière (80 €)    ', Colors.black),
              Card(
                child: IconButton(
                  icon: Icon(Icons.remove_circle),
                  onPressed: ()
                  {
                    if(lockstete==0) {
                      setState(() {
                        lockstete = 0;
                      });
                    }
                    else
                    {
                      setState(() {
                        lockstete--;
                        total=prestabrushing*15+prestacarre*30+prestachignon*30+prestabraids*80+prestafausselocks*50+prestaextension*15+locksdemi*40+lockstete*80+demimeches*25+
                            demisansmeches*20+tetemeches*45+tetesansmeches*35+partielle*25+complete*50+naturel*40+synthetique*30;
                      });
                    }
                  },
                ),

              ),
              changementText('$lockstete', Colors.black),
              Card(
                child: IconButton(
                  icon: Icon(Icons.add_circle),
                  onPressed: ()
                  {
                    setState(() {
                      lockstete++;
                      total=prestabrushing*15+prestacarre*30+prestachignon*30+prestabraids*80+prestafausselocks*50+prestaextension*15+locksdemi*40+lockstete*80+demimeches*25+
                          demisansmeches*20+tetemeches*45+tetesansmeches*35+partielle*25+complete*50+naturel*40+synthetique*30;
                    });
                  },
                ),

              ),


            ],

          ),
          //fin first carrroussel

        ],
      ),
    );
  }














//////////////////////////////////////////////




/////COIFFURE//////////////////

Widget coiffureAffichage()
{
  return Swiper(


      itemBuilder: (BuildContext context,int index)
      {
        return Swiper.children(
          children: <Widget>[
            firstCarouseel(),
            secondCarroussel(),

          ],
        );
        //new Image.network('http://via.placeholder.com/288x188',
        //fit: BoxFit.fill,);
      },
      layout: SwiperLayout.TINDER,



      itemWidth: 400.0,
      itemHeight: 470.0,
      itemCount: 2,



    );
}






////////////////




///// SOIN /////////////

Widget affichageSoin(){
    return Card(
      elevation: 30.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              changementText('Soin du visage (40€)   ', Colors.black),
              Card(
                child:IconButton(icon: Icon(Icons.remove_circle),
                  onPressed: ()
                  {
                    if(prestasoinvisage==0)
                    {
                      setState(() {
                        prestasoinvisage=0;
                        total=prestasoinvisage*40+prestasoinbarbe*25;
                      });
                    }
                    else
                      setState(() {
                        prestasoinvisage--;
                        total=prestasoinvisage*40+prestasoinbarbe*25;
                      });
                  },
                ),
              ),
              changementText(
                  '$prestasoinvisage',
                  Colors.black),
              Card(
                child:IconButton(icon: Icon(Icons.add_circle),
                  onPressed: ()
                  {
                    setState(() {
                      prestasoinvisage++;
                      total=prestasoinvisage*40+prestasoinbarbe*25;
                    });
                  },
                ),
              ),

            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              changementText('Soin de la barbe (25 €)', Colors.black),
              Card(
                child:IconButton(icon: Icon(Icons.remove_circle),
                  onPressed: ()
                  {
                    if(prestasoinbarbe==0)
                    {
                      setState(() {
                        prestasoinbarbe=0;
                        total=prestasoinvisage*40+prestasoinbarbe*25;
                      });
                    }
                    else
                      setState(() {
                        prestasoinbarbe--;
                        total=prestasoinvisage*40+prestasoinbarbe*25;
                      });
                  },
                ),
              ),
              changementText(
                  '$prestasoinbarbe',
                  Colors.black),
              Card(
                child:IconButton(icon: Icon(Icons.add_circle),
                  onPressed: ()
                  {
                    setState(() {
                      prestasoinbarbe++;
                      total=prestasoinvisage*40+prestasoinbarbe*25;
                    });
                  },
                ),
              ),


            ],
          ),



        ],
      ),

    );
}







//////////////








/////////////////////////////////////////////////////////////////


}