import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget inputSumm(TextEditingController controller){
  return TextField(
    keyboardType: TextInputType.number,

    decoration: InputDecoration(

      hintText: "Сумма DEL",
      hintStyle: TextStyle(
        color: Colors.white38,
      ),
    ),
    controller: controller,
  );
}