import 'package:flutter/material.dart';

Widget button() {
  return Container(
    width: 160,
    height: 80,
    padding: EdgeInsets.only(bottom: 18),
    child: RaisedButton(
      color: Color.fromRGBO(215, 219, 224, 1),
      child: Text(
        "Получить СМС",
        style: TextStyle(
          fontSize: 15,
          color: Colors.white,
        ),
      ),
    ),
  );
}
