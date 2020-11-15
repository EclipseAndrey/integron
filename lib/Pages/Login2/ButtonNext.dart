import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'package:omega_qick/Pages/CheckCode2/CheckCodePage2.dart';

import 'package:omega_qick/REST/Autorization/GetCode.dart';
import 'package:omega_qick/Utils/fun/DialogLoading/DialogLoading.dart';

import 'Style.dart';

Widget ButtonNext(BuildContext context, TextEditingController controller, MaskTextInputFormatter maskFormatter, bool active){



  Class A = Class();


  return FlatButton(
    onPressed: () async {
      if(active){

        showDialogLoading(context);
        int response = await GetCode("7"+maskFormatter.getUnmaskedText());
        closeDialog(context);
        if (response == null && (response != 200 && response != 201)) {
          Fluttertoast.showToast(
              msg: "Соединение не установлено",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: 16.0);
        } else {
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => CheckCodePage("7"+maskFormatter.getUnmaskedText())), (route) => false);
        }




      }
    },
    shape: RoundedRectangleBorder(
      side: BorderSide(color: cDefault),
      borderRadius: BorderRadius.circular(6),

    ),

    color: !active?cDefault:c8dcde0,
    textColor: Colors.white,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        Padding(
          padding: const EdgeInsets.all(0.0),
          child: Text("Получить СМС", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400, fontStyle: FontStyle.normal),),
        ),

      ],
    ),
  );




}




abstract class AbstractClass {
  int b;
  void printP(){
    print("Hello");
  }

  int Chislo(int n ){
    int count = 0;
    for(int i = 1; i < 100000; i++){
      double step = 0;
      int step3;
      int step2 = i;
      if(i~/10000 > 0){
        step3 = 5;
      }else if(i~/1000 >0){
        step3 =4;
      }else if(i~/100 >0){
        step3 =3;
      }else if(i~/10 >0){
        step3 =2;
      }else if(i~/1 >=0){
        step3 =1;
      }else return 0;

      for(int j = step3; j >=0; j-- ){
        int p = pow(10,j);
        step = step + ( step2 ~/ p);
        step2 %= pow(10,j);
      }
      if((step%step3) == 0){
        count++;
      }
      if(n == count)return i;

    }

  }
}

class Class extends AbstractClass{
  int c;

  @override
  void printP() {
   print(" hahaha");
   super.printP();
  }

}