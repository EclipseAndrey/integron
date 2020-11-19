import 'package:flutter/material.dart';
import 'package:omega_qick/Pages/Login2/Style.dart';
import 'package:omega_qick/Utils/fun/statusColorWidget.dart';


Widget statusWidget(int status, BuildContext context) {



  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: status == 0?cButtons:cDefault,
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 3),
      child: Center(
          child: Text(status == 0?"Выполнено":"Не выполнено",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 10,
                  color: Colors.white))),
    ),

  );
}
