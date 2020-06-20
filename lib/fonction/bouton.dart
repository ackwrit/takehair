import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:takehair/fonction/changementText.dart';

class bouton
{
  String text;
  Color couleur;
  Color couleurText;




  bouton(text,couleur,couleurText)
  {
    this.text=text;
    this.couleur=couleur;
    this.couleurText=couleurText;
  }



  Widget pressionBouton(String text,VoidCallback direction, Color couleurchangeant)
  {
    changementText message=new changementText(text,couleurText);
    if(Platform.isIOS)
      {
        return CupertinoButton(
          onPressed:direction,
          color: couleurchangeant,
          child: message.plateforme(),

        );
      }
    else
      {
        return RaisedButton(
          onPressed: direction,
          color: couleurchangeant,
          child: message.plateforme(),

        );
      }
  }


  Widget flatBouton(String text,VoidCallback direction)
  {
    changementText message=new changementText(text,this.couleur);
    if(Platform.isIOS)
      return FlatButton(
          onPressed: direction,
          color: this.couleurText,
          child: message.plateforme(),
      );
  }
}