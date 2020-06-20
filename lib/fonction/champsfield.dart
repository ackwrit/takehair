import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

class champsfield
{
  String text;
  bool obscure=true;


  champsfield(String text,bool b)
  {
    this.text=text;
    this.obscure=b;
  }






  Widget creation_champsfield(String data)
  {
   if(Platform.isIOS)
     {
       return CupertinoTextField(
         keyboardType: TextInputType.text,
         obscureText: obscure,
         placeholder: data,
         onChanged: (String frappetext)
         {
           text=frappetext;
         }
         );
     }
   else
     {
       return TextField(
         keyboardType: TextInputType.text,
         obscureText: obscure,
         decoration: InputDecoration(helperText: data,hintText: data),
         onChanged: (String frappe)
         {
           text=frappe;
         },
       );

     }
  }
}