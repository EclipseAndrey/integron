import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:omega_qick/Authorization/Cri/AdderABC.dart';
import 'package:omega_qick/Authorization/Pages/EnterCodePage.dart';
import 'package:omega_qick/Authorization/Pages/SetCodePage.dart';
import 'package:omega_qick/AutoRoutes.dart';
import 'file:///C:/Users/koren/AndroidStudioProjects/integron/lib/Utils/fun/LogFile.dart';
import 'package:omega_qick/Login1/Loading.dart';
import 'package:omega_qick/Login1/Login.dart';
import 'package:omega_qick/Login1/Style.dart';
import 'package:omega_qick/Parse/parseAddress.dart';
import 'package:omega_qick/REST/Autorization/AddWalletR.dart';
import 'package:omega_qick/REST/getAddress.dart';
import 'package:omega_qick/REST/getWalletR.dart';
import 'package:omega_qick/Utils/DB/WalletDB.dart';

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
        AutoRoutes(context);
      }else{
        WalletData wallet = WalletData(seed,user.result.address.address);
        await DBProvider.db.WalletDB(walletData: wallet);
        await AddWalletR(true, crypto(seed, address.address), address.address);


        AutoRoutes(context);
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