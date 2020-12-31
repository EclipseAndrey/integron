import 'package:flutter/material.dart';

Widget type(int uslug) {


  String text = "";

  if(uslug == 0){
    text = "Пополнение";
  }else if(uslug == 1){
    text = "Покупка";
  }else if(uslug == 2){
    text = "Продажа";
  }else{
    text = "Вывод средств";
  }


  Color c7A8BA3 = Color.fromRGBO(122, 139, 163, 1);
  return Padding(
    padding: const EdgeInsets.only(top: 7),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 12,
        color: c7A8BA3,
      ),
    ),
  );
}
