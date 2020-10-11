import 'package:flutter/material.dart';
import 'package:omega_qick/Style.dart';

void showDialogOk(BuildContext context){
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            color: dialogBackGroundColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25)
            ),

          ),
          width: 0,
          height: 80,
          child: Center(
            child: new Icon(
              Icons.check, color: Colors.greenAccent, size: 30,
            ),
          ),
        ),

      );
    },
  );
}