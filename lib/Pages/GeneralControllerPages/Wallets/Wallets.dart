import 'package:flutter/material.dart';
import 'package:omega_qick/Pages/GeneralControllerPages/Wallets/db.dart';
import 'package:omega_qick/Pages/GeneralControllerPages/Wallets/hader/Content.dart';
import 'package:omega_qick/Pages/GeneralControllerPages/Wallets/hader/startHader.dart';

import 'hader/logo.dart';
import 'hader/sliverTable.dart';

class Wallet extends StatefulWidget {
  Wallet({Key key}) : super(key: key);

  @override
  _WalletState createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  WorkoutsList wl = WorkoutsList();
  Color cBackground = Color.fromRGBO(250, 250, 250, 1);
  Color cMainBlack = Color.fromRGBO(40, 40, 40, 1);
  Color cb4bfb3 = Color.fromRGBO(180, 191, 179, 1);
  Color c2f527f = Color.fromRGBO(47, 82, 127, 1);
  Color c5894bc = Color.fromRGBO(88, 148, 188, 1);
  Color c6287A1 = Color.fromRGBO(98, 135, 161, 1);
  Color c7A8BA3 = Color.fromRGBO(122, 139, 163, 1);
  Color c8dcde0 = Color.fromRGBO(141, 205, 224, 1);
  Color cDefault = Color.fromRGBO(209, 211, 215, 1);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cBackground,
      body: Stack(
        children: <Widget>[
          Container(
            child: CustomScrollView(
              slivers: <Widget>[
                StartWindow(context),
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
    );
  }
}