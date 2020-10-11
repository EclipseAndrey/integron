import 'package:flutter/material.dart';

import '../Style.dart';
import 'Drawer/DrawerController.dart';



class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Drawer(

        child: Container(

          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: homeBackgroundGradient,
                begin: Alignment.topLeft,
                end: Alignment.bottomCenter,
              )
          ),
          child:  GeneralDrawer(context),
        ),
        // this will set the drawer
      ),
      key: _drawerKey,



      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromRGBO(32, 38 , 45, 1),
        shadowColor: Colors.transparent,

        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.menu,
              color: Colors.white,
            ),
            onPressed: () {
              _drawerKey.currentState.openEndDrawer();
            },
          )
        ],
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Аккаунт",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontFamily: "MPLUS",
                  ),
                ),
                Text(
                  "Место для контента",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontFamily: "MPLUS",
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
