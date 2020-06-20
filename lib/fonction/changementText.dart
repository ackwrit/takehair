import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

class changementText
{
  String text;
  Color couleur;




changementText(String text, Color couleur)
{
  this.text=text;
  this.couleur=couleur;

}



Widget plateforme()
{

    if(Platform.isIOS)
    {
      return new DefaultTextStyle(
          style: new TextStyle(color:couleur,fontSize: 14.0),
          child: new Text(text));

    }
    else
    {
      return new Text(text,style: new TextStyle(color:couleur,fontSize: 14.0));
    }


}


Widget taille(double t)
{
  if(Platform.isIOS)
  {
    return new DefaultTextStyle(
        style: new TextStyle(color:Colors.black,fontSize:t),
        child: new Text(text));

  }
  else
  {
    return new Text(text,style: new TextStyle(color: Colors.black,fontSize: t));
  }
}

}

