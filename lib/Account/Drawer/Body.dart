

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:omega_qick/Authorization/Pages/DoYouWantSetFinger.dart';
import 'package:omega_qick/Authorization/WalletDB.dart';
import 'package:omega_qick/Authorization/auto.dart';
import 'package:omega_qick/Authorization/codeDB.dart';
import 'package:omega_qick/Authorization/tokenDB.dart';

import '../../main.dart';

Widget BodyDrawer(BuildContext context){
  return Column(
    children: [
      ListTile(
        onTap: (){},
        title: new Text("Кошельки", style: TextStyle(color: Colors.white),),
        leading: new Icon(Icons.account_balance_wallet, color: Colors.white,),
      ),
      Divider(
        color: Colors.white,
        height: 0.1,
      ),
      ListTile(
        title: new Text("Primary", style: TextStyle(color: Colors.white),),
        leading: new Icon(Icons.inbox, color: Colors.white,),
      ),
      ListTile(
        onTap: (){
          showDialogWantFinger(context);
        },

        title: new Text("Отпечаток", style: TextStyle(color: Colors.white),),
        leading: new Icon(Icons.people, color: Colors.white,),
      ),
      ListTile(
        onTap: ()async{
          await autoDB(a: false);
          await codeDB(code: 0);
          await tokenDB(token: "null");
          await DBProvider.db.DeleteWallets();
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Splash()), (route) => false);
          // Navigator.push(context, MaterialPageRoute(builder: (context) => Splash()));
        },
        title: new Text("Exit", style: TextStyle(color: Colors.white),),
        leading: new Icon(Icons.local_offer, color: Colors.white,),
      )
    ],
  );

}