import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';



Widget getIconForId( {@required int id, Color color, double size}){

  String icon (String name, {bool active}){
    String path = "lib/assets/icons/normal/";
    if(active != null)path="lib/assets/icons/active/";
    String ex = ".svg";
    return path+name+ex;
  }

  String iconName;

  int count = 56;
  if(id < 0||id >= count)id=0;

  switch(id){
    case 0: iconName =icon("Arrow-left"); break;
    case 1: iconName =icon("Arrow-right"); break;
    case 2: iconName =icon("Arrow-right-left"); break;
    case 3: iconName =icon("Bitcoin"); break;
    case 4: iconName =icon("Book"); break;
    case 5: iconName =icon("Business"); break;
    case 6: iconName =icon("Car"); break;
    case 7: iconName =icon("Card"); break;
    case 8: iconName =icon("Close"); break;
    case 9: iconName =icon("Discount"); break;
    case 10: iconName =icon("Edit"); break;
    case 11: iconName =icon("Edit-sm"); break;
    case 12: iconName =icon("Envelope"); break;
    case 13: iconName =icon("Eye"); break;
    case 14: iconName =icon("Eye-closed"); break;
    case 15: iconName =icon("Favorites"); break;
    case 16: iconName =icon("Favorites-sm"); break;
    case 17: iconName =icon("Favorites-sm-inact"); break;
    case 18: iconName =icon("Favorites-sm-norm"); break;
    case 19: iconName =icon("Filter"); break;
    case 20: iconName =icon("Games"); break;
    case 21: iconName =icon("Home"); break;
    case 22: iconName =icon("Image"); break;
    case 23: iconName =icon("Langarie"); break;
    case 24: iconName =icon("Menu"); break;
    case 25: iconName =icon("Messages"); break;
    case 26: iconName =icon("Mobile"); break;
    case 27: iconName =icon("Money"); break;
    case 28: iconName =icon("Money-stack"); break;
    case 29: iconName =icon("More"); break;
    case 30: iconName =icon("Move-top"); break;
    case 31: iconName =icon("Phone"); break;
    case 32: iconName =icon("Pizza"); break;
    case 33: iconName =icon("Plus"); break;
    case 34: iconName =icon("Preferences"); break;
    case 35: iconName =icon("QR-big"); break;
    case 36: iconName =icon("Question"); break;
    case 37: iconName =icon("Refresh"); break;
    case 38: iconName =icon("Roll-down"); break;
    case 39: iconName =icon("Roll-rigth"); break;
    case 40: iconName =icon("Same"); break;
    case 41: iconName =icon("Scan"); break;
    case 42: iconName =icon("Search"); break;
    case 43: iconName =icon("Share"); break;
    case 44: iconName =icon("Shop"); break;
    case 45: iconName =icon("Sun"); break;
    case 46: iconName =icon("Table-Games"); break;
    case 47: iconName =icon("Urer-simple"); break;
    case 48: iconName =icon("User"); break;
    case 49: iconName =icon("Wallet"); break;
    case 50: iconName =icon("Business", active: true); break;
    case 51: iconName =icon("Cart", active: true); break;
    case 52: iconName =icon("Home", active: true); break;
    case 53: iconName =icon("User", active: true); break;
    case 54: iconName =icon("Wallet", active: true); break;
    case 55: iconName =icon("Cart"); break;

  }


    final String assetName = iconName;
    final  Widget svg =

    SvgPicture.asset(

    assetName,
    height: size!=null?size:24,
    width: size!=null?size:24,
    color: color!=null?color:Colors.white,

    semanticsLabel: 'Acme Logo'
  );

  return svg;
}

