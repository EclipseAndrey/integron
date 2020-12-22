import 'package:flutter/material.dart';
import 'package:integron/Pages/GeneralControllerPages/Wallets/hader/Content.dart';
import 'package:integron/Pages/GeneralControllerPages/Wallets/hader/startHader.dart';
import 'package:integron/Style.dart';
import 'package:flutter/services.dart';

import 'hader/sliverTable.dart';

class Wallet extends StatefulWidget {
  Wallet({Key key}) : super(key: key);

  @override
  _WalletState createState() => _WalletState();
}

class _WalletState extends State<Wallet> {

  @override
  void initState() {
    // SystemChrome.setSystemUIOverlayStyle(
    //   SystemUiOverlayStyle//.dark
    //     (
    //     //statusBarColor: cBackground,
    //     systemNavigationBarColor: Color(0x00cccccc),
    //     systemNavigationBarDividerColor: Color(0x00cccccc),
    //     systemNavigationBarIconBrightness: Brightness.dark,
    //     statusBarColor: Color(0xFFffffff),
    //     statusBarIconBrightness: Brightness.dark,
    //     statusBarBrightness: Brightness.dark,
    //   ),
    // );
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: cBackground,
        body: Stack(
          children: <Widget>[
            Container(
              child: CustomScrollView(
                slivers: <Widget>[
                  StartWindow(),
                  SliverPersistentHeader(
                    //Sliver
                    pinned: true,
                    delegate: MyDynamicHeader(),
                  ),
                  Content(),



                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}