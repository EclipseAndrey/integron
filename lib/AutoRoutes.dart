import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:omega_qick/Authorization/Pages/EnterCodePage.dart';
import 'package:omega_qick/Authorization/Pages/GetInfoForUser/GetInfoForUserPage.dart';
import 'package:omega_qick/Authorization/Pages/PageNum2/InpNum.dart';
import 'package:omega_qick/Authorization/Pages/SetCodePage.dart';

import 'package:omega_qick/Pages/Login2/PageLogin.dart';
import 'package:omega_qick/Parse/InfoToken.dart';
import 'package:omega_qick/REST/Autorization/checkToken.dart';

import 'Utils/DB/WalletDB.dart';
import 'Utils/DB/auto.dart';
import 'Utils/DB/codeDB.dart';
import 'Utils/DB/tokenDB.dart';
import 'Utils/fun/LogFile.dart';

void AutoRoutes(BuildContext context)async {
  void tokenErr()async{
    print("AUTOROUTES TOKEN ERR");
    await autoDB(a: false);
    AutoRoutes(context);

  }

  void tokenOk(InfoToken info)async{
    if(info.code == 200){
      int code = await codeDB();
      if(code == 0){
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => SetCode()), (route) => false);
      }else{
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => EnterCode()), (route) => false);
      }
    }else if(info.code == 1|| info.code == 2) {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => GetInfoForUserPage()), (route) => false);
    }else if (info.code == 3 ){
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Login()), (route) => false);
    }else {
      tokenErr();
    }
  }

  writeLog("AutoRoutes");
  bool auto = await autoDB();
  if(auto){
    print("AUTOROUTES  auto $auto");
    String token = await tokenDB();
    if(token != "null"){
      print("AUTOROUTES  token $token");
      InfoToken infoToken = await checkToken(token);
      if(infoToken != null){
        print("AUTOROUTES  token response ${infoToken.code}");
        await DBProvider.db.DeleteWallets();
        for(int i = 0; i < infoToken.wallets.length; i++) {
          await DBProvider.db.WalletDB(walletData: infoToken.wallets[i]);
        }
        await tokenOk(infoToken);
      }else{
        infoToken = await checkToken(token);
        if(infoToken != null){
          await tokenOk(infoToken);
        }else{
          print("AUTOROUTES  token error");
          await tokenErr();
        }
      }
    }else{
      await autoDB(a: false);
      AutoRoutes(context);
    }
  }else{
    print("AUTOROUTES F auto $auto");
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Login()), (route) => false);
  }
}