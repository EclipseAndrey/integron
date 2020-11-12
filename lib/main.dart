import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:omega_qick/AddWallet/AddWalletPage.dart';
import 'Pages/GeneralControllerPages/GeneralControllerPages.dart';
import 'Pages/GeneralControllerPages/My/PageAddProduct.dart';
import 'Pages/Welcome/Welcome.dart';
import 'Tests/Test.dart';
import 'Utils/DB/Items/Product.dart';
import 'Utils/fun/ExitAccount.dart';
import 'file:///C:/Users/koren/AndroidStudioProjects/integron/lib/Utils/DB/auto.dart';
import 'package:omega_qick/AutoRoutes.dart';
import 'file:///C:/Users/koren/AndroidStudioProjects/integron/lib/Utils/fun/LogFile.dart';


import 'Authorization/Cri/AdderABC.dart';
import 'Authorization/Pages/CheckCode/CheckCodePage.dart';
import 'Authorization/Pages/EnterCodePage.dart';
import 'Authorization/Pages/GetInfoForUser/GetInfoForUserPage.dart';
import 'Authorization/Pages/PageNum/PageNum.dart';
import 'Authorization/Pages/PageNum2/InpNum.dart';
import 'Authorization/Pages/PageNum2/InputNum.dart';
import 'Authorization/Pages/SetCodePage.dart';


import 'Pages/Login2/PageLogin.dart';
import 'PostContent.dart';
import 'REST/SecureConnection/DBSecure.dart';
import 'REST/SecureConnection/DataSecure.dart';
import 'balance.dart';



List<Product> cartList = [];


void main() {


  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //statusBarColor: cBackground,
    systemNavigationBarColor: Color(0xFF000000),
    systemNavigationBarDividerColor: null,
    statusBarColor: null,
    systemNavigationBarIconBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.light,
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  final routes = <String, WidgetBuilder>{
    '/AddWallet/AddWalletPage': (BuildContext context) => GenerateWallet(),
    // '/Login1/Login': (BuildContext context) => Login(),
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
      home: GeneralControllerPages(),
       //home: AddProductPage.empty(),

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
  @override
  void initState() {



    cartList = [];
    DataSecureDB(dataSecure: DataSecure(0 ,"null"));

   // ExitAccount();
    AutoRoutes(context);

    createDir();
  }

  @override
  Widget build(BuildContext context) {
    return Container(

    );
  }
}
