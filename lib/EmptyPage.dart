import 'package:flutter/material.dart';

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
        backgroundColor: Color.fromRGBO(32, 38 , 45, 1),
        shadowColor: Colors.transparent,


      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: homeBackgroundGradient,
                begin: Alignment.centerLeft,
                end: Alignment.bottomCenter)),
        child: Center(
            child: Text(
          "Место для контента",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontFamily: "MPLUS",
          ),
        )),
      ),
    );
  }
}
