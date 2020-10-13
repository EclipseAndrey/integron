import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:omega_qick/Authorization/Pages/EnterCodePage.dart';
import 'package:omega_qick/Authorization/Pages/GetInfoForUser/GetInfoForUserPage.dart';
import 'package:omega_qick/Authorization/Pages/PageNum2/InpNum.dart';
import 'package:omega_qick/Authorization/Pages/SetCodePage.dart';
import 'package:omega_qick/Authorization/codeDB.dart';
import 'package:omega_qick/Authorization/tokenDB.dart';
import 'package:omega_qick/Login1/Login.dart';
import 'package:omega_qick/Parse/InfoToken.dart';
import 'package:omega_qick/REST/Autorization/checkToken.dart';

import 'Authorization/auto.dart';
import 'LogFile.dart';

void AutoRoutes(BuildContext context)async {


  void tokenErr()async{}

  void tokenOk(InfoToken info)async{
    if(info.code == 0){
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
    String token = await tokenDB();
    if(token != "null"){
      InfoToken infoToken = await checkToken(token);
      if(infoToken != null){
        await tokenOk(infoToken);
      }else{
        infoToken = await checkToken(token);
        if(infoToken != null){
          await tokenOk(infoToken);
        }else{
          await tokenErr();
        }
      }
    }else{
      await autoDB(a: false);
      AutoRoutes(context);
    }
  }else{
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => InpNum()), (route) => false);
  }
}