import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:omega_qick/Authorization/Pages/EnterCodePage.dart';
import 'package:omega_qick/Authorization/Pages/SetCodePage.dart';
import 'package:omega_qick/Authorization/WalletDB.dart';
import 'package:omega_qick/LogFile.dart';
import 'package:omega_qick/Login1/Loading.dart';
import 'package:omega_qick/Login1/Login.dart';
import 'package:omega_qick/Login1/Style.dart';
import 'package:omega_qick/Parse/parseAddress.dart';
import 'package:omega_qick/REST/getAddress.dart';
import 'package:omega_qick/REST/getWalletR.dart';

import '../JsonParse.dart';
import '../balance.dart';
import 'Strings.dart';




Widget ButtonLogin(BuildContext context, String seed)  {
  return FlatButton(
    onPressed: () async {
      RegExp exp = RegExp(r"[^a-z A-Z]+");
      seed = seed.replaceAll(exp, '');


      AddressA address = await getAddress(seed, context);



      User user = await getUser(address.address, context);
      if(user == null||address == null){
        Fluttertoast.showToast(
            msg: "Соединение не установлено",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0
        );
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
      }else{
        WalletData wallet = WalletData(seed,user.result.address.address);
        DBProvider.db.WalletDB(walletData: wallet);


        Navigator.push(context, MaterialPageRoute(builder: (context) => SetCode()));
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
          child: Text(buttonLoginText, style: styleButtonText,),
        ),

      ],
    ),
  );
}