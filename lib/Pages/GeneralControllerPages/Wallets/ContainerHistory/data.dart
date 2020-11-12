import 'package:flutter/material.dart';

Widget dataWidget(String data) {
  Color c6287A1 = Color.fromRGBO(98, 135, 161, 1);
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Text(
        data,
        style: TextStyle(
          color: c6287A1,
          fontSize: 14,
          fontWeight: FontWeight.w400
        ),
      ),
    ],
  );
}
