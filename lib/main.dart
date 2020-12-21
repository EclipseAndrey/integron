import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:integron/AutoRoutes.dart';
import 'package:integron/Pages/GeneralControllerPages/Purchase/Formalize/FormalizePage.dart';
import 'package:integron/Utils/DB/Wallet/Filters.dart';
import 'Utils/DB/Products/Product.dart';

import 'REST/Category/getItemsCategory.dart';
import 'REST/SecureConnection/DBSecure.dart';
import 'REST/SecureConnection/DataSecure.dart';
import 'package:integron/Utils/fun/Logs.dart';


List<Product> cartList = [];
// double BALANCE = 0;

void main() {



  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light
  //       (
  //   //statusBarColor: cBackground,
  //   systemNavigationBarColor: Color(0xFF000000),
  //   systemNavigationBarDividerColor: null,
  //   statusBarColor: null,
  //   systemNavigationBarIconBrightness: Brightness.light,
  //   statusBarIconBrightness: Brightness.dark,
  //   statusBarBrightness: Brightness.light,
  // ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: GenerateWallet(),
       //home: Business.edit(),
      //home: GeneralControllerPages(),
       home: Splash(),
    );
  }
}

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}


class _SplashState extends State<Splash> {

  start()async{
    printL("Hello Logs");
    await sendLogs();
    // load();
    cartList = [];
    DataSecureDB(dataSecure: DataSecure(0 ,"null"));
    // ExitAccount();
    AutoRoutes(context);
  }

  @override
  void initState() {
    start();
  }

  @override
  Widget build(BuildContext context) {
    return Container(

    );
  }
}
