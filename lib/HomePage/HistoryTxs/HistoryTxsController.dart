import 'dart:async';

import 'package:flutter/material.dart';

import 'package:omega_qick/Contacts/DataBase/GetContactForAddress.dart';
import 'package:omega_qick/Parse/tx.dart';
import 'package:omega_qick/Parse/txs.dart';
import 'package:omega_qick/REST/GetUser.dart';
import 'package:omega_qick/Utils/fun/CasesWorsd/CaseSee.dart';

import '../../JsonParse.dart';
import 'ListHistory.dart';

class HistoryTxs extends StatefulWidget {
  BuildContext context1;

  User user;


  List<dynamic> txs;
  HistoryTxs(this.txs, this.context1, this.user);
  @override
  _HistoryTxsState createState() => _HistoryTxsState();
}

class _HistoryTxsState extends State<HistoryTxs> {



  Timer timer;


  void UpdateData()async{
    User u = await GetUser(widget.user.result.address.address, context);
    widget.user = u;
    widget.txs = u.result.address.txs;

    setState(() {});
  }
  @override
  void initState() {
    UpdateData();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("hash "+ widget.txs[0].hash);
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Column(mainAxisAlignment: MainAxisAlignment.start,
            children: ListHistory(widget.txs, widget.user),
          ),
          Center(child: widget.txs == null? SizedBox():Text("Показано ${widget.txs.length} ${CaseSee(widget.txs.length)}", style: TextStyle(color: Colors.white70),),),

        ],
      ),
    );
  }
}
