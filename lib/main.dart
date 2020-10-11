import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:omega_qick/AddWallet/AddWalletPage.dart';
import 'package:omega_qick/Authorization/auto.dart';
import 'package:omega_qick/LogFile.dart';

import 'Authorization/Cri/AdderABC.dart';
import 'Authorization/Pages/EnterCodePage.dart';
import 'Authorization/Pages/SetCodePage.dart';
import 'Login1/Login.dart';
import 'balance.dart';


void main() {


  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Color.fromRGBO(32, 38 , 45, 1), // status bar color
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  final routes = <String, WidgetBuilder>{
    '/AddWallet/AddWalletPage': (BuildContext context) => GenerateWallet(),
    '/Login1/Login': (BuildContext context) => Login(),
    'EnterCode': (BuildContext context) => EnterCode(),

    // '/Autorizatoin/Pages/EnterCodePage': (BuildContext context) => EnterCode(),

  };
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
     // home: GenerateWallet(),
     //   home: Login(),
      home: Splash(),
      routes: routes,
    );
  }
}

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}



// ignore: must_call_super
class _SplashState extends State<Splash> {



void loading()async {
  writeLog("START APP");
  await autoDB()?Navigator.of(context).pushReplacementNamed('EnterCode'):Navigator.of(context).pushReplacementNamed('/Login1/Login');

}

  @override
  void initState() {
    loading();
    createDir();
  }

  @override
  Widget build(BuildContext context) {
    return Container(

    );
  }
}
