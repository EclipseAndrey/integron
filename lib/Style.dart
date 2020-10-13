import 'package:flutter/material.dart';

List<Color> cardBackgroundGradient = [
Color.fromRGBO(25, 9, 60, 1),
  Color.fromRGBO(50, 18, 122, 1),
];

List<Color> homeBackgroundGradient = [
  Color.fromRGBO(32, 38 , 45, 1),
  Color.fromRGBO(22, 26, 31, 1),
];

Color dialogBackGroundColor = Colors.grey;

ThemeData themeApp = ThemeData(
  // Define the default brightness and colors.
  brightness: Brightness.light,
  primaryColor: homeBackgroundGradient[0],
  accentColor: homeBackgroundGradient[0],

  // Define the default font family.
  fontFamily: 'MPLUS',
  textTheme: TextTheme(
    headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
    headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
    bodyText2: TextStyle(
        fontSize: 18.0, fontFamily: 'Medium', color: Colors.white),
  ),

  // Define the default TextTheme. Use this to specify the default
  // text styling for headlines, titles, bodies of text, and more.
);