import 'package:flutter/material.dart';
import 'package:omega_qick/Utils/IconDataForCategory.dart';

Widget logo() {


  Widget v1(){
    return Row(
      children: [
        getIconForId(id: 41),
        Text(
          "I N T E G R O N",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
          ),
        ),
        getIconForId(id: 41),
      ],
    );
  }

  return AppBar(
    centerTitle: true,
    leading: Padding(
      padding: EdgeInsets.only(
        bottom: 20,
        right: 13,
      ),
      child: Icon(Icons.attach_money, size: 24),
    ),
    actions: [
      Padding(
        padding: EdgeInsets.only(bottom: 20, right: 10),
        child: Icon(Icons.attach_money, size: 24),
      )
    ],
    title: Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Text(
        "I N T E G R O N",
        style: TextStyle(
          color: Colors.white,
          fontSize: 25,
        ),
      ),
    ),
    backgroundColor: Colors.transparent,
    elevation: 0.0,
  );
}
