import 'package:flutter/material.dart';
import 'package:omega_qick/Pages/Login2/Style.dart';

import 'Head/Colors.dart';
import 'Style.dart';

class EmptyPage extends StatefulWidget {
  @override
  _EmptyPageState createState() => _EmptyPageState();
}

class _EmptyPageState extends State<EmptyPage> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      key: _drawerKey,



      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: cBG,
        shadowColor: Colors.transparent,


      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            color: cBG),
        child: Center(
            child: Text(
          "Место для контента",
          style: TextStyle(
            color: cMainText,
            fontSize: 24,
            fontFamily: "MPLUS",
          ),
        )),
      ),
    );
  }
}
