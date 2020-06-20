import 'package:calendar_strip/calendar_strip.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:intl/date_symbol_data_local.dart';

import 'package:takehair/controller/paymentController.dart';

import 'multipleProfessionnelController.dart';





class bookingController extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _homebooking();
  }
}

class _homebooking extends State <bookingController> {

  DateTime daterendzevous = new DateTime.now();


  @override

  Widget build(BuildContext context) {
    initializeDateFormatting('fr_FR');
    // TODO: implement build
    return _Body();
  }

  _Body() {
    return new Center(
        child :new Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        new Text('Disponibilité',style: new TextStyle(fontSize: 20),),
        new CalendarStrip(
            startDate: DateTime.now(),
          endDate: daterendzevous.add(Duration(days: 30)),
          onDateSelected: (_selectDate)
          {
            setState(() {
              daterendzevous=_selectDate;
            });


          },
        ),
        new Text('Le ${DateFormat.MMMMEEEEd('fr_FR').format(daterendzevous)}'),
        new TimePickerSpinner(
          is24HourMode: true,
          isForce2Digits: true,
          highlightedTextStyle: new TextStyle(color: Colors.orange,fontSize:30,),
          minutesInterval: 15,
          normalTextStyle: new TextStyle(color:Colors.black,fontSize: 20),
          onTimeChange: (DateTime _heure)
          {
            setState(() {
              _heure=new DateTime(daterendzevous.year,daterendzevous.month,daterendzevous.day,_heure.hour,_heure.minute);
              daterendzevous=_heure;

            });
          },


        ),
        RaisedButton(
          child: new Text('Valider'),
          onPressed: (){
            directionMultiple();
          },
          shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: Colors.blue[100],
        )

      ],


    )
    );
  }

  directionMultiple()
  {
    Navigator.push(context, new MaterialPageRoute(
        builder: (BuildContext context){
          return new multipleProfessionelController(rendezvous: daterendzevous,);
        }
    ));
  }


}