import 'package:flutter/material.dart';

Widget nameWidget(String name) {
  Color c6287A1 = Color.fromRGBO(98, 135, 161, 1);
  return Text(
    name,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(
      color: c6287A1,
      fontSize: 14,
    ),
  );
}
