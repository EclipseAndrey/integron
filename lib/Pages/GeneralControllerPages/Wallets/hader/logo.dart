import 'package:flutter/material.dart';
import 'package:integron/Utils/IconDataForCategory.dart';

Widget logo() {


  Widget v1(){
    return Row(
      children: [
        getIconSvg(id: 41),
        Text(
          "I N T E G R O N",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
          ),
        ),
        getIconSvg(id: 41),
      ],
    );
  }

  return AppBar(
    centerTitle: true,
    // leading:  Padding(
    //   padding: const EdgeInsets.all(16.0),
    //   child: getIconForId(id: 41, color: cBG, size: 24),
    // ),
    // leading: Padding(
    //   padding: EdgeInsets.only(
    //     bottom: 20,
    //     right: 13,
    //   ),
    //   child: Icon(Icons.attach_money, size: 24),
    // ),
    // actions: [
    //   Padding(
    //     padding: EdgeInsets.only(bottom: 20, right: 10),
    //     child: Icon(Icons.attach_money, size: 24),
    //   )
    // ],
    title: Padding(
      padding: const EdgeInsets.only(bottom: 0),
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
