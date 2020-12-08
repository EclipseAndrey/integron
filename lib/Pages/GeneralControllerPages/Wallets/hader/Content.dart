import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:integron/AAPages/Blocs/History/HistoryCubit.dart';
import 'package:integron/Pages/GeneralControllerPages/Home/Settings.dart';
import 'package:integron/Providers/WalletProvider/WalletProvider.dart';
import 'package:integron/Utils/DB/Wallet/Tx.dart';
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

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocBuilder<HistoryCubit,HistoryState>(
        builder: (context, state){
          if(state is HistoryLoading){
            return Center(child: CircularProgressIndicator(),);
          }else if(state is HistoryComplete){
            return Content(state);
          }else{
            return Center(
              //todo err
            );
          }
        },
      )
    );
  }


  Widget Content (HistoryComplete balanceComplete){
    List<Tx> txs = balanceComplete.historyList;

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
