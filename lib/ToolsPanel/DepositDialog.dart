import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:omega_qick/QrLib/QrGenerate/QrGenerateController.dart';

import '../JsonParse.dart';
import '../Style.dart';


Future<void> showDepositDialog(BuildContext context, String address) async {
  void copy (){
    Fluttertoast.showToast(
        msg: "Адрес скопирован",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black45,
        textColor: Colors.white,
        fontSize: 16.0
    );
    Clipboard.setData( ClipboardData(text: address));
  }
  return showDialog<void>(

    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: homeBackgroundGradient[0],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),

        ),
        //title: Text('Пополнить', style: TextStyle(color: Colors.white),),
        content: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                color: Colors.white,
                  width: 200,
                  height: 200,
                  child: Center(child: getQr(address))),
              SizedBox(height: 22,),
              GestureDetector(
                onLongPressStart: (info){
                  copy();
                },
                onTap: (){
                  copy();
                },
                child: Text(address ,
                  style: TextStyle(
                  color: Colors.deepPurpleAccent,
                  fontSize: 18,
                  fontFamily: "MPLUS",
                ),),
              )
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Копировать',
              style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFamily: "MPLUS",
            ),),
            onPressed: () {
              copy();

              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: Text('Закрыть',
              style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFamily: "MPLUS",
            ),),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}