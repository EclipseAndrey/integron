import 'package:flutter/material.dart';
import 'package:integron/Style.dart';

Widget ButtonDown(String title, IconData icon, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(left: 5, top: 12),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 5.0,
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 3,
          )
        ],
      ),
      width: MediaQuery.of(context).size.width * 0.92,
      height: MediaQuery.of(context).size.height * 0.07,
      child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: Icon(icon, color: c6287A1)),
              SizedBox(width: 10),
              Center(
                child: Text(title,
                    style: TextStyle(
                        fontSize: 16, color: Color.fromRGBO(88, 148, 188, 1))),
              ),
            ],
          )),
    ),
  );
}
