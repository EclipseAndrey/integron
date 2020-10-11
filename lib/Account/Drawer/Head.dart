import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Style.dart';

Widget HeadDrawer() {
  return
    UserAccountsDrawerHeader(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: headBackgroundGradient, begin: Alignment.topLeft, end: Alignment.bottomCenter),

      ),
      accountName: Text("Иван В. В."),
      accountEmail: Text("+7 (900) 213-12-11"),
      currentAccountPicture: CircleAvatar(
        backgroundColor: Colors.white,
        child: Text("Photo"),
      ),
      otherAccountsPictures: <Widget>[
        CircleAvatar(
          backgroundColor: Colors.white24,
          child: Icon(Icons.settings),
        )
      ],
    );
}