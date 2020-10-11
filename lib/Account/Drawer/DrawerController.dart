import 'package:flutter/material.dart';
import 'package:omega_qick/Account/Drawer/Footer.dart';
import 'package:omega_qick/Account/Drawer/Head.dart';

import 'Body.dart';
import 'Style.dart';

Widget bodyDrawer(BuildContext context){
  return Column(
    children: [
      HeadDrawer(),
      BodyDrawer(context),
      FooterDrawer()
    ],
  );
}

Drawer GeneralDrawer (BuildContext context){
  return Drawer(

    child: Container(

      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: drawerBackgroundGradient,
            begin: Alignment.topLeft,
            end: Alignment.bottomCenter,
          )
      ),
      child: bodyDrawer(context),
    ),
    // this will set the drawer
  );
}