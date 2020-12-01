import 'package:flutter/material.dart';
import 'package:omega_qick/Pages/GeneralControllerPages/Wallets/hader/Content.dart';
import 'package:omega_qick/Pages/GeneralControllerPages/Wallets/hader/startHader.dart';
import 'package:omega_qick/Style.dart';

import 'hader/sliverTable.dart';

class Wallet extends StatefulWidget {
  Wallet({Key key}) : super(key: key);

  @override
  _WalletState createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}