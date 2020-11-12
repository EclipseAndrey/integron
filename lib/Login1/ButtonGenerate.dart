import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:omega_qick/Login1/Style.dart';
import 'package:omega_qick/Parse/parseAddress.dart';
import 'package:omega_qick/REST/getAddress.dart';
import 'package:omega_qick/REST/getWalletR.dart';

import '../JsonParse.dart';
import '../Utils/fun/LogFile.dart';
import 'Strings.dart';

Widget ButtonGenerate(BuildContext context, TextEditingController controller) {
  return Padding(
    padding: const EdgeInsets.only(top: 18.0, left: 28, right: 28),
    child: FlatButton(
      onPressed: () async {
        Navigator.of(context).pushNamed('/AddWallet/AddWalletPage');

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
            padding: const EdgeInsets.all(18.0),
            child: Text(buttonGenerateText1, style: styleButtonText,),
          ),
        ],
      ),
    ),
  );
}