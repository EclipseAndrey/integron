import 'package:flutter/material.dart';
import 'package:integron/Style.dart';

Widget Buttons(String title, IconData icon, BuildContext context) {
  Color c2f527f = Color.fromRGBO(47, 82, 127, 1);
  return Padding(
    padding: EdgeInsets.only(
        right: MediaQuery.of(context).size.width * 0.04, top: 12),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            blurRadius: 5.0,
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 3,
          )
        ],
      ),
      width: MediaQuery.of(context).size.width * 0.445,
      height: MediaQuery.of(context).size.height * 0.0725,
      child: Center(
          child: Padding(
        padding: EdgeInsets.only(left: 15),
        child: Row(
          children: [
            Center(child: Icon(icon, color: c6287A1)),
            Center(
              child: Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.014),
                child:
                    Text(title, style: TextStyle(fontSize: 16, color: Color.fromRGBO(88, 148, 188, 1))),
              ),
            ),
          ],
        ),
      )),
    ),
  );
}
