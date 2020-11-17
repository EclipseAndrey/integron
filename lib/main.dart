import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:omega_qick/AddWallet/AddWalletPage.dart';
import 'package:omega_qick/Pages/GeneralControllerPages/Purchase/Formalize/FormalizePage.dart';
import 'package:omega_qick/REST/Home/InfoProduct/ProductPost.dart';
import 'REST/Home/Search/getItemCategory.dart';
import 'Utils/DB/Items/Product.dart';
import 'package:omega_qick/AutoRoutes.dart';
import 'Authorization/Pages/EnterCodePage.dart';
import 'REST/SecureConnection/DBSecure.dart';
import 'REST/SecureConnection/DataSecure.dart';

List<Product> cartList = [];

double BALANCE = 0;

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

       //home: Business.edit(),
      //home: GeneralControllerPages(),
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


  load()async{
    List<ProductShort> v = await getItemsCategory(1);
    List<Product> f =[];
    for(int i = 0; i < v.length; i++){
      f.add(await getProductForId(v[i].route));
    }

    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => FormalizePage(f)));
  }




  @override
  void initState() {




   // load();

    cartList = [];
    DataSecureDB(dataSecure: DataSecure(0 ,"null"));

   // ExitAccount();
      AutoRoutes(context);

    //createDir();
  }

  @override
  Widget build(BuildContext context) {
    return Container(

    );
  }
}
