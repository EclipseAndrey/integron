import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:omega_qick/Authorization/Pages/CheckCode/CheckCodePage.dart';
import 'package:omega_qick/Authorization/Pages/EnterCodePage.dart';
import 'package:omega_qick/Authorization/Pages/SetCodePage.dart';

import 'package:omega_qick/JsonParse.dart';
import 'file:///C:/Users/koren/AndroidStudioProjects/integron/lib/Utils/fun/LogFile.dart';
import 'package:omega_qick/Login1/Loading.dart';
import 'package:omega_qick/Login1/Login.dart';
import 'package:omega_qick/Login1/Style.dart';
import 'package:omega_qick/Parse/CheckCode.dart';
import 'package:omega_qick/Parse/parseAddress.dart';
import 'package:omega_qick/REST/Autorization/GetCode.dart';
import 'package:omega_qick/REST/getAddress.dart';
import 'package:omega_qick/REST/getWalletR.dart';

import 'Strings.dart';

Widget ButtonLogin(BuildContext context, String num) {
  return FlatButton(
    onPressed: () async {
      int response = await GetCode(num);

      if (response == null || response != 200) {
        Fluttertoast.showToast(
            msg: "Соединение не установлено",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => CheckCodePage(num)));
      }
    },
    shape: RoundedRectangleBorder(
      side: BorderSide(color: colorBorderSideButton),
      borderRadius: BorderRadius.circular(30),
    ),
    color: colorButton,
    textColor: colorTapButton,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(0.0),
          child: Text(
            buttonLoginText,
            style: styleButtonText,
          ),
        ),
      ],
    ),
  );
}
