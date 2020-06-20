import 'package:firebase_database/firebase_database.dart';
import 'package:takehair/model/dateHelper.dart';

class message{
  String from;
  String to;
  String texte;
  String dateString;

  message(DataSnapshot snapshot){
    Map value = snapshot.value;
    from = value['from'];
    to = value ['to'];
    texte = value ['texte'];
    String date=value ['dateString'];
    dateString = dateHelper().getDate(date);

  }
}