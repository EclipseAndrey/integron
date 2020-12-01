import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:omega_qick/Pages/Login2/PageLogin.dart';
import 'package:omega_qick/Utils/DB/Autorization/InfoToken/InfoToken.dart';
import 'package:omega_qick/REST/Autorization/checkToken.dart';
import 'package:omega_qick/Pages/Login2/CodePages/SetCodePage.dart';
import 'package:omega_qick/Pages/Login2/CodePages/EnterCodePage.dart';
import 'Utils/DB/auto.dart';
import 'Utils/DB/codeDB.dart';
import 'Utils/DB/tokenDB.dart';

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
      //Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => GetInfoForUserPage()), (route) => false);
      tokenErr();
    }else if (info.code == 3 ){
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Login()), (route) => false);
    }else {
      tokenErr();
    }
  }

  print("AutoRoutes");
  bool auto = await autoDB();
  if(auto){
    print("AUTOROUTES  auto $auto");
    String token = await tokenDB();
    if(token != "null"){
      print("AUTOROUTES  token $token");
      InfoToken infoToken = await checkToken();
      if(infoToken != null){
        print("AUTOROUTES  token response ${infoToken.code}");
        await tokenOk(infoToken);
      }else{
        infoToken = await checkToken();
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