import 'package:flutter/material.dart';
import 'package:omega_qick/Pages/GeneralControllerPages/Home/Settings.dart';
import 'package:omega_qick/Pages/Login2/Style.dart';
import 'package:omega_qick/REST/HistoryTxs/GetTxs.dart';
import 'package:omega_qick/Utils/DB/TxHistory/Tx.dart';


import '../db.dart';
import 'historyItem.dart';

Widget Content() {

  return SliverList(
    delegate: SliverChildBuilderDelegate(


          (BuildContext context, int i,) {

        return ContentHistory();
      },
      childCount: 1

    ),
  );
}

class ContentHistory extends StatefulWidget {
  @override
  _ContentHistoryState createState() => _ContentHistoryState();
}

class _ContentHistoryState extends State<ContentHistory> {
  bool loading = true;

  List<Tx> txs = [];

  load()async{
    loading =true;
    setState(() {});

    txs = await getTxs();


    loading=false;
    setState(() {});
  }

  @override
  void initState() {
    load();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: loading?Center(child:  CircularProgressIndicator(),):Content(),
    );
  }


  Widget Content (){
    return txs.length == 0?Center(child: Text("У вас пока не было транзакций", style: TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w400, fontStyle: FontStyle.normal, fontFamily: fontFamily),),):Column(
      children: [
        Column(children: List.generate(txs.length, (index) => Padding(
          padding: const EdgeInsets.all(6.0),
          child: historiItem(context, tx: txs[index]),
        )),),
        SizedBox(height: 50,)
      ],
    );
  }
}
