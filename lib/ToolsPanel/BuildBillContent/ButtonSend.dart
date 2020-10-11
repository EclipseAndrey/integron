import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'Strings.dart';

Widget ButtonSend() {
  return Padding(
    padding: const EdgeInsets.only(top: 18.0, left: 28, right: 28),
    child: FlatButton(
      onPressed: () {},
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.purple),
        borderRadius: BorderRadius.circular(20),

      ),

      color: Colors.purple,
      textColor: Colors.purpleAccent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text(textButtonSend, style: TextStyle(fontFamily: "MPLUS", color: Colors.white, fontSize: 18),),
          ),

        ],
      ),
    ),
  );
}
