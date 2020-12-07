import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:omega_qick/Pages/GeneralControllerPages/Purchase/Formalize/FormalizePage.dart';
import 'Utils/DB/Products/Product.dart';

import 'REST/Category/getItemsCategory.dart';
import 'package:omega_qick/AutoRoutes.dart';
import 'REST/SecureConnection/DBSecure.dart';
import 'REST/SecureConnection/DataSecure.dart';

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

  @override
  void initState() {
   // load();
    cartList = [];
    DataSecureDB(dataSecure: DataSecure(0 ,"null"));
   // ExitAccount();
    AutoRoutes(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(

    );
  }
}
