import 'package:flutter/material.dart';
import 'package:integron/Style.dart';

void showDialogError(BuildContext context){
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            color: cBG,
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
              Icons.close, color: Colors.redAccent, size: 30,
            ),
          ),
        ),

      );
    },
  );
}