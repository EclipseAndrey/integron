import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:omega_qick/InitBalance.dart';
import 'package:omega_qick/InitWallet.dart';
import 'package:omega_qick/Parse/tx.dart';

import '../../JsonParse.dart';
import '../../TimeParse.dart';

Widget itemListHistory(Tx tx, User user){

  bool status = tx.status == "Success"? true:false;
  bool send = user.result.address.address == tx.data.sender?true:false;

  Color color= status == false? Colors.redAccent:send == true? Colors.blue:Colors.greenAccent;
  IconData icon = status == false? Icons.close:send == true? Icons.arrow_upward:Icons.arrow_downward;
  String address = send?tx.to:tx.from;

  return Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
    child: Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(icon, color: color, size: 40,),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:  EdgeInsets.only(top: 8.0, left: 8),
                        child: Text(tx.name == null?InitWallet(address):tx.name, style: TextStyle(color: Colors.white, fontSize: 16),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(InitBalace(tx.data.amount), style: TextStyle(color: color, fontSize: 18),),
                            Text(" DEL", style: TextStyle(color: color, fontSize: 18),),
                          ],
                        ),
                      ),
                    ],

                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(txTimeParseDate(tx.timestamp), style: TextStyle(color: Colors.white54, fontSize: 16),),
                    Padding(
                      padding: EdgeInsets.only(top: 4.0),
                      child: Text(txTimeParseTime(tx.timestamp), style: TextStyle(color: Colors.white54, fontSize: 16),),
                    ),
                  ],
                ),
              )
            ],
          ),
          Divider(color: Colors.white60,)
        ],
      ),
    ),
  );
}