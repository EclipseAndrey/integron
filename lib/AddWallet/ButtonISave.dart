import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:omega_qick/AddWallet/Style.dart';
import 'package:omega_qick/Authorization/Pages/SetCodePage.dart';
import 'package:omega_qick/Authorization/WalletDB.dart';
import 'package:omega_qick/Authorization/codeDB.dart';
import 'package:omega_qick/HomePage/Home.dart';
import 'package:omega_qick/Login1/Login.dart';
import 'package:omega_qick/Parse/parseAddress.dart';
import 'package:omega_qick/REST/getWalletR.dart';
import 'package:omega_qick/balance.dart';

import '../JsonParse.dart';

Widget ButtonISave(BuildContext context, AddressA address) {


  return Padding(
    padding: const EdgeInsets.only(top: 18.0, left: 28, right: 28),
    child: FlatButton(
      onPressed: () async{
        Navigator.of(context).pushNamed('/AddWallet/AddWalletPage');

          WalletData wallet = WalletData(address.mnemonic,address.address);

         //=========================
          DBProvider.db.WalletDB(walletData: wallet);
        //==========================

          if(await codeDB() == 0) Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SetCode()));
          else
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => PageBalance()), (route) => false);//Replacement(context, MaterialPageRoute(builder: (context) => PageBalance()));


      },
      shape: RoundedRectangleBorder(
        side: BorderSide(color: colorBorderSideButtonSave),
        borderRadius: BorderRadius.circular(30),

      ),

      color: colorButtonSave,
      textColor: colorTapButtonSave,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text(textButtonSave, style: styleButtonText,),
          ),
        ],
      ),
    ),
  );
}