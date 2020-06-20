import 'package:firebase_database/firebase_database.dart';
import 'package:takehair/model/dateHelper.dart';
import 'package:takehair/model/user.dart';

class conversation{
  String id;
  user partenaire;
  String last_message;
  String date;

conversation(DataSnapshot snapshot)
{
  this.id = snapshot.value ["monId"];
  this.last_message =snapshot.value['last_message'];
  String stringDate =snapshot.value['dateString'];
  this.date = dateHelper().getDate(stringDate);
  this.partenaire = user(snapshot);
}
}

