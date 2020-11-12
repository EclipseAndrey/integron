import 'package:flutter/material.dart';

Widget uslugWidget(String uslug) {
  Color c7A8BA3 = Color.fromRGBO(122, 139, 163, 1);
  return Padding(
    padding: const EdgeInsets.only(top: 7),
    child: Text(
      uslug,
      style: TextStyle(
        fontSize: 12,
        color: c7A8BA3,
      ),
    ),
  );
}
